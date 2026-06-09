"""Smoothness analysis on synthetic speed profiles laid out along a straight road."""

from datetime import datetime, timedelta, timezone

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.smoothness import (
    MPS_PER_MPH,
    build_report,
    find_harsh_decelerations,
    speed_profile,
)

START = datetime(2026, 6, 9, 9, 0, tzinfo=timezone.utc)
DEG_PER_M = 1 / 111_195  # latitude degrees per metre


def _drive(speeds_mph: list[float]) -> list[tuple[datetime, Coordinate]]:
    """One sample per second moving north, each second at the given speed."""
    samples = [(START, Coordinate(lat=51.0, lon=0.0))]
    lat = 51.0
    for i, mph in enumerate(speeds_mph):
        lat += mph * MPS_PER_MPH * DEG_PER_M
        samples.append((START + timedelta(seconds=i + 1), Coordinate(lat=lat, lon=0.0)))
    return samples


def test_speed_profile_recovers_constant_speed() -> None:
    profile = speed_profile(_drive([30.0] * 20))
    assert len(profile) == 20
    for point in profile:
        assert abs(point.speed_mph - 30) < 0.5


def test_steady_drive_scores_100() -> None:
    report = build_report(_drive([30.0] * 60))
    assert report.harsh_events == []
    assert report.score == 100
    assert report.duration_minutes == 1.0
    # 60 s at 30 mph = 0.5 mi
    assert abs(report.distance_miles - 0.5) < 0.01


def test_gentle_stop_is_not_harsh() -> None:
    # 30 mph to 0 at ~1 m/s² (2.24 mph per second)
    speeds = [30.0] * 10 + [max(0.0, 30 - 2.24 * i) for i in range(1, 15)] + [0.0] * 5
    assert find_harsh_decelerations(speed_profile(_drive(speeds))) == []


def test_slam_stop_detected_once() -> None:
    # 30 mph to 0 at ~4.5 m/s² (10 mph per second) — one merged harsh event
    speeds = [30.0] * 10 + [20.0, 10.0, 0.0] + [0.0] * 5
    harsh = find_harsh_decelerations(speed_profile(_drive(speeds)))
    assert len(harsh) == 1
    assert harsh[0].peak_decel_ms2 > 3.0
    assert harsh[0].from_mph > harsh[0].to_mph


def test_score_subtracts_penalties() -> None:
    speeds = [30.0] * 10 + [20.0, 10.0, 0.0] + [0.0] * 5
    report = build_report(_drive(speeds), late_reactions=2)
    # one harsh event (−10) + two late reactions (−2 × 5)
    assert report.score == 80
    assert report.late_reactions == 2


def test_score_floors_at_zero() -> None:
    report = build_report(_drive([30.0] * 10), late_reactions=25)
    assert report.score == 0


def test_zero_dt_samples_skipped() -> None:
    samples = _drive([30.0] * 5)
    samples.insert(3, samples[2])  # duplicate timestamp
    profile = speed_profile(samples)
    assert all(p.speed_mph < 40 for p in profile)
