# SmoothDrive

Drive smoother. Brake less. Arrive relaxed.

SmoothDrive tells drivers what's coming on the road ahead — speed-limit changes, traffic signals, roundabouts — so they can ease off early instead of braking hard.

**Phase 1 (this repo today):** a feasibility prototype. A FastAPI backend that, given a start and end point, returns the upcoming driving events along the route from OpenStreetMap data, plus a debug map and a GPX record-and-replay harness to validate against real drives.

## Setup

Prerequisites: [uv](https://docs.astral.sh/uv/) (`brew install uv`).

```bash
cd backend
cp .env.example .env        # paste your OpenRouteService API key
uv sync                     # creates .venv with Python 3.12 + deps
```

Get a free ORS API key at <https://openrouteservice.org/dev/#/signup> (free tier: 2,000 routing requests/day).

## Run

```bash
cd backend
uv run uvicorn smoothdrive.main:app --reload
```

- API docs: <http://localhost:8000/docs>
- Debug map: <http://localhost:8000/debug>

## Test

```bash
cd backend
uv run pytest --cov=smoothdrive          # default: no external calls
uv run pytest -m live                    # hits real ORS/Overpass APIs (needs .env)
```

## Replay a recorded drive

Record a drive with any GPX tracker app (GPSLogger/OSMTracker on Android, Open GPX Tracker on iOS), then:

```bash
uv run python ../tools/gpx_replay.py path/to/drive.gpx
```

## Project layout

```
backend/src/smoothdrive/
  api/         FastAPI endpoints
  domain/      Pydantic models (Event, Route, ...)
  services/    ORS client, Overpass client, geometry, event extraction
  static/      Leaflet debug map
backend/tests/ unit, integration, fixtures
tools/         gpx_replay.py
docs/adr/      architecture decision records
```

## Architecture decisions

- [ADR-001](docs/adr/ADR-001-openstreetmap.md) — OpenStreetMap as road-data source
- [ADR-002](docs/adr/ADR-002-fastapi.md) — FastAPI + Python 3.12
- [ADR-003](docs/adr/ADR-003-ors-overpass.md) — ORS + Overpass behind swappable interfaces
