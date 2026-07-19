import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/utils/units.dart';

void main() {
  group('UnitsFormatter imperial', () {
    const f = UnitsFormatter(Units.imperial);

    test('formats speed from m/s to mph', () {
      expect(f.formatSpeed(0), '0 mph');
      expect(f.formatSpeed(13.4112), '30 mph'); // 30 mph exactly
      expect(f.formatSpeed(31.2928), '70 mph');
    });

    test('keeps sign values as-is', () {
      expect(f.formatLimit(30), '30 mph');
      expect(f.formatLimit(70), '70 mph');
    });

    test('formats short distances in yards', () {
      expect(f.formatDistance(91.44), '100 yd');
      expect(f.formatDistance(50), '50 yd');
    });

    test('formats long distances in miles', () {
      expect(f.formatDistance(1609.34), '1.0 mi');
      expect(f.formatDistance(643.7), '0.4 mi');
    });
  });

  group('UnitsFormatter metric', () {
    const f = UnitsFormatter(Units.metric);

    test('formats speed from m/s to km/h', () {
      expect(f.formatSpeed(0), '0 km/h');
      expect(f.formatSpeed(13.8889), '50 km/h'); // 50 km/h exactly
    });

    test('converts sign values to nearest 5 km/h', () {
      expect(f.formatLimit(30), '50 km/h'); // 48.3 → 50
      expect(f.formatLimit(70), '115 km/h'); // 112.65 → 115
    });

    test('formats short distances in meters', () {
      expect(f.formatDistance(650), '650 m');
      expect(f.formatDistance(123), '120 m');
    });

    test('formats long distances in km', () {
      expect(f.formatDistance(1500), '1.5 km');
    });
  });

  test('formatDuration renders hours and minutes', () {
    const f = UnitsFormatter(Units.imperial);
    expect(f.formatDuration(const Duration(minutes: 42)), '42m');
    expect(f.formatDuration(const Duration(hours: 1, minutes: 5)), '1h 5m');
  });
}
