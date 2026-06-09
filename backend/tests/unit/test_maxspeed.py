import pytest

from smoothdrive.services.maxspeed import parse_maxspeed_mph


@pytest.mark.parametrize(
    ("value", "highway", "expected"),
    [
        ("30 mph", "residential", 30),
        ("40mph", "primary", 40),
        ("70 MPH", "motorway", 70),
        ("48", "primary", 30),  # bare number is km/h
        ("96", "trunk", 60),
        ("national", "motorway", 70),
        ("national", "motorway_link", 70),
        ("national", "primary", 60),
        ("uk:national", "trunk", 60),
        ("none", "motorway", None),
        ("signals", "primary", None),
        ("variable", "motorway", None),
        ("walk", "service", None),
        (None, "primary", None),
        ("gibberish", "primary", None),
        ("", "primary", None),
    ],
)
def test_parse_maxspeed(value: str | None, highway: str, expected: int | None) -> None:
    assert parse_maxspeed_mph(value, highway) == expected
