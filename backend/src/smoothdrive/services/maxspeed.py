"""Parse OSM maxspeed tags into mph (UK-focused)."""

import re

KMH_PER_MPH = 1.609344

_MPH_PATTERN = re.compile(r"^(\d+)\s*mph$")
_KMH_PATTERN = re.compile(r"^(\d+)$")

# Tag values that mean "no numeric limit applies here"
_NON_NUMERIC = {"none", "signals", "variable", "walk"}


def parse_maxspeed_mph(value: str | None, highway: str | None = None) -> int | None:
    """Return the speed limit in mph, or None when unknown/non-numeric.

    UK tagging is normally "30 mph". A bare number is km/h per OSM convention.
    "national" (UK national speed limit) depends on road type: 70 on motorways
    and dual carriageways, 60 on single carriageways — we can't see carriageway
    type here, so motorway gets 70 and everything else conservatively 60.
    """
    if value is None:
        return None
    value = value.strip().lower()
    if value in _NON_NUMERIC:
        return None
    if match := _MPH_PATTERN.match(value):
        return int(match.group(1))
    if match := _KMH_PATTERN.match(value):
        return round(int(match.group(1)) / KMH_PER_MPH)
    if value == "national" or value == "uk:national":
        if highway in ("motorway", "motorway_link"):
            return 70
        return 60
    return None
