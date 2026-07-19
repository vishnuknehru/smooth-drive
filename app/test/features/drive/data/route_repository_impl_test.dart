import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:smoothdrive/core/error/failure.dart';
import 'package:smoothdrive/features/drive/data/dto/route_dtos.dart';
import 'package:smoothdrive/features/drive/data/route_remote_data_source.dart';
import 'package:smoothdrive/features/drive/data/route_repository_impl.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';

const start = Coord(lat: 51.0, lon: 0.0);
const end = Coord(lat: 51.02, lon: 0.0);
const position = Coord(lat: 51.005, lon: 0.0);

Map<String, dynamic> fixture(String name) =>
    jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;

/// Fake remote whose first [failuresBeforeSuccess] upcoming calls 404,
/// for exercising the route-expired recovery path deterministically.
class _ExpiringRemote extends RouteRemoteDataSource {
  _ExpiringRemote({required this.failuresBeforeSuccess}) : super(Dio());

  final int failuresBeforeSuccess;
  int analyzeCalls = 0;
  int upcomingCalls = 0;

  @override
  Future<RouteAnalysisDto> analyze({
    required Coord start,
    required Coord end,
  }) async {
    analyzeCalls++;
    return RouteAnalysisDto.fromJson(fixture('analyze_response.json'));
  }

  @override
  Future<UpcomingResponseDto> upcoming({
    required String routeId,
    required Coord position,
    double? speedMph,
  }) async {
    upcomingCalls++;
    if (upcomingCalls <= failuresBeforeSuccess) {
      throw const RouteExpiredFailure();
    }
    return UpcomingResponseDto.fromJson(
      fixture('upcoming_advice_response.json'),
    );
  }
}

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late RouteRepositoryImpl repo;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://test.local'));
    adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    repo = RouteRepositoryImpl(RouteRemoteDataSource(dio));
    addTearDown(repo.dispose);
  });

  test('analyzeRoute maps the response to an entity', () async {
    adapter.onPost('/api/route/analyze', (server) {
      server.reply(200, fixture('analyze_response.json'));
    });

    final analysis = await repo.analyzeRoute(start: start, end: end);
    expect(analysis.routeId, isNotEmpty);
    expect(analysis.events, isNotEmpty);
  });

  test('upcoming converts m/s to mph on the wire', () async {
    adapter.onPost('/api/position/upcoming', (server) {
      server.reply(200, fixture('upcoming_advice_response.json'));
    });

    final update = await repo.upcoming(
      routeId: 'abc123def456',
      position: position,
      speedMps: 20.1168, // exactly 45 mph
    );
    expect(update.advice, isNotNull);
  });

  group('error mapping', () {
    test('422 -> ValidationFailure', () async {
      adapter.onPost('/api/route/analyze', (server) {
        server.reply(422, fixture('analyze_422_response.json'));
      });
      expect(
        () => repo.analyzeRoute(start: start, end: end),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('502 -> UpstreamFailure', () async {
      adapter.onPost('/api/route/analyze', (server) {
        server.reply(502, {'detail': 'routing provider unavailable'});
      });
      expect(
        () => repo.analyzeRoute(start: start, end: end),
        throwsA(isA<UpstreamFailure>()),
      );
    });

    test('timeout -> NetworkFailure', () async {
      adapter.onPost('/api/route/analyze', (server) {
        server.throws(
          0,
          DioException.connectionTimeout(
            requestOptions: RequestOptions(path: '/api/route/analyze'),
            timeout: const Duration(seconds: 5),
          ),
        );
      });
      expect(
        () => repo.analyzeRoute(start: start, end: end),
        throwsA(isA<NetworkFailure>()),
      );
    });
  });

  group('404 route-expired recovery', () {
    test('re-analyzes once, emits routeRefreshed, retries upcoming', () async {
      final remote = _ExpiringRemote(failuresBeforeSuccess: 1);
      final repo = RouteRepositoryImpl(remote);
      addTearDown(repo.dispose);

      final refreshedEvents = <RouteAnalysis>[];
      final sub = repo.routeRefreshed.listen(refreshedEvents.add);
      addTearDown(sub.cancel);

      final original = await repo.analyzeRoute(start: start, end: end);
      final update = await repo.upcoming(
        routeId: original.routeId,
        position: position,
        speedMps: 20.0,
      );

      expect(update.advice, isNotNull);
      expect(remote.analyzeCalls, 2, reason: 'one initial + one recovery');
      expect(remote.upcomingCalls, 2, reason: 'one 404 + one retry');
      await Future<void>.delayed(Duration.zero);
      expect(refreshedEvents, hasLength(1));
    });

    test('a second consecutive 404 propagates — no retry loop', () async {
      final remote = _ExpiringRemote(failuresBeforeSuccess: 99);
      final repo = RouteRepositoryImpl(remote);
      addTearDown(repo.dispose);

      final original = await repo.analyzeRoute(start: start, end: end);
      await expectLater(
        repo.upcoming(routeId: original.routeId, position: position),
        throwsA(isA<RouteExpiredFailure>()),
      );
      expect(remote.analyzeCalls, 2, reason: 'exactly one recovery attempt');
      expect(remote.upcomingCalls, 2);
    });

    test('404 with no prior analyze rethrows RouteExpiredFailure', () async {
      adapter.onPost('/api/position/upcoming', (server) {
        server.reply(404, fixture('upcoming_404_response.json'));
      });
      expect(
        () => repo.upcoming(routeId: 'deadbeef0000', position: position),
        throwsA(isA<RouteExpiredFailure>()),
      );
    });
  });

  test('healthCheck true on ok, false on network error', () async {
    adapter.onGet('/health', (server) {
      server.reply(200, {'status': 'ok'});
    });
    expect(await repo.healthCheck(), isTrue);

    adapter.onGet('/health', (server) {
      server.throws(
        0,
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/health'),
          reason: 'refused',
        ),
      );
    });
    expect(await repo.healthCheck(), isFalse);
  });
}
