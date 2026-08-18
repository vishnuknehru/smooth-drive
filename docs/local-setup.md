# Local machine setup

One-time guide to get SmoothDrive running on your laptop from scratch.

---

## 1. Flutter

Install Flutter 3.44.4 via the official installer or `fvm`:

```bash
# Option A — official (follow prompts)
# https://docs.flutter.dev/get-started/install/macos/android

# Option B — fvm (lets you switch versions per project)
brew install fvm
fvm install 3.44.4
fvm use 3.44.4
```

Verify:

```bash
flutter --version   # should print 3.44.4
flutter doctor      # Android toolchain and connected device must be green
```

---

## 2. JDK 17

Flutter's Gradle build requires JDK 17. The easiest install is via SDKMAN:

```bash
curl -s "https://get.sdkman.io" | bash
sdk install java 17-zulu   # or any JDK 17 distribution
```

Set `JAVA_HOME` if it isn't already, then confirm:

```bash
java -version   # openjdk 17
```

---

## 3. Android SDK

Install the Android command-line tools (no Android Studio needed):

```bash
brew install android-commandlinetools
```

Accept all licences:

```bash
sdkmanager --licenses
```

Install the platform and build tools the project targets:

```bash
sdkmanager "platform-tools" "platforms;android-33" "build-tools;34.0.0"
```

---

## 4. Android emulator

The emulator binary and a system image are **not** included in the command-line tools package — install them separately.

> **Apple Silicon (M1/M2/M3/M4)?** Use the `arm64-v8a` image below. Intel Macs use `x86_64`.

```bash
# Install the emulator binary and an API 33 system image
sdkmanager "emulator" "system-images;android-33;google_apis;arm64-v8a"

# Create a Pixel 7 AVD
avdmanager create avd \
  -n Pixel7_API33 \
  -k "system-images;android-33;google_apis;arm64-v8a" \
  --device "pixel_7"
```

Confirm Flutter can see it:

```bash
flutter emulators
# → Pixel7_API33 • Pixel 7 API 33 • Google • android
```

Launch the emulator:

```bash
flutter emulators --launch Pixel7_API33
```

Wait for the home screen to appear, then run the app (see step 6).

---

## 5. Physical Android device (alternative to emulator)

Skip the emulator entirely if you have an Android phone:

1. On the device: **Settings → About phone → tap Build number 7 times** to enable Developer Options.
2. **Settings → Developer options → USB debugging → ON**.
3. Plug in via USB and accept the "Allow USB debugging?" prompt on the device.
4. Verify Flutter sees it:

```bash
flutter devices
# → Your Phone • android-arm64 • Android 13
```

Connecting the app to the backend over USB:

```bash
adb reverse tcp:8000 tcp:8000
```

Then set the server URL in the app's **Settings** screen to `http://localhost:8000`.

---

## 6. Run the app

Start the backend first (the app won't reach the route API without it):

```bash
# from the repo root
cd backend
uvicorn app.main:app --reload --port 8000
```

Then in `app/`:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

`flutter run` auto-selects the only connected device/emulator. If you have more than one, pick with `-d`:

```bash
flutter run -d Pixel7_API33
flutter run -d <device-id>    # from `flutter devices`
```

---

## 7. Troubleshooting

| Symptom | Fix |
|---------|-----|
| `flutter doctor` shows Android toolchain red | Run `sdkmanager --licenses` and accept all |
| `Unable to find any emulator sources` | Run step 4 — emulator binary not installed |
| App launches but can't reach backend | Emulator: URL should be `http://10.0.2.2:8000`. Device: run `adb reverse tcp:8000 tcp:8000` then use `http://localhost:8000` |
| `Gradle build failed` | Check `java -version` is 17; set `JAVA_HOME` if not |
| `No connected devices` | Emulator not booted, or USB cable/driver issue — try a different cable |
| Emulator very slow | On Intel Mac, enable hardware acceleration: `sdkmanager "extras;intel;Hardware_Accelerated_Execution_Manager"` and install the HAXM DMG |
