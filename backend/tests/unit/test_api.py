import pytest
from fastapi.testclient import TestClient

from smoothdrive.api import routes
from smoothdrive.domain.models import Coordinate, Route
from smoothdrive.domain.osm import CorridorData, OSMWay
from smoothdrive.main import app
from smoothdrive.services.analyzer import RouteAnalyzer

ROUTE = Route(
    geometry=[Coordinate(lat=51.0 + i * 0.002, lon=0.0) for i in range(11)],
    distance_meters=2224,
)

CORRIDOR = CorridorData(
    ways=[
        OSMWay(
            id=1,
            tags={"highway": "primary", "maxspeed": "40 mph"},
            geometry=[Coordinate(lat=51.0, lon=0.0), Coordinate(lat=51.010, lon=0.0)],
        ),
        OSMWay(
            id=2,
            tags={"highway": "primary", "maxspeed": "30 mph"},
            geometry=[Coordinate(lat=51.010, lon=0.0), Coordinate(lat=51.020, lon=0.0)],
        ),
    ],
    nodes=[],
)


class FakeRouting:
    async def get_route(self, start: Coordinate, end: Coordinate) -> Route:
        return ROUTE


class FakeOverpass:
    async def fetch_corridor(self, route: Route) -> CorridorData:
        return CORRIDOR


@pytest.fixture
def client(monkeypatch: pytest.MonkeyPatch) -> TestClient:
    analyzer = RouteAnalyzer(routing=FakeRouting(), overpass=FakeOverpass())
    monkeypatch.setattr(routes, "get_analyzer", lambda: analyzer)
    return TestClient(app)


def _analyze(client: TestClient) -> dict:
    response = client.post(
        "/api/route/analyze",
        json={"start": {"lat": 51.0, "lon": 0.0}, "end": {"lat": 51.02, "lon": 0.0}},
    )
    assert response.status_code == 200
    return response.json()


def test_analyze_returns_events(client: TestClient) -> None:
    body = _analyze(client)
    assert body["distance_meters"] == 2224
    types = [event["type"] for event in body["events"]]
    assert types == ["speed_limit", "speed_limit"]
    assert [event["value_mph"] for event in body["events"]] == [40, 30]


def test_upcoming_filters_passed_events(client: TestClient) -> None:
    body = _analyze(client)
    # Standing ~1.5 km along the route: the 40 mph start and the 30 mph
    # transition (~1.1 km) are behind us
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.0135, "lon": 0.0},
    )
    assert response.status_code == 200
    upcoming = response.json()
    assert upcoming["off_route"] is False
    assert upcoming["position_on_route_meters"] == pytest.approx(1500, rel=0.02)
    assert upcoming["events"] == []


def test_upcoming_reports_events_ahead(client: TestClient) -> None:
    body = _analyze(client)
    # Standing ~500 m along: the 30 mph change (~1.1 km) is ahead
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.0045, "lon": 0.0},
    )
    upcoming = response.json()
    assert len(upcoming["events"]) == 1
    assert upcoming["events"][0]["value_mph"] == 30
    assert upcoming["events"][0]["distance_ahead_meters"] == pytest.approx(620, rel=0.1)


def test_upcoming_flags_off_route(client: TestClient) -> None:
    body = _analyze(client)
    # ~700 m east of the route
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.005, "lon": 0.01},
    )
    assert response.json()["off_route"] is True


def test_upcoming_without_speed_has_no_advice(client: TestClient) -> None:
    body = _analyze(client)
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.0045, "lon": 0.0},
    )
    assert response.json()["advice"] is None


def test_upcoming_with_speed_returns_advice(client: TestClient) -> None:
    body = _analyze(client)
    # ~500 m along at 60 mph; the 30 mph drop is ~620 m ahead: lift-off needs
    # ~540 m so act_in ≈ 3 s → ease off
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.0045, "lon": 0.0, "speed_mph": 60},
    )
    advice = response.json()["advice"]
    assert advice["action"] == "ease_off"
    assert advice["target_mph"] == 30
    assert "ease off" in advice["message"]


def test_upcoming_with_low_speed_maintains(client: TestClient) -> None:
    body = _analyze(client)
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": body["route_id"], "lat": 51.0045, "lon": 0.0, "speed_mph": 25},
    )
    assert response.json()["advice"]["action"] == "maintain"


def test_upcoming_unknown_route_404(client: TestClient) -> None:
    response = client.post(
        "/api/position/upcoming",
        json={"route_id": "nonexistent", "lat": 51.0, "lon": 0.0},
    )
    assert response.status_code == 404
