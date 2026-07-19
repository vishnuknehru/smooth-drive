import 'package:freezed_annotation/freezed_annotation.dart';

import 'advice.dart';
import 'route_analysis.dart';

part 'upcoming.freezed.dart';

@freezed
abstract class UpcomingEvent with _$UpcomingEvent {
  const factory UpcomingEvent({
    required EventType type,
    required double distanceAheadMeters,
    required Coord location,
    int? valueMph,
  }) = _UpcomingEvent;
}

@freezed
abstract class PositionUpdate with _$PositionUpdate {
  const factory PositionUpdate({
    required String routeId,
    required double positionOnRouteMeters,
    required bool offRoute,

    /// Events ahead of the current position, sorted by distance.
    required List<UpcomingEvent> events,

    /// Present only when the request included a speed.
    Advice? advice,
  }) = _PositionUpdate;
}
