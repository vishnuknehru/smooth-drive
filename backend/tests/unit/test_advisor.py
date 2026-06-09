"""Advisor physics, hand-computed.

With the default comfort profile (lift-off 1.0 m/s², gentle brake 2.0 m/s²):
60 mph = 26.82 m/s, 40 mph = 17.88 m/s, so slowing 60→40 by lifting off needs
(26.82² − 17.88²) / 2 ≈ 200 m. The act-in time is (distance − 200 m) / 26.82.
"""

import pytest

from smoothdrive.config import Settings
from smoothdrive.domain.models import AdviceAction, Coordinate, EventType, UpcomingEvent
from smoothdrive.services.advisor import advise

LOCATION = Coordinate(lat=51.5, lon=-0.1)


@pytest.fixture
def settings() -> Settings:
    return Settings(_env_file=None)


def _event(event_type: EventType, distance: float, value_mph: int | None = None) -> UpcomingEvent:
    return UpcomingEvent(
        type=event_type, distance_ahead_meters=distance, location=LOCATION, value_mph=value_mph
    )


def test_far_event_means_maintain(settings: Settings) -> None:
    # 60→40 one mile out: act_in ≈ (1609 − 200) / 26.82 ≈ 52 s, beyond the 20 s horizon
    advice = advise(60, [_event(EventType.SPEED_LIMIT, 1609, 40)], settings)
    assert advice.action == AdviceAction.MAINTAIN
    assert advice.event is None


def test_ease_off_within_horizon(settings: Settings) -> None:
    # 60→40 at 700 m: act_in ≈ (700 − 200) / 26.82 ≈ 18.6 s
    advice = advise(60, [_event(EventType.SPEED_LIMIT, 700, 40)], settings)
    assert advice.action == AdviceAction.EASE_OFF
    assert advice.act_in_seconds == pytest.approx(18.6, abs=0.5)
    assert advice.target_mph == 40
    assert "ease off" in advice.message


def test_brake_gently_when_liftoff_too_late(settings: Settings) -> None:
    # 60→40 at 150 m: lift-off needs 200 m (too late), gentle braking needs 100 m (fine)
    advice = advise(60, [_event(EventType.SPEED_LIMIT, 150, 40)], settings)
    assert advice.action == AdviceAction.BRAKE_GENTLY
    assert advice.act_in_seconds is None
    assert "brake gently now" in advice.message


def test_brake_when_even_gentle_is_too_late(settings: Settings) -> None:
    # 60→40 at 80 m: gentle braking needs 100 m
    advice = advise(60, [_event(EventType.SPEED_LIMIT, 80, 40)], settings)
    assert advice.action == AdviceAction.BRAKE


def test_higher_limit_ahead_is_ignored(settings: Settings) -> None:
    advice = advise(40, [_event(EventType.SPEED_LIMIT, 300, 60)], settings)
    assert advice.action == AdviceAction.MAINTAIN


def test_unknown_limit_is_ignored(settings: Settings) -> None:
    advice = advise(40, [_event(EventType.SPEED_LIMIT, 300, None)], settings)
    assert advice.action == AdviceAction.MAINTAIN


def test_roundabout_ease_off(settings: Settings) -> None:
    # 30 mph (13.41 m/s) → 12 mph entry: d_need ≈ 75.5 m; at 150 m act_in ≈ 5.6 s
    advice = advise(30, [_event(EventType.ROUNDABOUT, 150)], settings)
    assert advice.action == AdviceAction.EASE_OFF
    assert advice.act_in_seconds == pytest.approx(5.6, abs=0.3)
    assert advice.target_mph == 12
    assert "Roundabout" in advice.message


def test_signal_is_soft_prepare_never_firm(settings: Settings) -> None:
    # Even past the ideal lift-off point a signal stays advisory
    near = advise(30, [_event(EventType.TRAFFIC_SIGNAL, 50)], settings)
    assert near.action == AdviceAction.PREPARE_SIGNAL
    assert "be ready to stop" in near.message

    mid = advise(30, [_event(EventType.TRAFFIC_SIGNAL, 250)], settings)
    assert mid.action == AdviceAction.PREPARE_SIGNAL


def test_signal_uses_shorter_horizon(settings: Settings) -> None:
    # 30 mph → 10 mph: d_need ≈ 80 m; at 300 m act_in ≈ 16.4 s — outside the
    # 15 s signal horizon though inside the 20 s general one
    advice = advise(30, [_event(EventType.TRAFFIC_SIGNAL, 300)], settings)
    assert advice.action == AdviceAction.MAINTAIN


def test_most_urgent_event_wins(settings: Settings) -> None:
    # A roundabout 150 m out is more urgent than a limit drop 700 m out
    advice = advise(
        60,
        [_event(EventType.SPEED_LIMIT, 700, 40), _event(EventType.ROUNDABOUT, 150)],
        settings,
    )
    assert advice.event is not None
    assert advice.event.type == EventType.ROUNDABOUT


def test_stationary_vehicle_maintains(settings: Settings) -> None:
    advice = advise(0, [_event(EventType.SPEED_LIMIT, 100, 30)], settings)
    assert advice.action == AdviceAction.MAINTAIN


def test_no_events_maintains(settings: Settings) -> None:
    assert advise(60, [], settings).action == AdviceAction.MAINTAIN
