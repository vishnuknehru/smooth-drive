"""Capture real ORS/OSRM + Overpass responses as test fixtures.

Usage (from backend/): uv run python ../tools/capture_fixtures.py [name]

Writes backend/tests/fixtures/<name>/route.json (normalized Route) and
overpass.json (raw Overpass response) for each route, so the extraction
engine can be tested offline without hammering the APIs.
"""

import asyncio
import json
import sys
from pathlib import Path

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.overpass import OverpassService
from smoothdrive.services.routing import default_routing_service

FIXTURES_DIR = Path(__file__).resolve().parent.parent / "backend" / "tests" / "fixtures"

ROUTES = {
    # Dense signals, frequent 20/30 mph changes
    "urban_croydon_westminster": (
        Coordinate(lat=51.3762, lon=-0.0982),
        Coordinate(lat=51.4995, lon=-0.1248),
    ),
    # Suburban A-roads, roundabouts
    "mixed_kingston_epsom": (
        Coordinate(lat=51.4123, lon=-0.3007),
        Coordinate(lat=51.3360, lon=-0.2674),
    ),
    # National-speed-limit rural roads
    "rural_guildford_horsham": (
        Coordinate(lat=51.2362, lon=-0.5704),
        Coordinate(lat=51.0629, lon=-0.3259),
    ),
}


async def capture(name: str, start: Coordinate, end: Coordinate) -> None:
    out_dir = FIXTURES_DIR / name
    out_dir.mkdir(parents=True, exist_ok=True)

    routing = default_routing_service()
    route = await routing.get_route(start, end)
    (out_dir / "route.json").write_text(route.model_dump_json(indent=2))
    print(f"{name}: route {route.distance_meters / 1000:.1f} km, {len(route.geometry)} points")

    # Fetch chunk-by-chunk via the service, but persist in raw Overpass shape
    # so fixtures exercise parse_response too.
    corridor = await OverpassService().fetch_corridor(route)
    data = {
        "elements": [
            *(
                {
                    "type": "way",
                    "id": way.id,
                    "tags": way.tags,
                    "geometry": [{"lat": p.lat, "lon": p.lon} for p in way.geometry],
                }
                for way in corridor.ways
            ),
            *(
                {
                    "type": "node",
                    "id": node.id,
                    "tags": node.tags,
                    "lat": node.location.lat,
                    "lon": node.location.lon,
                }
                for node in corridor.nodes
            ),
        ]
    }
    (out_dir / "overpass.json").write_text(json.dumps(data, indent=1))
    print(f"{name}: overpass {len(data['elements'])} elements")


async def main() -> None:
    only = sys.argv[1] if len(sys.argv) > 1 else None
    for name, (start, end) in ROUTES.items():
        if only and name != only:
            continue
        await capture(name, start, end)
        # Be polite to the public Overpass instance
        await asyncio.sleep(5)


if __name__ == "__main__":
    asyncio.run(main())
