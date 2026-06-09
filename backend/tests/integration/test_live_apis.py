"""Live tests against real external APIs. Run explicitly: uv run pytest -m live"""

import pytest

from smoothdrive.config import get_settings
from smoothdrive.domain.models import Coordinate
from smoothdrive.services.overpass import OverpassService
from smoothdrive.services.routing import ORSRoutingService, OSRMRoutingService

pytestmark = pytest.mark.live

START = Coordinate(lat=51.5072, lon=-0.1276)  # Charing Cross
END = Coordinate(lat=51.5033, lon=-0.1196)  # Westminster Bridge


async def test_osrm_live_route() -> None:
    route = await OSRMRoutingService().get_route(START, END)
    assert route.distance_meters > 200
    assert len(route.geometry) >= 2


@pytest.mark.skipif(not get_settings().ors_api_key, reason="ORS_API_KEY not configured")
async def test_ors_live_route() -> None:
    route = await ORSRoutingService().get_route(START, END)
    assert route.distance_meters > 200
    assert len(route.geometry) >= 2


async def test_overpass_live_corridor() -> None:
    route = await OSRMRoutingService().get_route(START, END)
    corridor = await OverpassService().fetch_corridor(route)
    # Central London: there must be drivable ways and at least one signal
    assert len(corridor.ways) > 0
    assert any(n.tags.get("highway") == "traffic_signals" for n in corridor.nodes)
