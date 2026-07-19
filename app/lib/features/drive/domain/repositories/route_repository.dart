import '../entities/route_analysis.dart';
import '../entities/upcoming.dart';

abstract interface class RouteRepository {
  /// Emits when a route was transparently re-analyzed after the backend
  /// lost its cache (see [upcoming]); listeners should swap geometry.
  Stream<RouteAnalysis> get routeRefreshed;

  Future<RouteAnalysis> analyzeRoute({
    required Coord start,
    required Coord end,
  });

  /// [speedMps] enables driving advice in the response. Recovers from an
  /// expired route id by re-analyzing the last route once and retrying.
  Future<PositionUpdate> upcoming({
    required String routeId,
    required Coord position,
    double? speedMps,
  });

  Future<bool> healthCheck();
}
