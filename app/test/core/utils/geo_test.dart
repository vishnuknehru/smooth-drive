import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/utils/geo.dart';

void main() {
  test('one degree of latitude is ~111.2 km', () {
    final d = haversineMeters(lat1: 51.0, lon1: 0.0, lat2: 52.0, lon2: 0.0);
    expect(d, closeTo(111195, 100));
  });

  test('zero distance for identical points', () {
    expect(haversineMeters(lat1: 51.5, lon1: -0.1, lat2: 51.5, lon2: -0.1), 0);
  });

  test('matches backend value for a London pair', () {
    // Croydon -> Westminster, ~14.9 km as the crow flies.
    final d = haversineMeters(
      lat1: 51.3721,
      lon1: -0.0982,
      lat2: 51.4995,
      lon2: -0.1248,
    );
    expect(d, closeTo(14290, 200));
  });
}
