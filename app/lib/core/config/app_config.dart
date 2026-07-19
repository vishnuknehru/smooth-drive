/// Compile-time defaults. Runtime-tunable values live in Settings.
abstract final class AppConfig {
  /// Android emulator alias for the host machine's localhost, where the
  /// backend dev server runs. Physical devices override this in Settings.
  static const defaultBaseUrl = 'http://10.0.2.2:8000';

  /// Minimum gap between /api/position/upcoming requests. GPS ticks at
  /// ~1 Hz; this guard stops request pile-up on slow networks.
  static const minRequestGap = Duration(milliseconds: 900);

  static const defaultAlertDistanceMeters = 500.0;

  static const connectTimeout = Duration(seconds: 5);

  /// Route analysis fans out to ORS + Overpass and can take a while.
  static const receiveTimeout = Duration(seconds: 20);
}
