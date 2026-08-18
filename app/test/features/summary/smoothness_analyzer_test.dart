import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/utils/units.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/summary/domain/smoothness_analyzer.dart';

/// Ports of backend/tests/unit/test_smoothness.py — same synthetic drives,
/// same expectations, so both implementations stay in lockstep.
final start = DateTime.utc(2026, 6, 9, 9);
const degPerM = 1 / 111195; // latitude degrees per metre

/// One sample per second moving north, each second at the given speed.
List<(DateTime, Coord)> drive(List<double> speedsMph) {
  final samples = [(start, const Coord(lat: 51.0, lon: 0.0))];
  var lat = 51.0;
  for (var i = 0; i < speedsMph.length; i++) {
    lat += speedsMph[i] * mpsPerMph * degPerM;
    samples.add((
      start.add(Duration(seconds: i + 1)),
      Coord(lat: lat, lon: 0.0),
    ));
  }
  return samples;
}

double mphOf(SpeedPoint p) => p.speedMps / mpsPerMph;

void main() {
  test('speed profile recovers constant speed', () {
    final profile = speedProfile(drive(List.filled(20, 30.0)));
    expect(profile, hasLength(20));
    for (final point in profile) {
      expect(mphOf(point), closeTo(30, 0.5));
    }
  });

  test('steady drive scores 100', () {
    final report = buildReport(drive(List.filled(60, 30.0)));
    expect(report.harshEvents, isEmpty);
    expect(report.score, 100);
    expect(report.durationSeconds, 60);
    // 60 s at 30 mph = 0.5 mi.
    expect(report.distanceMeters / 1609.34, closeTo(0.5, 0.01));
  });

  test('gentle stop is not harsh', () {
    final speeds = [
      ...List.filled(10, 30.0),
      for (var i = 1; i < 15; i++) (30 - 2.24 * i).clamp(0.0, 30.0),
      ...List.filled(5, 0.0),
    ];
    expect(findHarshDecelerations(speedProfile(drive(speeds))), isEmpty);
  });

  test('slam stop detected once', () {
    final speeds = [
      ...List.filled(10, 30.0),
      20.0,
      10.0,
      0.0,
      ...List.filled(5, 0.0),
    ];
    final harsh = findHarshDecelerations(speedProfile(drive(speeds)));
    expect(harsh, hasLength(1));
    expect(harsh.single.peakDecelMs2, greaterThan(3.0));
    expect(harsh.single.fromMps, greaterThan(harsh.single.toMps));
  });

  test('score subtracts penalties', () {
    final speeds = [
      ...List.filled(10, 30.0),
      20.0,
      10.0,
      0.0,
      ...List.filled(5, 0.0),
    ];
    final report = buildReport(drive(speeds), lateReactions: 2);
    // one harsh event (-10) + two late reactions (-2 x 5)
    expect(report.score, 80);
    expect(report.lateReactions, 2);
  });

  test('score floors at zero', () {
    final report = buildReport(drive(List.filled(10, 30.0)), lateReactions: 25);
    expect(report.score, 0);
  });

  test('zero-dt samples skipped', () {
    final samples = drive(List.filled(5, 30.0));
    samples.insert(3, samples[2]); // duplicate timestamp
    final profile = speedProfile(samples);
    expect(profile.every((p) => mphOf(p) < 40), isTrue);
  });

  test('consecutive harsh deceleration steps extend the same event', () {
    // Build SpeedPoints directly to bypass the moving-average smoothing and
    // exercise the "extend current event" branch in findHarshDecelerations.
    final t = start;
    final loc = const Coord(lat: 51.0, lon: 0.0);
    final profile = [
      SpeedPoint(time: t,                             location: loc, speedMps: 15.0),
      SpeedPoint(time: t.add(const Duration(seconds: 1)), location: loc, speedMps: 11.0), // decel 4 m/s² → harsh
      SpeedPoint(time: t.add(const Duration(seconds: 2)), location: loc, speedMps:  7.0), // decel 4 m/s² → still harsh
      SpeedPoint(time: t.add(const Duration(seconds: 3)), location: loc, speedMps:  3.0), // decel 4 m/s² → still harsh
      SpeedPoint(time: t.add(const Duration(seconds: 4)), location: loc, speedMps:  2.5), // decel 0.5 m/s² → closes event
    ];
    final harsh = findHarshDecelerations(profile);
    // All three harsh steps belong to one event.
    expect(harsh, hasLength(1));
    expect(harsh.single.fromMps, closeTo(15.0, 0.01));
    expect(harsh.single.toMps, closeTo(3.0, 0.01)); // last harsh step's b.speedMps
    expect(harsh.single.peakDecelMs2, closeTo(4.0, 0.01));
  });

  test('harsh event still open at end of sequence is flushed', () {
    // When the sequence ends while still in a harsh deceleration (no
    // gentle recovery step), the open event must still be emitted.
    final t = start;
    final loc = const Coord(lat: 51.0, lon: 0.0);
    final profile = [
      SpeedPoint(time: t,                             location: loc, speedMps: 15.0),
      SpeedPoint(time: t.add(const Duration(seconds: 1)), location: loc, speedMps: 11.0), // harsh
      SpeedPoint(time: t.add(const Duration(seconds: 2)), location: loc, speedMps:  7.0), // harsh — sequence ends here
    ];
    final harsh = findHarshDecelerations(profile);
    expect(harsh, hasLength(1));
  });
}
