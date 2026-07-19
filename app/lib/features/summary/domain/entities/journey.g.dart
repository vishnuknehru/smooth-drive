// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HarshEvent _$HarshEventFromJson(Map<String, dynamic> json) => _HarshEvent(
  time: DateTime.parse(json['time'] as String),
  location: Coord.fromJson(json['location'] as Map<String, dynamic>),
  fromMps: (json['from_mps'] as num).toDouble(),
  toMps: (json['to_mps'] as num).toDouble(),
  peakDecelMs2: (json['peak_decel_ms2'] as num).toDouble(),
);

Map<String, dynamic> _$HarshEventToJson(_HarshEvent instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'location': instance.location,
      'from_mps': instance.fromMps,
      'to_mps': instance.toMps,
      'peak_decel_ms2': instance.peakDecelMs2,
    };

_JourneySample _$JourneySampleFromJson(Map<String, dynamic> json) =>
    _JourneySample(
      time: DateTime.parse(json['time'] as String),
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      speedMps: (json['speed_mps'] as num).toDouble(),
      limitMph: (json['limit_mph'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JourneySampleToJson(_JourneySample instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'coord': instance.coord,
      'speed_mps': instance.speedMps,
      'limit_mph': instance.limitMph,
    };

_Journey _$JourneyFromJson(Map<String, dynamic> json) => _Journey(
  id: json['id'] as String,
  startedAt: DateTime.parse(json['started_at'] as String),
  endedAt: DateTime.parse(json['ended_at'] as String),
  start: Coord.fromJson(json['start'] as Map<String, dynamic>),
  end: Coord.fromJson(json['end'] as Map<String, dynamic>),
  distanceMeters: (json['distance_meters'] as num).toDouble(),
  durationSeconds: (json['duration_seconds'] as num).toDouble(),
  harshEvents: (json['harsh_events'] as List<dynamic>)
      .map((e) => HarshEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
  lateReactions: (json['late_reactions'] as num).toInt(),
  score: (json['score'] as num).toInt(),
  speedComplianceRatio: (json['speed_compliance_ratio'] as num?)?.toDouble(),
  samples: (json['samples'] as List<dynamic>)
      .map((e) => JourneySample.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JourneyToJson(_Journey instance) => <String, dynamic>{
  'id': instance.id,
  'started_at': instance.startedAt.toIso8601String(),
  'ended_at': instance.endedAt.toIso8601String(),
  'start': instance.start,
  'end': instance.end,
  'distance_meters': instance.distanceMeters,
  'duration_seconds': instance.durationSeconds,
  'harsh_events': instance.harshEvents,
  'late_reactions': instance.lateReactions,
  'score': instance.score,
  'speed_compliance_ratio': instance.speedComplianceRatio,
  'samples': instance.samples,
};
