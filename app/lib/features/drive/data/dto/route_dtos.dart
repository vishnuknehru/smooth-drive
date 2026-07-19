import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/advice.dart';
import '../../domain/entities/route_analysis.dart';
import '../../domain/entities/upcoming.dart';

part 'route_dtos.freezed.dart';
part 'route_dtos.g.dart';

/// Wire-format mirrors of backend/src/smoothdrive/domain/models.py.
/// Unknown enum values decode to safe fallbacks so new backend event or
/// advice types never crash an older app.

enum EventTypeDto {
  @JsonValue('speed_limit')
  speedLimit,
  @JsonValue('traffic_signal')
  trafficSignal,
  @JsonValue('roundabout')
  roundabout,
  unknown,
}

enum AdviceActionDto {
  @JsonValue('maintain')
  maintain,
  @JsonValue('ease_off')
  easeOff,
  @JsonValue('brake_gently')
  brakeGently,
  @JsonValue('brake')
  brake,
  @JsonValue('prepare_signal')
  prepareSignal,
}

@freezed
abstract class CoordinateDto with _$CoordinateDto {
  const factory CoordinateDto({required double lat, required double lon}) =
      _CoordinateDto;

  factory CoordinateDto.fromJson(Map<String, dynamic> json) =>
      _$CoordinateDtoFromJson(json);
}

@freezed
abstract class EventDto with _$EventDto {
  const factory EventDto({
    @JsonKey(unknownEnumValue: EventTypeDto.unknown) required EventTypeDto type,
    required double distanceMeters,
    required CoordinateDto location,
    int? valueMph,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);
}

@freezed
abstract class RouteAnalysisDto with _$RouteAnalysisDto {
  const factory RouteAnalysisDto({
    required String routeId,
    required double distanceMeters,
    required List<CoordinateDto> geometry,
    required List<EventDto> events,
  }) = _RouteAnalysisDto;

  factory RouteAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$RouteAnalysisDtoFromJson(json);
}

@freezed
abstract class UpcomingEventDto with _$UpcomingEventDto {
  const factory UpcomingEventDto({
    @JsonKey(unknownEnumValue: EventTypeDto.unknown) required EventTypeDto type,
    required double distanceAheadMeters,
    required CoordinateDto location,
    int? valueMph,
  }) = _UpcomingEventDto;

  factory UpcomingEventDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingEventDtoFromJson(json);
}

@freezed
abstract class AdviceDto with _$AdviceDto {
  const factory AdviceDto({
    @JsonKey(unknownEnumValue: AdviceActionDto.maintain)
    required AdviceActionDto action,
    double? actInSeconds,
    int? targetMph,
    UpcomingEventDto? event,
    required String message,
  }) = _AdviceDto;

  factory AdviceDto.fromJson(Map<String, dynamic> json) =>
      _$AdviceDtoFromJson(json);
}

@freezed
abstract class UpcomingResponseDto with _$UpcomingResponseDto {
  const factory UpcomingResponseDto({
    required String routeId,
    required double positionOnRouteMeters,
    required bool offRoute,
    required List<UpcomingEventDto> events,
    AdviceDto? advice,
  }) = _UpcomingResponseDto;

  factory UpcomingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingResponseDtoFromJson(json);
}

extension CoordinateDtoX on CoordinateDto {
  Coord toEntity() => Coord(lat: lat, lon: lon);
}

extension EventTypeDtoX on EventTypeDto {
  EventType toEntity() => switch (this) {
    EventTypeDto.speedLimit => EventType.speedLimit,
    EventTypeDto.trafficSignal => EventType.trafficSignal,
    EventTypeDto.roundabout => EventType.roundabout,
    EventTypeDto.unknown => EventType.unknown,
  };
}

extension EventDtoX on EventDto {
  RouteEvent toEntity() => RouteEvent(
    type: type.toEntity(),
    distanceMeters: distanceMeters,
    location: location.toEntity(),
    valueMph: valueMph,
  );
}

extension RouteAnalysisDtoX on RouteAnalysisDto {
  RouteAnalysis toEntity() => RouteAnalysis(
    routeId: routeId,
    distanceMeters: distanceMeters,
    geometry: [for (final c in geometry) c.toEntity()],
    events: [for (final e in events) e.toEntity()],
  );
}

extension UpcomingEventDtoX on UpcomingEventDto {
  UpcomingEvent toEntity() => UpcomingEvent(
    type: type.toEntity(),
    distanceAheadMeters: distanceAheadMeters,
    location: location.toEntity(),
    valueMph: valueMph,
  );
}

extension AdviceDtoX on AdviceDto {
  Advice toEntity() => Advice(
    action: switch (action) {
      AdviceActionDto.maintain => AdviceAction.maintain,
      AdviceActionDto.easeOff => AdviceAction.easeOff,
      AdviceActionDto.brakeGently => AdviceAction.brakeGently,
      AdviceActionDto.brake => AdviceAction.brake,
      AdviceActionDto.prepareSignal => AdviceAction.prepareSignal,
    },
    actInSeconds: actInSeconds,
    targetMph: targetMph,
    event: event?.toEntity(),
    message: message,
  );
}

extension UpcomingResponseDtoX on UpcomingResponseDto {
  PositionUpdate toEntity() => PositionUpdate(
    routeId: routeId,
    positionOnRouteMeters: positionOnRouteMeters,
    offRoute: offRoute,
    events: [for (final e in events) e.toEntity()],
    advice: advice?.toEntity(),
  );
}
