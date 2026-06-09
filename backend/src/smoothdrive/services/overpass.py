"""Overpass API client: fetch OSM ways and nodes in a corridor around a route."""

import asyncio

import httpx

from smoothdrive.config import get_settings
from smoothdrive.domain.models import Coordinate, Route
from smoothdrive.domain.osm import CorridorData, OSMNode, OSMWay
from smoothdrive.services.geometry import downsample, haversine_m

# Way types a car can drive on; everything else in the corridor is noise.
DRIVABLE_HIGHWAYS = (
    "motorway|motorway_link|trunk|trunk_link|primary|primary_link"
    "|secondary|secondary_link|tertiary|tertiary_link"
    "|unclassified|residential|living_street|service"
)

# Spacing of the polyline points fed to the around: filter. Coarser than the
# corridor width would punch gaps in the corridor, so keep it comfortably below.
_AROUND_SPACING_M = 40.0

# Corridor queries over very long polylines time out on public Overpass
# instances, so long routes are fetched in chunks and merged.
_CHUNK_LENGTH_M = 8_000.0
_CHUNK_PAUSE_S = 2.0


class OverpassError(Exception):
    pass


# Public Overpass instances reject generic client user agents (406); OSM
# etiquette asks for an identifiable one with contact details.
USER_AGENT = "SmoothDrive-prototype/0.1 (https://github.com/vishnuknehru/smooth-drive)"


def chunk_polyline(points: list[Coordinate], chunk_length_m: float = _CHUNK_LENGTH_M) -> list[list[Coordinate]]:
    """Split a polyline into pieces of roughly chunk_length_m.

    Consecutive chunks share their boundary point so the corridor has no gaps.
    """
    chunks: list[list[Coordinate]] = []
    current = [points[0]]
    length = 0.0
    for previous, point in zip(points, points[1:]):
        current.append(point)
        length += haversine_m(previous, point)
        if length >= chunk_length_m:
            chunks.append(current)
            current = [point]
            length = 0.0
    if len(current) >= 2:
        chunks.append(current)
    return chunks


def build_corridor_query(
    points: list[Coordinate], corridor_width_m: float, timeout_s: int = 90
) -> str:
    points = downsample(points, _AROUND_SPACING_M)
    linestring = ",".join(f"{p.lat:.6f},{p.lon:.6f}" for p in points)
    around = f"(around:{corridor_width_m:.0f},{linestring})"
    return (
        f"[out:json][timeout:{timeout_s}];"
        f"("
        f'way{around}["highway"~"^({DRIVABLE_HIGHWAYS})$"];'
        f'node{around}["highway"~"^(traffic_signals|mini_roundabout)$"];'
        f");"
        f"out body geom;"
    )


def parse_response(data: dict) -> CorridorData:
    ways: list[OSMWay] = []
    nodes: list[OSMNode] = []
    for element in data.get("elements", []):
        tags = element.get("tags", {})
        if element["type"] == "way":
            geometry = [
                Coordinate(lat=p["lat"], lon=p["lon"]) for p in element.get("geometry", [])
            ]
            if len(geometry) >= 2:
                ways.append(OSMWay(id=element["id"], tags=tags, geometry=geometry))
        elif element["type"] == "node":
            nodes.append(
                OSMNode(
                    id=element["id"],
                    tags=tags,
                    location=Coordinate(lat=element["lat"], lon=element["lon"]),
                )
            )
    return CorridorData(ways=ways, nodes=nodes)


class OverpassService:
    def __init__(self, base_url: str | None = None) -> None:
        settings = get_settings()
        self._base_url = base_url or settings.overpass_base_url
        self._corridor_width_m = settings.corridor_width_m

    async def fetch_corridor(self, route: Route) -> CorridorData:
        chunks = chunk_polyline(route.geometry)
        ways: dict[int, OSMWay] = {}
        nodes: dict[int, OSMNode] = {}
        async with httpx.AsyncClient(timeout=120, headers={"User-Agent": USER_AGENT}) as client:
            for i, chunk in enumerate(chunks):
                if i > 0:
                    await asyncio.sleep(_CHUNK_PAUSE_S)
                query = build_corridor_query(chunk, self._corridor_width_m)
                data = await self._post(client, query)
                corridor = parse_response(data)
                ways.update((way.id, way) for way in corridor.ways)
                nodes.update((node.id, node) for node in corridor.nodes)
        return CorridorData(ways=list(ways.values()), nodes=list(nodes.values()))

    async def _post(self, client: httpx.AsyncClient, query: str) -> dict:
        last_error = ""
        for attempt in range(3):
            if attempt > 0:
                await asyncio.sleep(15 * attempt)
            try:
                response = await client.post(self._base_url, data={"data": query})
            except httpx.HTTPError as exc:
                last_error = str(exc)
                continue
            if response.status_code == 200:
                return response.json()
            last_error = f"{response.status_code}: {response.text[:200]}"
            if response.status_code not in (429, 504):
                break
        raise OverpassError(f"Overpass request failed: {last_error}")
