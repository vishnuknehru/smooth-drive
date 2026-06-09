# Phase 1 validation log

Goal: measure how well OSM-derived events match reality on roads you actually drive.

## Protocol

1. Record a drive with a GPX tracker app (GPSLogger/OSMTracker on Android, Open GPX Tracker on iOS). One file per drive.
2. Start the backend: `cd backend && uv run uvicorn smoothdrive.main:app`
3. Replay: `uv run python ../tools/gpx_replay.py path/to/drive.gpx` — or load the GPX on http://localhost:8000/debug for a visual replay.
4. While reviewing, count against your memory of the road (use Street View to double-check):
   - **Correct**: event exists and is where the app says
   - **Missing**: real signal/limit change/roundabout the app didn't report
   - **False**: app reported something that isn't there
   - **Misplaced**: right event, wrong position (>100 m off)
5. Add a row below per drive.

## Results

| Date | Route | Miles | Signals (correct/missing/false) | Speed limits (c/m/f) | Roundabouts (c/m/f) | Notes |
|------|-------|-------|-------------------------------|----------------------|---------------------|-------|
|      |       |       |                               |                      |                     |       |

## Phase 2: advice quality

Replaying a drive now also prints the advice timeline and a smoothness report.
For each real drive, judge the advisor against your driving instinct:

- **Too early**: you'd have ignored it (alert fatigue risk)
- **Right**: matched when you'd naturally lift off
- **Too late**: you'd already have braked

| Date | Route | Ease-off advice (early/right/late) | Signal advisories (useful/noisy) | Harsh events flagged correctly? | Notes |
|------|-------|------------------------------------|----------------------------------|--------------------------------|-------|
|      |       |                                    |                                  |                                |       |

Tune via `.env` (defaults in `backend/src/smoothdrive/config.py`):
`LIFTOFF_DECEL_MS2` (higher = later advice), `ALERT_LEAD_S` (longer = earlier
warning), `SIGNAL_LEAD_S`, `ROUNDABOUT_ENTRY_MPH`, `SIGNAL_APPROACH_MPH`.

Phase 2 advice is sound when, over 3+ drives, most ease-off advice lands
"right", signal advisories don't feel naggy, and the smoothness score moves
in the direction you'd expect for how the drive felt.

## Phase 1 exit criteria

- 3+ recorded real drives replayed (including one 20+ mile trip), 100+ miles total
- Signal and roundabout detection ≥80% correct on driven routes
- Speed-limit changes ≥80% correct; every mismatch traced to OSM data (fixable upstream) vs. matching bugs (fixable here)
