import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/failure.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/units.dart';
import '../domain/entities/route_analysis.dart';
import '../domain/entities/upcoming.dart';
import '../domain/repositories/route_repository.dart';
import 'dto/route_dtos.dart';
import 'route_remote_data_source.dart';

part 'route_repository_impl.g.dart';

class RouteRepositoryImpl implements RouteRepository {
  RouteRepositoryImpl(this._remote);

  final RouteRemoteDataSource _remote;

  ({Coord start, Coord end})? _lastEndpoints;
  final _routeRefreshed = StreamController<RouteAnalysis>.broadcast();

  @override
  Stream<RouteAnalysis> get routeRefreshed => _routeRefreshed.stream;

  @override
  Future<RouteAnalysis> analyzeRoute({
    required Coord start,
    required Coord end,
  }) async {
    final dto = await _remote.analyze(start: start, end: end);
    _lastEndpoints = (start: start, end: end);
    return dto.toEntity();
  }

  @override
  Future<PositionUpdate> upcoming({
    required String routeId,
    required Coord position,
    double? speedMps,
  }) async {
    final speedMph = speedMps == null ? null : speedMps / mpsPerMph;
    try {
      final dto = await _remote.upcoming(
        routeId: routeId,
        position: position,
        speedMph: speedMph,
      );
      return dto.toEntity();
    } on RouteExpiredFailure {
      final endpoints = _lastEndpoints;
      if (endpoints == null) rethrow;
      // Backend restarted and lost its in-memory route cache: re-analyze
      // once and retry. A second 404 propagates — no retry loop.
      final refreshed = await analyzeRoute(
        start: endpoints.start,
        end: endpoints.end,
      );
      _routeRefreshed.add(refreshed);
      final dto = await _remote.upcoming(
        routeId: refreshed.routeId,
        position: position,
        speedMph: speedMph,
      );
      return dto.toEntity();
    }
  }

  @override
  Future<bool> healthCheck() => _remote.health();

  void dispose() {
    unawaited(_routeRefreshed.close());
  }
}

@Riverpod(keepAlive: true)
RouteRepository routeRepository(Ref ref) {
  final repository = RouteRepositoryImpl(
    RouteRemoteDataSource(ref.watch(dioProvider)),
  );
  ref.onDispose(repository.dispose);
  return repository;
}
