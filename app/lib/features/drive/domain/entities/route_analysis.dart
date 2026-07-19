import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_analysis.freezed.dart';
part 'route_analysis.g.dart';

@freezed
abstract class Coord with _$Coord {
  const factory Coord({required double lat, required double lon}) = _Coord;

  // Serializable so Journey (persisted locally) can embed coordinates.
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

enum EventType { speedLimit, trafficSignal, roundabout, unknown }

@freezed
abstract class RouteEvent with _$RouteEvent {
  const factory RouteEvent({
    required EventType type,
    required double distanceMeters,
    required Coord location,

    /// Legal sign value; only set for [EventType.speedLimit], and nullable
    /// even then (unknown limits).
    int? valueMph,
  }) = _RouteEvent;
}

@freezed
abstract class RouteAnalysis with _$RouteAnalysis {
  const factory RouteAnalysis({
    required String routeId,
    required double distanceMeters,
    required List<Coord> geometry,

    /// Ordered by distance from route start.
    required List<RouteEvent> events,
  }) = _RouteAnalysis;
}
