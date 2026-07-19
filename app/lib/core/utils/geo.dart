import 'dart:math';

/// Mirrors backend services/geometry.py so on-device numbers agree with
/// the server's.
const earthRadiusM = 6371000.0;

double _radians(double deg) => deg * pi / 180;

/// Great-circle distance between two coordinates in metres.
double haversineMeters({
  required double lat1,
  required double lon1,
  required double lat2,
  required double lon2,
}) {
  final rlat1 = _radians(lat1);
  final rlat2 = _radians(lat2);
  final dlat = rlat2 - rlat1;
  final dlon = _radians(lon2) - _radians(lon1);
  final h =
      pow(sin(dlat / 2), 2) + cos(rlat1) * cos(rlat2) * pow(sin(dlon / 2), 2);
  return 2 * earthRadiusM * asin(sqrt(h));
}
