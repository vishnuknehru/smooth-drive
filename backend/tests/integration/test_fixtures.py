"""Validate captured real-world fixtures parse into usable corridor data."""

import json
from pathlib import Path

import pytest

from smoothdrive.domain.models import Route
from smoothdrive.services.overpass import parse_response

FIXTURES_DIR = Path(__file__).resolve().parent.parent / "fixtures"

FIXTURE_NAMES = [
    "urban_croydon_westminster",
    "mixed_kingston_epsom",
    "rural_guildford_horsham",
]


def load_route(name: str) -> Route:
    return Route.model_validate_json((FIXTURES_DIR / name / "route.json").read_text())


def load_corridor_raw(name: str) -> dict:
    return json.loads((FIXTURES_DIR / name / "overpass.json").read_text())


@pytest.mark.parametrize("name", FIXTURE_NAMES)
def test_fixture_route_loads(name: str) -> None:
    route = load_route(name)
    assert route.distance_meters > 1000
    assert len(route.geometry) > 50


@pytest.mark.parametrize("name", FIXTURE_NAMES)
def test_fixture_corridor_parses(name: str) -> None:
    corridor = parse_response(load_corridor_raw(name))
    assert len(corridor.ways) > 10
    assert any("maxspeed" in way.tags for way in corridor.ways)


def test_urban_fixture_has_signals() -> None:
    corridor = parse_response(load_corridor_raw("urban_croydon_westminster"))
    signals = [n for n in corridor.nodes if n.tags.get("highway") == "traffic_signals"]
    assert len(signals) > 5
