import pytest

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.routing import (
    ORSRoutingService,
    OSRMRoutingService,
    RoutingError,
)

ORS_RESPONSE = {
    "features": [
        {
            "geometry": {"coordinates": [[-0.1276, 51.5072], [-0.1200, 51.5100], [-0.1000, 51.5150]]},
            "properties": {"summary": {"distance": 2345.6, "duration": 300.0}},
        }
    ]
}

OSRM_RESPONSE = {
    "code": "Ok",
    "routes": [
        {
            "geometry": {"coordinates": [[-0.1276, 51.5072], [-0.1000, 51.5150]]},
            "distance": 2345.6,
            "duration": 300.0,
        }
    ],
}


def test_ors_parse_response() -> None:
    route = ORSRoutingService.parse_response(ORS_RESPONSE)
    assert route.distance_meters == pytest.approx(2345.6)
    assert len(route.geometry) == 3
    # GeoJSON is [lon, lat]; our model is lat/lon
    assert route.geometry[0] == Coordinate(lat=51.5072, lon=-0.1276)


def test_ors_parse_rejects_bad_shape() -> None:
    with pytest.raises(RoutingError):
        ORSRoutingService.parse_response({"features": []})


def test_osrm_parse_response() -> None:
    route = OSRMRoutingService.parse_response(OSRM_RESPONSE)
    assert route.distance_meters == pytest.approx(2345.6)
    assert route.geometry[-1] == Coordinate(lat=51.5150, lon=-0.1000)


def test_osrm_parse_rejects_no_route() -> None:
    with pytest.raises(RoutingError):
        OSRMRoutingService.parse_response({"code": "NoRoute", "routes": []})


async def test_ors_requires_api_key() -> None:
    service = ORSRoutingService(api_key="")
    with pytest.raises(RoutingError, match="ORS_API_KEY"):
        await service.get_route(
            Coordinate(lat=51.5, lon=-0.1), Coordinate(lat=51.6, lon=-0.2)
        )
