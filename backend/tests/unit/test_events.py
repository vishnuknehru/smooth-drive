from smoothdrive.domain.models import Coordinate, EventType, Route
from smoothdrive.domain.osm import CorridorData, OSMNode, OSMWay
from smoothdrive.services.events import extract_events

# Straight ~2.2 km south-to-north route at longitude 0
ROUTE = Route(
    geometry=[Coordinate(lat=51.0 + i * 0.002, lon=0.0) for i in range(11)],
    distance_meters=2224,
)


def _way(way_id: int, lat_from: float, lat_to: float, tags: dict[str, str]) -> OSMWay:
    """A way overlapping the route between two latitudes."""
    return OSMWay(
        id=way_id,
        tags=tags,
        geometry=[Coordinate(lat=lat_from, lon=0.0), Coordinate(lat=lat_to, lon=0.0)],
    )


def test_speed_limit_transition_detected() -> None:
    corridor = CorridorData(
        ways=[
            _way(1, 51.0, 51.010, {"highway": "primary", "maxspeed": "40 mph"}),
            _way(2, 51.010, 51.020, {"highway": "primary", "maxspeed": "30 mph"}),
        ],
        nodes=[],
    )
    events = extract_events(ROUTE, corridor)
    speed_events = [e for e in events if e.type == EventType.SPEED_LIMIT]
    assert [e.value_mph for e in speed_events] == [40, 30]
    # The transition happens about halfway along (51.010 ≈ 1112 m)
    assert 1000 < speed_events[1].distance_meters < 1250


def test_unmatched_gap_does_not_duplicate_limit() -> None:
    # Same limit before and after a gap with no way data: one event, not two
    corridor = CorridorData(
        ways=[
            _way(1, 51.0, 51.008, {"highway": "primary", "maxspeed": "30 mph"}),
            _way(2, 51.012, 51.020, {"highway": "primary", "maxspeed": "30 mph"}),
        ],
        nodes=[],
    )
    events = extract_events(ROUTE, corridor)
    speed_events = [e for e in events if e.type == EventType.SPEED_LIMIT]
    assert [e.value_mph for e in speed_events] == [30]


def test_crossing_road_is_ignored() -> None:
    # An east-west 60 mph road crossing mid-route must not affect limits
    crossing = OSMWay(
        id=9,
        tags={"highway": "primary", "maxspeed": "60 mph"},
        geometry=[Coordinate(lat=51.010, lon=-0.002), Coordinate(lat=51.010, lon=0.002)],
    )
    corridor = CorridorData(
        ways=[_way(1, 51.0, 51.020, {"highway": "primary", "maxspeed": "30 mph"}), crossing],
        nodes=[],
    )
    events = extract_events(ROUTE, corridor)
    speed_events = [e for e in events if e.type == EventType.SPEED_LIMIT]
    assert [e.value_mph for e in speed_events] == [30]


def test_traffic_signals_clustered_per_junction() -> None:
    # Two signal heads 20 m apart (one junction) plus one much further on
    corridor = CorridorData(
        ways=[],
        nodes=[
            OSMNode(id=1, tags={"highway": "traffic_signals"}, location=Coordinate(lat=51.004, lon=0.0)),
            OSMNode(id=2, tags={"highway": "traffic_signals"}, location=Coordinate(lat=51.00418, lon=0.0)),
            OSMNode(id=3, tags={"highway": "traffic_signals"}, location=Coordinate(lat=51.016, lon=0.0)),
        ],
    )
    events = extract_events(ROUTE, corridor)
    signals = [e for e in events if e.type == EventType.TRAFFIC_SIGNAL]
    assert len(signals) == 2


def test_signal_off_route_is_ignored() -> None:
    # A signal ~140 m east of the route is on another road
    corridor = CorridorData(
        ways=[],
        nodes=[
            OSMNode(id=1, tags={"highway": "traffic_signals"}, location=Coordinate(lat=51.004, lon=0.002)),
        ],
    )
    events = extract_events(ROUTE, corridor)
    assert events == []


def test_roundabout_way_reported_once_at_entry() -> None:
    # A roundabout split into two ways near the same spot on the route
    corridor = CorridorData(
        ways=[
            OSMWay(
                id=1,
                tags={"highway": "primary", "junction": "roundabout"},
                geometry=[Coordinate(lat=51.008, lon=0.0), Coordinate(lat=51.0081, lon=0.0001)],
            ),
            OSMWay(
                id=2,
                tags={"highway": "primary", "junction": "roundabout"},
                geometry=[Coordinate(lat=51.0081, lon=0.0001), Coordinate(lat=51.0082, lon=0.0)],
            ),
        ],
        nodes=[],
    )
    events = extract_events(ROUTE, corridor)
    roundabouts = [e for e in events if e.type == EventType.ROUNDABOUT]
    assert len(roundabouts) == 1
    assert roundabouts[0].distance_meters < 1000


def test_mini_roundabout_node_detected() -> None:
    corridor = CorridorData(
        ways=[],
        nodes=[
            OSMNode(id=1, tags={"highway": "mini_roundabout"}, location=Coordinate(lat=51.006, lon=0.0)),
        ],
    )
    events = extract_events(ROUTE, corridor)
    assert [e.type for e in events] == [EventType.ROUNDABOUT]


def test_events_sorted_by_distance() -> None:
    corridor = CorridorData(
        ways=[
            _way(1, 51.0, 51.010, {"highway": "primary", "maxspeed": "40 mph"}),
            _way(2, 51.010, 51.020, {"highway": "primary", "maxspeed": "30 mph"}),
        ],
        nodes=[
            OSMNode(id=1, tags={"highway": "traffic_signals"}, location=Coordinate(lat=51.004, lon=0.0)),
        ],
    )
    events = extract_events(ROUTE, corridor)
    distances = [e.distance_meters for e in events]
    assert distances == sorted(distances)
