import '../../../core/utils/geo.dart';
import '../../drive/domain/entities/route_analysis.dart';
import 'entities/journey.dart';

/// Post-drive smoothness analysis from a recorded GPS track.
///
/// Line-for-line port of backend services/smoothness.py so on-device scores
/// match the validated gpx_replay tool: segment speeds from consecutive
/// samples, 3-sample moving average, contiguous decelerations above the
/// harsh threshold merged into events, score = 100 − 10·harsh − 5·late.
/// Scoring changes must land in both places.
const harshDecelMs2 = 3.0;
const harshPenalty = 10;
const lateReactionPenalty = 5;
const _smoothWindow = 3;

class SpeedPoint {
  const SpeedPoint({
    required this.time,
    required this.location,
    required this.speedMps,
  });

  final DateTime time;
  final Coord location;
  final double speedMps;
}

class SmoothnessResult {
  const SmoothnessResult({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.harshEvents,
    required this.lateReactions,
    required this.score,
  });

  final double distanceMeters;
  final double durationSeconds;
  final List<HarshEvent> harshEvents;
  final int lateReactions;
  final int score;
}

List<double> _smooth(List<double> values, {int window = _smoothWindow}) {
  final half = window ~/ 2;
  return [
    for (var i = 0; i < values.length; i++)
      () {
        final lo = i - half < 0 ? 0 : i - half;
        final hi = i + half + 1 > values.length ? values.length : i + half + 1;
        final slice = values.sublist(lo, hi);
        return slice.reduce((a, b) => a + b) / slice.length;
      }(),
  ];
}

double _distance(Coord a, Coord b) =>
    haversineMeters(lat1: a.lat, lon1: a.lon, lat2: b.lat, lon2: b.lon);

/// Smoothed speed at each sample after the first (segment speed at its end).
List<SpeedPoint> speedProfile(List<(DateTime, Coord)> samples) {
  final raw = <double>[];
  final kept = <(DateTime, Coord)>[];
  for (var i = 0; i < samples.length - 1; i++) {
    final (t1, p1) = samples[i];
    final (t2, p2) = samples[i + 1];
    final dt = t2.difference(t1).inMicroseconds / 1e6;
    if (dt <= 0) continue;
    raw.add(_distance(p1, p2) / dt);
    kept.add((t2, p2));
  }
  final smoothed = _smooth(raw);
  return [
    for (var i = 0; i < kept.length; i++)
      SpeedPoint(time: kept[i].$1, location: kept[i].$2, speedMps: smoothed[i]),
  ];
}

/// Contiguous stretches where deceleration exceeds [harshDecelMs2].
List<HarshEvent> findHarshDecelerations(List<SpeedPoint> profile) {
  final events = <HarshEvent>[];
  HarshEvent? current;
  for (var i = 0; i < profile.length - 1; i++) {
    final a = profile[i];
    final b = profile[i + 1];
    final dt = b.time.difference(a.time).inMicroseconds / 1e6;
    final decel = (a.speedMps - b.speedMps) / dt;
    if (decel > harshDecelMs2) {
      current = current == null
          ? HarshEvent(
              time: a.time,
              location: a.location,
              fromMps: a.speedMps,
              toMps: b.speedMps,
              peakDecelMs2: decel,
            )
          : current.copyWith(
              toMps: b.speedMps,
              peakDecelMs2: decel > current.peakDecelMs2
                  ? decel
                  : current.peakDecelMs2,
            );
    } else if (current != null) {
      events.add(current);
      current = null;
    }
  }
  if (current != null) events.add(current);
  return events;
}

SmoothnessResult buildReport(
  List<(DateTime, Coord)> samples, {
  int lateReactions = 0,
}) {
  final profile = speedProfile(samples);
  final harsh = findHarshDecelerations(profile);
  var distance = 0.0;
  for (var i = 0; i < samples.length - 1; i++) {
    distance += _distance(samples[i].$2, samples[i + 1].$2);
  }
  final duration = samples.length > 1
      ? samples.last.$1.difference(samples.first.$1).inMicroseconds / 1e6
      : 0.0;
  final score =
      (100 - harshPenalty * harsh.length - lateReactionPenalty * lateReactions)
          .clamp(0, 100);
  return SmoothnessResult(
    distanceMeters: distance,
    durationSeconds: duration,
    harshEvents: harsh,
    lateReactions: lateReactions,
    score: score,
  );
}
