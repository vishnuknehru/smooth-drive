import '../../../../core/utils/units.dart';
import '../../../summary/domain/entities/journey.dart';
import '../../../summary/domain/smoothness_analyzer.dart';
import '../entities/advice.dart';
import '../entities/geo_sample.dart';
import '../entities/route_analysis.dart';

/// Compliance tolerance above the sign value before a sample counts as
/// speeding. Client-side assumption; the backend has no equivalent metric.
const complianceToleranceMph = 2;

/// Buffers GPS samples during a drive and counts late reactions with the
/// same semantics as tools/gpx_replay.py: an advice change that arrives
/// already escalated to braking means the driver reacted late.
class JourneyRecorder {
  final List<GeoSample> _samples = [];
  final List<int?> _limits = [];
  (AdviceAction, int?, EventType?)? _lastAdviceKey;
  int _lateReactions = 0;

  int get lateReactions => _lateReactions;

  bool get isEmpty => _samples.isEmpty;

  void addSample(GeoSample sample, {int? currentLimitMph}) {
    _samples.add(sample);
    _limits.add(currentLimitMph);
  }

  /// Call only for on-route updates, mirroring the replay tool.
  void recordAdvice(Advice advice) {
    final key = (advice.action, advice.targetMph, advice.event?.type);
    if (key == _lastAdviceKey) return;
    if (advice.action == AdviceAction.brakeGently ||
        advice.action == AdviceAction.brake) {
      _lateReactions++;
    }
    _lastAdviceKey = key;
  }

  Journey finalize({required String id}) {
    assert(_samples.isNotEmpty, 'finalize called with no samples');
    final result = buildReport([
      for (final s in _samples) (s.time, s.coord),
    ], lateReactions: _lateReactions);

    var known = 0;
    var compliant = 0;
    for (var i = 0; i < _samples.length; i++) {
      final limit = _limits[i];
      if (limit == null) continue;
      known++;
      if (_samples[i].speedMps <=
          (limit + complianceToleranceMph) * mpsPerMph) {
        compliant++;
      }
    }

    return Journey(
      id: id,
      startedAt: _samples.first.time,
      endedAt: _samples.last.time,
      start: _samples.first.coord,
      end: _samples.last.coord,
      distanceMeters: result.distanceMeters,
      durationSeconds: result.durationSeconds,
      harshEvents: result.harshEvents,
      lateReactions: result.lateReactions,
      score: result.score,
      speedComplianceRatio: known == 0 ? null : compliant / known,
      samples: _decimated(),
    );
  }

  /// Keep at most one sample per 2 s so journey files stay small.
  List<JourneySample> _decimated() {
    final kept = <JourneySample>[];
    DateTime? lastKept;
    for (var i = 0; i < _samples.length; i++) {
      final s = _samples[i];
      if (lastKept != null &&
          s.time.difference(lastKept) < const Duration(seconds: 2)) {
        continue;
      }
      lastKept = s.time;
      kept.add(
        JourneySample(
          time: s.time,
          coord: s.coord,
          speedMps: s.speedMps,
          limitMph: _limits[i],
        ),
      );
    }
    return kept;
  }
}
