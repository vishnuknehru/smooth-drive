import pytest

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.geometry import downsample, haversine_m


def test_haversine_zero_distance() -> None:
    point = Coordinate(lat=51.5, lon=-0.1)
    assert haversine_m(point, point) == 0.0


def test_haversine_known_distance() -> None:
    # London Charing Cross to Croydon town centre is roughly 14.7 km
    charing_cross = Coordinate(lat=51.5073, lon=-0.1276)
    croydon = Coordinate(lat=51.3762, lon=-0.0982)
    assert haversine_m(charing_cross, croydon) == pytest.approx(14_700, rel=0.05)


def test_haversine_one_degree_latitude() -> None:
    a = Coordinate(lat=51.0, lon=0.0)
    b = Coordinate(lat=52.0, lon=0.0)
    assert haversine_m(a, b) == pytest.approx(111_195, rel=0.01)


def test_downsample_keeps_endpoints() -> None:
    # Points roughly 11 m apart in latitude
    points = [Coordinate(lat=51.0 + i * 0.0001, lon=0.0) for i in range(100)]
    thinned = downsample(points, min_spacing_m=50)
    assert thinned[0] == points[0]
    assert thinned[-1] == points[-1]
    assert len(thinned) < len(points)
    for previous, current in zip(thinned, thinned[1:-1]):
        assert haversine_m(previous, current) >= 50


def test_downsample_short_input_unchanged() -> None:
    points = [Coordinate(lat=51.0, lon=0.0), Coordinate(lat=51.1, lon=0.0)]
    assert downsample(points, min_spacing_m=50) == points
