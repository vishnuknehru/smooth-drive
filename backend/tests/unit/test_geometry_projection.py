import pytest

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.geometry import (
    bearing_deg,
    bearing_difference_deg,
    cumulative_distances_m,
    point_to_segment_m,
    project_onto_polyline,
)

# A straight ~1.1 km south-to-north line at longitude 0
LINE = [Coordinate(lat=51.0 + i * 0.002, lon=0.0) for i in range(6)]


def test_bearing_cardinal_directions() -> None:
    origin = Coordinate(lat=51.0, lon=0.0)
    assert bearing_deg(origin, Coordinate(lat=52.0, lon=0.0)) == pytest.approx(0, abs=0.1)
    assert bearing_deg(origin, Coordinate(lat=51.0, lon=1.0)) == pytest.approx(90, abs=1)
    assert bearing_deg(origin, Coordinate(lat=50.0, lon=0.0)) == pytest.approx(180, abs=0.1)


def test_bearing_difference_folds_opposite_directions() -> None:
    assert bearing_difference_deg(0, 180) == 0
    assert bearing_difference_deg(10, 190) == 0
    assert bearing_difference_deg(0, 90) == 90
    assert bearing_difference_deg(350, 10) == 20


def test_cumulative_distances_monotonic() -> None:
    cumdist = cumulative_distances_m(LINE)
    assert cumdist[0] == 0
    assert len(cumdist) == len(LINE)
    assert all(b > a for a, b in zip(cumdist, cumdist[1:]))
    assert cumdist[-1] == pytest.approx(1112, rel=0.01)


def test_point_to_segment_perpendicular() -> None:
    # Point ~70 m east of the midpoint of a north-south segment
    distance, t = point_to_segment_m(
        Coordinate(lat=51.001, lon=0.001),
        Coordinate(lat=51.0, lon=0.0),
        Coordinate(lat=51.002, lon=0.0),
    )
    assert distance == pytest.approx(70, rel=0.02)
    assert t == pytest.approx(0.5, abs=0.01)


def test_point_to_segment_clamps_to_endpoints() -> None:
    # Point south of the segment start: closest position is the start itself
    distance, t = point_to_segment_m(
        Coordinate(lat=50.999, lon=0.0),
        Coordinate(lat=51.0, lon=0.0),
        Coordinate(lat=51.002, lon=0.0),
    )
    assert t == 0.0
    assert distance == pytest.approx(111, rel=0.02)


def test_project_onto_polyline() -> None:
    cumdist = cumulative_distances_m(LINE)
    # A point halfway up the line, offset ~35 m east
    along, offset = project_onto_polyline(
        Coordinate(lat=51.005, lon=0.0005), LINE, cumdist
    )
    assert along == pytest.approx(cumdist[-1] / 2, rel=0.02)
    assert offset == pytest.approx(35, rel=0.05)
