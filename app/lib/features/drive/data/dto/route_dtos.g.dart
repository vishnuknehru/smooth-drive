// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoordinateDto _$CoordinateDtoFromJson(Map<String, dynamic> json) =>
    _CoordinateDto(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinateDtoToJson(_CoordinateDto instance) =>
    <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

_EventDto _$EventDtoFromJson(Map<String, dynamic> json) => _EventDto(
  type: $enumDecode(
    _$EventTypeDtoEnumMap,
    json['type'],
    unknownValue: EventTypeDto.unknown,
  ),
  distanceMeters: (json['distance_meters'] as num).toDouble(),
  location: CoordinateDto.fromJson(json['location'] as Map<String, dynamic>),
  valueMph: (json['value_mph'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventDtoToJson(_EventDto instance) => <String, dynamic>{
  'type': _$EventTypeDtoEnumMap[instance.type]!,
  'distance_meters': instance.distanceMeters,
  'location': instance.location,
  'value_mph': instance.valueMph,
};

const _$EventTypeDtoEnumMap = {
  EventTypeDto.speedLimit: 'speed_limit',
  EventTypeDto.trafficSignal: 'traffic_signal',
  EventTypeDto.roundabout: 'roundabout',
  EventTypeDto.unknown: 'unknown',
};

_RouteAnalysisDto _$RouteAnalysisDtoFromJson(Map<String, dynamic> json) =>
    _RouteAnalysisDto(
      routeId: json['route_id'] as String,
      distanceMeters: (json['distance_meters'] as num).toDouble(),
      geometry: (json['geometry'] as List<dynamic>)
          .map((e) => CoordinateDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>)
          .map((e) => EventDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteAnalysisDtoToJson(_RouteAnalysisDto instance) =>
    <String, dynamic>{
      'route_id': instance.routeId,
      'distance_meters': instance.distanceMeters,
      'geometry': instance.geometry,
      'events': instance.events,
    };

_UpcomingEventDto _$UpcomingEventDtoFromJson(Map<String, dynamic> json) =>
    _UpcomingEventDto(
      type: $enumDecode(
        _$EventTypeDtoEnumMap,
        json['type'],
        unknownValue: EventTypeDto.unknown,
      ),
      distanceAheadMeters: (json['distance_ahead_meters'] as num).toDouble(),
      location: CoordinateDto.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      valueMph: (json['value_mph'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpcomingEventDtoToJson(_UpcomingEventDto instance) =>
    <String, dynamic>{
      'type': _$EventTypeDtoEnumMap[instance.type]!,
      'distance_ahead_meters': instance.distanceAheadMeters,
      'location': instance.location,
      'value_mph': instance.valueMph,
    };

_AdviceDto _$AdviceDtoFromJson(Map<String, dynamic> json) => _AdviceDto(
  action: $enumDecode(
    _$AdviceActionDtoEnumMap,
    json['action'],
    unknownValue: AdviceActionDto.maintain,
  ),
  actInSeconds: (json['act_in_seconds'] as num?)?.toDouble(),
  targetMph: (json['target_mph'] as num?)?.toInt(),
  event: json['event'] == null
      ? null
      : UpcomingEventDto.fromJson(json['event'] as Map<String, dynamic>),
  message: json['message'] as String,
);

Map<String, dynamic> _$AdviceDtoToJson(_AdviceDto instance) =>
    <String, dynamic>{
      'action': _$AdviceActionDtoEnumMap[instance.action]!,
      'act_in_seconds': instance.actInSeconds,
      'target_mph': instance.targetMph,
      'event': instance.event,
      'message': instance.message,
    };

const _$AdviceActionDtoEnumMap = {
  AdviceActionDto.maintain: 'maintain',
  AdviceActionDto.easeOff: 'ease_off',
  AdviceActionDto.brakeGently: 'brake_gently',
  AdviceActionDto.brake: 'brake',
  AdviceActionDto.prepareSignal: 'prepare_signal',
};

_UpcomingResponseDto _$UpcomingResponseDtoFromJson(Map<String, dynamic> json) =>
    _UpcomingResponseDto(
      routeId: json['route_id'] as String,
      positionOnRouteMeters: (json['position_on_route_meters'] as num)
          .toDouble(),
      offRoute: json['off_route'] as bool,
      events: (json['events'] as List<dynamic>)
          .map((e) => UpcomingEventDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      advice: json['advice'] == null
          ? null
          : AdviceDto.fromJson(json['advice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpcomingResponseDtoToJson(
  _UpcomingResponseDto instance,
) => <String, dynamic>{
  'route_id': instance.routeId,
  'position_on_route_meters': instance.positionOnRouteMeters,
  'off_route': instance.offRoute,
  'events': instance.events,
  'advice': instance.advice,
};
