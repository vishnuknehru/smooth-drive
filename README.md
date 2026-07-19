# SmoothDrive

Drive smoother. Brake less. Arrive relaxed.

SmoothDrive tells drivers what's coming on the road ahead — speed-limit changes, traffic signals, roundabouts — so they can ease off early instead of braking hard.

**Phase 1–2 (backend/):** a FastAPI backend that, given a start and end point, returns the upcoming driving events along the route from OpenStreetMap data plus physics-based driving advice, with a debug map and a GPX record-and-replay harness to validate against real drives.

**Phase 3 (app/):** the Flutter Android MVP — consumes the backend and presents live driving guidance. See [app development](#flutter-app-phase-3) below.

## Setup

Prerequisites: [uv](https://docs.astral.sh/uv/) (`brew install uv`).

```bash
cd backend
cp .env.example .env        # paste your OpenRouteService API key
uv sync                     # creates .venv with Python 3.12 + deps
```

Get a free ORS API key at <https://openrouteservice.org/dev/#/signup> (free tier: 2,000 routing requests/day). Without a key, routing automatically falls back to the public [OSRM demo server](https://router.project-osrm.org) — fine for development, not for anything sustained.

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

## Flutter app (Phase 3)

Prerequisites: [Flutter](https://docs.flutter.dev/get-started/install) stable + Android SDK.

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # after model/provider changes
flutter test
flutter run          # emulator reaches the backend at http://10.0.2.2:8000
```

On a physical device, set the server URL in the app's Settings to your Mac's LAN IP (or run `adb reverse tcp:8000 tcp:8000` and keep the default). CI for the app lives in `.github/workflows/app-ci.yml` (format, analyze, tests, coverage, release APK artifact).

## Project layout

```
app/lib/
  core/        config, network, router, theme, utils, top-level providers
  features/    home, drive, summary, settings — each data/domain/presentation
  services/    voice guidance abstraction
  shared/      reusable widgets
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
