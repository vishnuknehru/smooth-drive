"""Match OSM corridor data to a route and extract upcoming driving events.

The route is resampled at a regular spacing; each sample is snapped to the
nearest OSM way that runs in the same direction (bearing-filtered, so parallel
and crossing roads don't match). Speed-limit transitions, traffic signals and
roundabouts are then projected onto the route as events ordered by distance
from the start.
"""

import math
from collections import defaultdict
from dataclasses import dataclass

from smoothdrive.domain.models import Coordinate, Event, EventType, Route
from smoothdrive.domain.osm import CorridorData, OSMNode, OSMWay
from smoothdrive.services.geometry import (
    EARTH_RADIUS_M,
    bearing_deg,
    bearing_difference_deg,
    cumulative_distances_m,
    point_to_segment_m,
    project_onto_polyline,
)
from smoothdrive.services.maxspeed import parse_maxspeed_mph

SAMPLE_SPACING_M = 20.0
MAX_WAY_OFFSET_M = 25.0
MAX_BEARING_DIFF_DEG = 35.0
MAX_NODE_OFFSET_M = 25.0
# Signal heads within this route distance belong to the same junction
SIGNAL_CLUSTER_M = 60.0
ROUNDABOUT_CLUSTER_M = 100.0
# A new speed limit must hold for this many consecutive samples before we
# believe it — filters out one-sample flickers from junction link ways.
SPEED_PERSIST_SAMPLES = 3
_GRID_CELL_M = 200.0

_ROUNDABOUT_JUNCTIONS = {"roundabout", "circular"}


@dataclass
class _Sample:
    location: Coordinate
    along_m: float
    bearing: float


class _SegmentIndex:
    """Spatial hash of way segments so snapping isn't O(samples × segments)."""

    def __init__(self, ways: list[OSMWay], reference: Coordinate) -> None:
        self._cos_lat = math.cos(math.radians(reference.lat))
        self._cells: dict[tuple[int, int], list[tuple[OSMWay, int]]] = defaultdict(list)
        for way in ways:
            for i in range(len(way.geometry) - 1):
                cells = {self._cell(way.geometry[i]), self._cell(way.geometry[i + 1])}
                for cell in cells:
                    self._cells[cell].append((way, i))

    def _cell(self, point: Coordinate) -> tuple[int, int]:
        x = math.radians(point.lon) * self._cos_lat * EARTH_RADIUS_M
        y = math.radians(point.lat) * EARTH_RADIUS_M
        return int(x // _GRID_CELL_M), int(y // _GRID_CELL_M)

    def near(self, point: Coordinate) -> list[tuple[OSMWay, int]]:
        cx, cy = self._cell(point)
        found: list[tuple[OSMWay, int]] = []
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                found.extend(self._cells.get((cx + dx, cy + dy), ()))
        return found


def _resample(route: Route, cumdist: list[float]) -> list[_Sample]:
    """Evenly spaced positions along the route with the local travel bearing."""
    samples: list[_Sample] = []
    total = cumdist[-1]
    target = 0.0
    segment = 0
    while target <= total and segment < len(route.geometry) - 1:
        while segment < len(route.geometry) - 2 and cumdist[segment + 1] < target:
            segment += 1
        seg_len = cumdist[segment + 1] - cumdist[segment]
        t = 0.0 if seg_len == 0 else (target - cumdist[segment]) / seg_len
        a, b = route.geometry[segment], route.geometry[segment + 1]
        samples.append(
            _Sample(
                location=Coordinate(lat=a.lat + t * (b.lat - a.lat), lon=a.lon + t * (b.lon - a.lon)),
                along_m=target,
                bearing=bearing_deg(a, b),
            )
        )
        target += SAMPLE_SPACING_M
    return samples


def _snap_to_way(sample: _Sample, index: _SegmentIndex) -> OSMWay | None:
    best_way: OSMWay | None = None
    best_offset = MAX_WAY_OFFSET_M
    for way, i in index.near(sample.location):
        seg_bearing = bearing_deg(way.geometry[i], way.geometry[i + 1])
        if bearing_difference_deg(seg_bearing, sample.bearing) > MAX_BEARING_DIFF_DEG:
            continue
        offset, _ = point_to_segment_m(sample.location, way.geometry[i], way.geometry[i + 1])
        if offset < best_offset:
            best_offset = offset
            best_way = way
    return best_way


def _speed_limit_events(samples: list[_Sample], index: _SegmentIndex) -> list[Event]:
    limits: list[int | None] = []
    for sample in samples:
        way = _snap_to_way(sample, index)
        if way is None:
            limits.append(None)
        else:
            limits.append(
                parse_maxspeed_mph(way.tags.get("maxspeed"), way.tags.get("highway"))
            )

    events: list[Event] = []
    current: int | None = None
    for i, limit in enumerate(limits):
        if limit is None or limit == current:
            continue
        # Require the new limit to persist before trusting it
        window = limits[i : i + SPEED_PERSIST_SAMPLES]
        confirmed = [v for v in window if v is not None]
        if len(window) >= SPEED_PERSIST_SAMPLES and any(v != limit for v in confirmed):
            continue
        events.append(
            Event(
                type=EventType.SPEED_LIMIT,
                distance_meters=samples[i].along_m,
                location=samples[i].location,
                value_mph=limit,
            )
        )
        current = limit
    return events


def _project_nodes(
    nodes: list[OSMNode], route: Route, cumdist: list[float]
) -> list[tuple[float, OSMNode]]:
    projected = []
    for node in nodes:
        along, offset = project_onto_polyline(node.location, route.geometry, cumdist)
        if offset <= MAX_NODE_OFFSET_M:
            projected.append((along, node))
    projected.sort(key=lambda item: item[0])
    return projected


def _cluster(
    positions: list[tuple[float, Coordinate]], cluster_distance_m: float
) -> list[tuple[float, Coordinate]]:
    """Collapse positions within cluster_distance_m of each other, keeping the first."""
    clustered: list[tuple[float, Coordinate]] = []
    for along, location in positions:
        if clustered and along - clustered[-1][0] < cluster_distance_m:
            continue
        clustered.append((along, location))
    return clustered


def _signal_events(corridor: CorridorData, route: Route, cumdist: list[float]) -> list[Event]:
    signals = [n for n in corridor.nodes if n.tags.get("highway") == "traffic_signals"]
    positions = [(along, node.location) for along, node in _project_nodes(signals, route, cumdist)]
    return [
        Event(type=EventType.TRAFFIC_SIGNAL, distance_meters=along, location=location)
        for along, location in _cluster(positions, SIGNAL_CLUSTER_M)
    ]


def _roundabout_events(corridor: CorridorData, route: Route, cumdist: list[float]) -> list[Event]:
    positions: list[tuple[float, Coordinate]] = []

    # A roundabout is usually mapped as one or more ways tagged junction=roundabout;
    # its entry point is the first of its points the route reaches.
    for way in corridor.ways:
        if way.tags.get("junction") not in _ROUNDABOUT_JUNCTIONS:
            continue
        best: tuple[float, Coordinate] | None = None
        for point in way.geometry:
            along, offset = project_onto_polyline(point, route.geometry, cumdist)
            if offset <= MAX_NODE_OFFSET_M and (best is None or along < best[0]):
                best = (along, point)
        if best:
            positions.append(best)

    minis = [n for n in corridor.nodes if n.tags.get("highway") == "mini_roundabout"]
    positions.extend(
        (along, node.location) for along, node in _project_nodes(minis, route, cumdist)
    )

    positions.sort(key=lambda item: item[0])
    return [
        Event(type=EventType.ROUNDABOUT, distance_meters=along, location=location)
        for along, location in _cluster(positions, ROUNDABOUT_CLUSTER_M)
    ]


def extract_events(route: Route, corridor: CorridorData) -> list[Event]:
    cumdist = cumulative_distances_m(route.geometry)
    index = _SegmentIndex(corridor.ways, route.geometry[0])
    samples = _resample(route, cumdist)

    events = _speed_limit_events(samples, index)
    events.extend(_signal_events(corridor, route, cumdist))
    events.extend(_roundabout_events(corridor, route, cumdist))
    events.sort(key=lambda event: event.distance_meters)
    return events
