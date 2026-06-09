"""Run the full extraction engine over captured real-world fixtures."""

import pytest

from smoothdrive.domain.models import EventType
from smoothdrive.services.events import extract_events
from smoothdrive.services.overpass import parse_response
from tests.integration.test_fixtures import FIXTURE_NAMES, load_corridor_raw, load_route


@pytest.mark.parametrize("name", FIXTURE_NAMES)
def test_extraction_produces_ordered_events(name: str) -> None:
    route = load_route(name)
    corridor = parse_response(load_corridor_raw(name))
    events = extract_events(route, corridor)
    assert len(events) > 0
    distances = [event.distance_meters for event in events]
    assert distances == sorted(distances)
    assert all(0 <= d <= route.distance_meters * 1.05 for d in distances)


def test_urban_route_detects_signals_and_speed_changes() -> None:
    route = load_route("urban_croydon_westminster")
    corridor = parse_response(load_corridor_raw("urban_croydon_westminster"))
    events = extract_events(route, corridor)
    by_type = {t: [e for e in events if e.type == t] for t in EventType}
    # 17 km through south London: signals and limit changes are guaranteed
    assert len(by_type[EventType.TRAFFIC_SIGNAL]) >= 10
    assert len(by_type[EventType.SPEED_LIMIT]) >= 3
    # London limits are 20-40 mph; anything else means bad matching
    assert all(20 <= e.value_mph <= 50 for e in by_type[EventType.SPEED_LIMIT])


def test_mixed_route_detects_roundabouts() -> None:
    route = load_route("mixed_kingston_epsom")
    corridor = parse_response(load_corridor_raw("mixed_kingston_epsom"))
    events = extract_events(route, corridor)
    roundabouts = [e for e in events if e.type == EventType.ROUNDABOUT]
    assert len(roundabouts) >= 1
