import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../drive/domain/entities/route_analysis.dart';

part 'journey.freezed.dart';
part 'journey.g.dart';

/// A sustained deceleration above the harsh threshold.
@freezed
abstract class HarshEvent with _$HarshEvent {
  const factory HarshEvent({
    required DateTime time,
    required Coord location,
    required double fromMps,
    required double toMps,
    required double peakDecelMs2,
  }) = _HarshEvent;

  factory HarshEvent.fromJson(Map<String, dynamic> json) =>
      _$HarshEventFromJson(json);
}

/// Decimated position/speed sample kept for the summary chart.
@freezed
abstract class JourneySample with _$JourneySample {
  const factory JourneySample({
    required DateTime time,
    required Coord coord,
    required double speedMps,

    /// Sign value in force at this point, when known.
    int? limitMph,
  }) = _JourneySample;

  factory JourneySample.fromJson(Map<String, dynamic> json) =>
      _$JourneySampleFromJson(json);
}

@freezed
abstract class Journey with _$Journey {
  const factory Journey({
    required String id,
    required DateTime startedAt,
    required DateTime endedAt,
    required Coord start,
    required Coord end,
    required double distanceMeters,
    required double durationSeconds,
    required List<HarshEvent> harshEvents,
    required int lateReactions,

    /// 0–100, matching the backend replay tool's scoring.
    required int score,

    /// Fraction of samples at or under the limit (+2 mph tolerance);
    /// null when no limit was ever known.
    double? speedComplianceRatio,
    required List<JourneySample> samples,
  }) = _Journey;

  factory Journey.fromJson(Map<String, dynamic> json) =>
      _$JourneyFromJson(json);
}
