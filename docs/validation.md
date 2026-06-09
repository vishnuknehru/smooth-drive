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

## Phase 1 exit criteria

- 3+ recorded real drives replayed (including one 20+ mile trip), 100+ miles total
- Signal and roundabout detection ≥80% correct on driven routes
- Speed-limit changes ≥80% correct; every mismatch traced to OSM data (fixable upstream) vs. matching bugs (fixable here)
