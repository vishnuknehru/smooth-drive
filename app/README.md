# SmoothDrive — Flutter Android app

Real-time driving coach that scores smoothness (acceleration, braking, speed compliance) and gives voice guidance while you drive.

---

## Prerequisites

| Tool | Version |
|------|---------|
| Flutter | 3.44.4 (stable) |
| Dart | 3.12+ |
| Android SDK | API 33+ |
| JDK | 17 |

Install Flutter: https://docs.flutter.dev/get-started/install/macos/android

Verify your setup:

```bash
flutter doctor
```

---

## Backend

The app talks to the SmoothDrive FastAPI backend. Start it before running the app:

```bash
# from the repo root
cd backend
uvicorn app.main:app --reload --port 8000
```

See `backend/README.md` for full setup (virtual env, ORS/Overpass config).

---

## Emulator vs. physical device

### Android emulator (default)

The emulator reaches your laptop's localhost via `10.0.2.2`. The app default (`AppConfig.defaultBaseUrl = 'http://10.0.2.2:8000'`) works out of the box — no changes needed.

### Physical device via USB

The device can't reach `10.0.2.2`. Two options:

**Option A — adb reverse (recommended for USB)**

```bash
adb reverse tcp:8000 tcp:8000
```

This tunnels the device's `localhost:8000` to your laptop's port 8000. Change the base URL in the app's Settings screen to `http://localhost:8000`.

**Option B — LAN IP**

Find your laptop's LAN IP (`ifconfig | grep "inet "`) and set the base URL in Settings to `http://192.168.x.x:8000`. Both devices must be on the same Wi-Fi network.

---

## Running the app

```bash
# Install dependencies + generate code
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Run on the default connected device / emulator
flutter run
```

To use the built-in GPX replay instead of a real GPS signal, enable **Replay GPS** in the app's Settings screen (dev build only).

---

## Tests

```bash
# Unit + widget tests (fast, no device needed)
flutter test

# With coverage report
flutter test --coverage
bash coverage_gate.sh      # fails if filtered coverage < 80%

# Integration tests (requires a connected device or running emulator)
flutter test integration_test/app_smoke_test.dart
```

---

## Building an APK

```bash
# Debug APK — sideload to any Android device
flutter build apk --debug

# Release APK (requires a signing key)
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

Transfer to device:

```bash
adb install build/app/outputs/flutter-apk/app-debug.apk
```

---

## Project layout

```
lib/
  core/          — config, DI providers, router, theme, units formatter
  features/
    drive/       — DriveController, DriveSession, GPS layer, drive screen
    home/        — HomeScreen, saved places, destination picker
    settings/    — SettingsController, SettingsScreen
    summary/     — SummaryScreen, FileJourneyRepository, charts
  services/
    voice/       — VoiceAnnouncer, FlutterTtsVoiceService
integration_test/  — on-device smoke tests
test/              — unit + widget tests
```

Architecture: Clean Architecture layers (domain → data → presentation). State management via Riverpod v3 + riverpod_generator. See `docs/adr/ADR-004-flutter-app.md` for all major architecture decisions.
