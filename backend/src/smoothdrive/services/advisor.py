"""Turn current speed + upcoming events into explainable driving advice.

Pure kinematics, no AI. For an event requiring a lower speed:

    d_need = (v² − v_t²) / (2 × decel)      distance needed to slow by lifting off
    slack  = distance_ahead − d_need
    act_in = slack / v                       seconds until lift-off should start

If act_in is within the alert horizon the driver is told to ease off; once it
goes negative, braking advice escalates. Traffic signals only ever produce a
soft "be ready to stop" — the light may well be green.
"""

from dataclasses import dataclass

from smoothdrive.config import Settings
from smoothdrive.domain.models import Advice, AdviceAction, EventType, UpcomingEvent

MPS_PER_MPH = 0.44704
MI = 1609.34

MAINTAIN = Advice(action=AdviceAction.MAINTAIN, message="No action needed")


@dataclass
class _Candidate:
    action: AdviceAction
    act_in_seconds: float
    target_mph: int
    event: UpcomingEvent


def _target_mph(event: UpcomingEvent, settings: Settings) -> int | None:
    if event.type == EventType.SPEED_LIMIT:
        return event.value_mph
    if event.type == EventType.ROUNDABOUT:
        return settings.roundabout_entry_mph
    return settings.signal_approach_mph


def _describe(event: UpcomingEvent, target_mph: int) -> str:
    if event.type == EventType.SPEED_LIMIT:
        return f"Speed limit drops to {target_mph} mph"
    if event.type == EventType.ROUNDABOUT:
        return "Roundabout"
    return "Traffic signal"


def _message(candidate: _Candidate) -> str:
    where = f"in {candidate.event.distance_ahead_meters / MI:.1f} mi"
    what = _describe(candidate.event, candidate.target_mph)
    match candidate.action:
        case AdviceAction.EASE_OFF:
            return f"{what} {where} — ease off in {candidate.act_in_seconds:.0f} s"
        case AdviceAction.BRAKE_GENTLY:
            return f"{what} {where} — brake gently now"
        case AdviceAction.BRAKE:
            return f"{what} {where} — slow down now"
        case _:
            return f"{what} {where} — be ready to stop"


def _evaluate(event: UpcomingEvent, speed_mph: float, settings: Settings) -> _Candidate | None:
    target = _target_mph(event, settings)
    if target is None or target >= speed_mph:
        return None

    v = speed_mph * MPS_PER_MPH
    v_t = target * MPS_PER_MPH
    d_need = (v * v - v_t * v_t) / (2 * settings.liftoff_decel_ms2)
    act_in = (event.distance_ahead_meters - d_need) / v

    is_signal = event.type == EventType.TRAFFIC_SIGNAL
    lead = settings.signal_lead_s if is_signal else settings.alert_lead_s
    if act_in > lead:
        return None

    if is_signal:
        action = AdviceAction.PREPARE_SIGNAL
    elif act_in > 0:
        action = AdviceAction.EASE_OFF
    else:
        d_need_brake = (v * v - v_t * v_t) / (2 * settings.gentle_brake_decel_ms2)
        action = (
            AdviceAction.BRAKE_GENTLY
            if event.distance_ahead_meters >= d_need_brake
            else AdviceAction.BRAKE
        )
    return _Candidate(action=action, act_in_seconds=act_in, target_mph=target, event=event)


def advise(speed_mph: float, events: list[UpcomingEvent], settings: Settings) -> Advice:
    """Primary advice for the most urgent upcoming event, or maintain."""
    candidates = [
        candidate
        for event in events
        if (candidate := _evaluate(event, speed_mph, settings)) is not None
    ]
    if not candidates:
        return MAINTAIN
    urgent = min(candidates, key=lambda c: c.act_in_seconds)
    return Advice(
        action=urgent.action,
        act_in_seconds=urgent.act_in_seconds if urgent.act_in_seconds > 0 else None,
        target_mph=urgent.target_mph,
        event=urgent.event,
        message=_message(urgent),
    )
