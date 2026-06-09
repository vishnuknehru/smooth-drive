"""Post-drive smoothness analysis from a recorded GPS track.

Speeds are derived from consecutive (time, position) samples and smoothed with
a short moving average to tame GPS noise; sustained decelerations above the
harsh threshold become events, and the drive gets a 0-100 score.
"""

from datetime import datetime

from pydantic import BaseModel

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.geometry import haversine_m

MPS_PER_MPH = 0.44704
HARSH_DECEL_MS2 = 3.0
HARSH_PENALTY = 10
LATE_REACTION_PENALTY = 5
_SMOOTH_WINDOW = 3


class SpeedPoint(BaseModel):
    time: datetime
    location: Coordinate
    speed_mph: float


class HarshEvent(BaseModel):
    time: datetime
    location: Coordinate
    from_mph: float
    to_mph: float
    peak_decel_ms2: float


class SmoothnessReport(BaseModel):
    distance_miles: float
    duration_minutes: float
    harsh_events: list[HarshEvent]
    late_reactions: int
    score: int


def _smooth(values: list[float], window: int = _SMOOTH_WINDOW) -> list[float]:
    half = window // 2
    return [
        sum(values[max(0, i - half) : i + half + 1]) / len(values[max(0, i - half) : i + half + 1])
        for i in range(len(values))
    ]


def speed_profile(samples: list[tuple[datetime, Coordinate]]) -> list[SpeedPoint]:
    """Smoothed speed at each sample after the first (segment speed at its end)."""
    raw: list[float] = []
    kept: list[tuple[datetime, Coordinate]] = []
    for (t1, p1), (t2, p2) in zip(samples, samples[1:]):
        dt = (t2 - t1).total_seconds()
        if dt <= 0:
            continue
        raw.append(haversine_m(p1, p2) / dt / MPS_PER_MPH)
        kept.append((t2, p2))
    smoothed = _smooth(raw)
    return [
        SpeedPoint(time=t, location=p, speed_mph=s) for (t, p), s in zip(kept, smoothed)
    ]


def find_harsh_decelerations(profile: list[SpeedPoint]) -> list[HarshEvent]:
    """Contiguous stretches where deceleration exceeds HARSH_DECEL_MS2."""
    events: list[HarshEvent] = []
    current: HarshEvent | None = None
    for a, b in zip(profile, profile[1:]):
        dt = (b.time - a.time).total_seconds()
        decel = (a.speed_mph - b.speed_mph) * MPS_PER_MPH / dt
        if decel > HARSH_DECEL_MS2:
            if current is None:
                current = HarshEvent(
                    time=a.time,
                    location=a.location,
                    from_mph=a.speed_mph,
                    to_mph=b.speed_mph,
                    peak_decel_ms2=decel,
                )
            else:
                current.to_mph = b.speed_mph
                current.peak_decel_ms2 = max(current.peak_decel_ms2, decel)
        elif current is not None:
            events.append(current)
            current = None
    if current is not None:
        events.append(current)
    return events


def build_report(
    samples: list[tuple[datetime, Coordinate]], late_reactions: int = 0
) -> SmoothnessReport:
    profile = speed_profile(samples)
    harsh = find_harsh_decelerations(profile)
    distance_m = sum(haversine_m(p1, p2) for (_, p1), (_, p2) in zip(samples, samples[1:]))
    duration_s = (samples[-1][0] - samples[0][0]).total_seconds() if len(samples) > 1 else 0.0
    score = max(
        0, 100 - HARSH_PENALTY * len(harsh) - LATE_REACTION_PENALTY * late_reactions
    )
    return SmoothnessReport(
        distance_miles=distance_m / 1609.34,
        duration_minutes=duration_s / 60,
        harsh_events=harsh,
        late_reactions=late_reactions,
        score=score,
    )
