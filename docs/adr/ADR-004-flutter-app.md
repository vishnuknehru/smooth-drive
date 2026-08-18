# ADR-004: Flutter for the Android MVP client

**Status:** Accepted — 2026-07-04

## Context

We need a mobile client that:
- Streams live GPS at ~1 Hz and calls the backend on every significant position change
- Shows a glanceable driving dashboard (speed, limit, upcoming events, advice banner)
- Speaks voice guidance without blocking the UI thread
- Runs on Android for the MVP; iOS must remain achievable without a rewrite

Options considered: native Kotlin/Android, React Native, Flutter.

## Decisions

### 1. Flutter over React Native / native Kotlin

Flutter was chosen over React Native because:
- **Single-file widget tests** work without a running device — critical for CI.
- The Dart FFI/plugin model gives direct access to `geolocator`, `flutter_tts`, and `wakelock_plus` without a JS bridge.
- **Pixel-identical rendering** across Android and a future iOS build; no platform-specific layout bugs.

Consequence: the Dart skill set is narrow, but the team (solo project) is already writing Dart.

### 2. Riverpod v3 (riverpod_annotation + riverpod_generator) over Provider / Bloc

Riverpod was chosen because:
- `@Riverpod(keepAlive: true)` gives explicit lifecycle control — essential for a singleton `DriveController` that must survive navigation.
- The generated `*Provider` objects are type-safe and testable via `ProviderContainer` overrides without a `BuildContext`.
- `ref.listen` replaces manual `StreamBuilder` / `BlocListener` boilerplate.

**Deviation from standard Riverpod usage:** `DriveController` stores `StreamSubscription` and `VoiceAnnouncer` as mutable fields on the `Notifier` rather than using `ref.onDispose`. This is intentional: the drive session outlives individual widget lifetimes and must be torn down explicitly via `endDrive()`, not on provider disposal.

### 3. Clean Architecture layers (domain / data / presentation)

- **domain/**: pure Dart — entities, repository interfaces, service interfaces, business logic. Zero Flutter or platform imports. Fully unit-testable without mocks.
- **data/**: implements domain interfaces. Holds Dio/geolocator/flutter_tts adapters. Excluded from coverage where platform channels make unit testing impossible.
- **presentation/**: Riverpod `Notifier` controllers + Flutter widgets. Depends on domain interfaces, never on data concretions directly (wired through providers).

**Deviation:** `DriveController` (presentation) imports `JourneyRecorder` from domain directly rather than going through a repository. `JourneyRecorder` is a pure-Dart accumulator with no I/O — treating it as a separate repository would add an abstraction layer with no isolation benefit.

### 4. Freezed + json_serializable for immutable models

`@freezed` gives `copyWith`, equality, and `toString` for free on the sealed `DriveState` union and all domain entities. `build.yaml` sets `field_rename: snake` globally so JSON keys match the backend's snake_case convention without per-field annotations.

**Deviation from Freezed defaults:** `DriveState` is declared as `sealed class DriveState` (not `abstract`) to enable exhaustive `switch` expressions in Dart 3. The generated `_$DriveState` mixin provides `copyWith` only on the concrete variants, not the sealed base — this is expected behaviour.

### 5. File-based journey persistence over SQLite / Hive

Each completed journey is stored as a single JSON file at `<app-documents>/journeys/<id>.json`. Rationale:
- Zero schema migrations for a prototype — adding a field to `Journey` just means new files have the field, old files miss it (handled with null defaults).
- No additional package dependency.
- `FileJourneyRepository` accepts an `overrideDir` constructor parameter so unit tests inject a temp directory without platform channels.

Consequence: listing recent journeys requires a directory scan on every call. Acceptable for ≤ 100 journeys; revisit if the store grows.

### 6. flutter_tts for voice guidance, behind a VoiceService interface

`flutter_tts` provides en-GB speech synthesis with rate/volume control. It is wrapped behind `VoiceService` (abstract class) so:
- `FlutterTtsVoiceService` (the real adapter) is excluded from unit-test coverage — it calls a platform channel that isn't available in the test runner.
- `VoiceAnnouncer` (the policy class — what to say and when) is pure Dart and fully unit-tested.
- `FakeVoiceSvc` replaces the real adapter in `DriveController` tests.

### 7. GPS staleness detection via wall-clock, not GPS timestamps

The drive screen tracks when the last `DriveTick` was *received* (wall-clock `DateTime.now()`) rather than reading the tick's embedded GPS timestamp. This prevents the GPX replay mode from triggering false "GPS signal lost" banners (replay ticks carry historical timestamps from 2026-07-01 while the device clock is current).

## Consequences summary

| Decision | Main trade-off |
|----------|---------------|
| Flutter | Dart skill requirement; no native look-and-feel |
| Riverpod v3 | Code-gen step in build; generated files in version control |
| Clean Architecture | More boilerplate for small features |
| File persistence | No query capability; scan cost grows with journey count |
| flutter_tts | en-GB only; no offline neural TTS in MVP |
