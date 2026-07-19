const mpsPerMph = 0.44704;
const metersPerMile = 1609.34;

enum Units { imperial, metric }

/// Formats SI domain values (m/s, meters) for display.
///
/// Speed-limit sign values are kept as integer mph throughout the domain —
/// they are legal UK sign values, not physical quantities — and converted
/// here only for metric display.
class UnitsFormatter {
  const UnitsFormatter(this.units);

  final Units units;

  String get speedUnit => switch (units) {
    Units.imperial => 'mph',
    Units.metric => 'km/h',
  };

  int speedValue(double mps) => switch (units) {
    Units.imperial => (mps / mpsPerMph).round(),
    Units.metric => (mps * 3.6).round(),
  };

  String formatSpeed(double mps) => '${speedValue(mps)} $speedUnit';

  /// Sign values convert to the nearest 5 km/h so they read like real signs.
  int limitValue(int mph) => switch (units) {
    Units.imperial => mph,
    Units.metric => ((mph * mpsPerMph * 3.6) / 5).round() * 5,
  };

  String formatLimit(int mph) => '${limitValue(mph)} $speedUnit';

  String formatDistance(double meters) {
    switch (units) {
      case Units.imperial:
        final miles = meters / metersPerMile;
        if (miles < 0.1) {
          return '${((meters / 0.9144) / 10).round() * 10} yd';
        }
        return '${miles.toStringAsFixed(1)} mi';
      case Units.metric:
        if (meters < 1000) {
          return '${(meters / 10).round() * 10} m';
        }
        return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }

  String formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }
}
