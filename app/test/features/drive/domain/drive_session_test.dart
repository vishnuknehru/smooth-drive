import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/error/failure.dart';
import 'package:smoothdrive/features/drive/domain/entities/advice.dart';
import 'package:smoothdrive/features/drive/domain/entities/geo_sample.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/domain/entities/upcoming.dart';
import 'package:smoothdrive/features/drive/domain/repositories/route_repository.dart';
import 'package:smoothdrive/features/drive/domain/services/drive_session.dart';
import 'package:smoothdrive/features/drive/domain/services/journey_recorder.dart';
import 'package:smoothdrive/features/drive/domain/services/location_service.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

const route = RouteAnalysis(
  routeId: 'route-one',
  distanceMeters: 2224,
  geometry: [Coord(lat: 51.0, lon: 0.0), Coord(lat: 51.02, lon: 0.0)],
  events: [
    RouteEvent(
      type: EventType.speedLimit,
      distanceMeters: 0,
      location: Coord(lat: 51.0, lon: 0.0),
      valueMph: 40,
    ),
    RouteEvent(
      type: EventType.speedLimit,
      distanceMeters: 1112,
      location: Coord(lat: 51.01, lon: 0.0),
      valueMph: 30,
    ),
    RouteEvent(
      type: EventType.trafficSignal,
      distanceMeters: 1500,
      location: Coord(lat: 51.014, lon: 0.0),
    ),
  ],
);

GeoSample sampleAt(int second) => GeoSample(
  time: t0.add(Duration(seconds: second)),
  coord: Coord(lat: 51.0 + second * 0.0001, lon: 0.0),
  speedMps: 15,
  accuracyM: 5,
);

PositionUpdate updateAt(
  double position, {
  bool offRoute = false,
  Advice? advice,
  String routeId = 'route-one',
}) => PositionUpdate(
  routeId: routeId,
  positionOnRouteMeters: position,
  offRoute: offRoute,
  events: const [],
  advice: advice,
);

class FakeLocation implements LocationService {
  final controller = StreamController<GeoSample>.broadcast(sync: true);

  @override
  Future<LocationPermissionStatus> ensurePermission() async =>
      LocationPermissionStatus.granted;

  @override
  Future<GeoSample> currentPosition() async => sampleAt(0);

  @override
  Stream<GeoSample> positionStream() => controller.stream;
}

class FakeRepo implements RouteRepository {
  final refreshController = StreamController<RouteAnalysis>.broadcast(
    sync: true,
  );
  final calls = <({String routeId, double? speedMps})>[];
  Duration responseDelay = Duration.zero;

  /// Called with the zero-based request index to produce each response.
  PositionUpdate Function(int index) responder = _defaultResponder;

  static PositionUpdate _defaultResponder(int _) => updateAt(0);

  @override
  Stream<RouteAnalysis> get routeRefreshed => refreshController.stream;

  @override
  Future<RouteAnalysis> analyzeRoute({
    required Coord start,
    required Coord end,
  }) async => route;

  @override
  Future<PositionUpdate> upcoming({
    required String routeId,
    required Coord position,
    double? speedMps,
  }) async {
    final index = calls.length;
    calls.add((routeId: routeId, speedMps: speedMps));
    if (responseDelay > Duration.zero) {
      await Future<void>.delayed(responseDelay);
    }
    return responder(index);
  }

  @override
  Future<bool> healthCheck() async => true;
}

typedef Harness = ({
  DriveSession session,
  FakeLocation location,
  FakeRepo repo,
  JourneyRecorder recorder,
  List<DriveTick> ticks,
});

Harness harness(FakeAsync fake) {
  final location = FakeLocation();
  final repo = FakeRepo();
  final recorder = JourneyRecorder();
  final session = DriveSession(
    repository: repo,
    location: location,
    recorder: recorder,
    now: () => t0.add(fake.elapsed),
  );
  final ticks = <DriveTick>[];
  session.start(route).listen(ticks.add);
  return (
    session: session,
    location: location,
    repo: repo,
    recorder: recorder,
    ticks: ticks,
  );
}

void main() {
  test('polls once per second at 1 Hz GPS with fast responses', () {
    fakeAsync((fake) {
      final h = harness(fake);
      for (var i = 0; i < 5; i++) {
        h.location.controller.add(sampleAt(i));
        fake.elapse(const Duration(seconds: 1));
      }
      expect(h.repo.calls, hasLength(5));
      expect(h.repo.calls.first.speedMps, 15);
    });
  });

  test('throttles samples arriving faster than the request gap', () {
    fakeAsync((fake) {
      final h = harness(fake);
      // 3 samples within 600 ms: only the first may trigger a request.
      for (var i = 0; i < 3; i++) {
        h.location.controller.add(sampleAt(i));
        fake.elapse(const Duration(milliseconds: 300));
      }
      expect(h.repo.calls, hasLength(1));
    });
  });

  test('skips polls while a slow request is in flight', () {
    fakeAsync((fake) {
      final h = harness(fake);
      h.repo.responseDelay = const Duration(milliseconds: 2500);
      for (var i = 0; i < 4; i++) {
        h.location.controller.add(sampleAt(i));
        fake.elapse(const Duration(seconds: 1));
      }
      // t=0 request completes at t=2.5s; samples at 1s and 2s are skipped;
      // the t=3s sample polls again.
      expect(h.repo.calls, hasLength(2));
    });
  });

  test('derives the current limit from route events', () {
    fakeAsync((fake) {
      final h = harness(fake);
      final positions = [500.0, 1200.0];
      h.repo.responder = (i) => updateAt(positions[i]);

      h.location.controller.add(sampleAt(0));
      fake.elapse(const Duration(seconds: 1));
      expect(h.ticks.last.currentLimitMph, 40);

      h.location.controller.add(sampleAt(1));
      fake.elapse(const Duration(seconds: 1));
      expect(h.ticks.last.currentLimitMph, 30);
    });
  });

  test('off-route banner needs a 5-tick streak; advice not recorded', () {
    fakeAsync((fake) {
      final h = harness(fake);
      h.repo.responder = (_) => updateAt(
        500,
        offRoute: true,
        advice: const Advice(
          action: AdviceAction.brake,
          message: 'noise while off route',
        ),
      );
      for (var i = 0; i < 6; i++) {
        h.location.controller.add(sampleAt(i));
        fake.elapse(const Duration(seconds: 1));
      }
      expect(h.ticks.last.offRoute, isTrue);
      // The first four responses must not have flagged it.
      final earlier = h.ticks.where((t) => t.update != null).take(4);
      expect(earlier.every((t) => !t.offRoute), isTrue);
      // Off-route advice is noise and never counts as a late reaction.
      expect(h.recorder.lateReactions, 0);
    });
  });

  test('on-route braking advice reaches the recorder', () {
    fakeAsync((fake) {
      final h = harness(fake);
      h.repo.responder = (_) => updateAt(
        500,
        advice: const Advice(
          action: AdviceAction.brakeGently,
          targetMph: 30,
          message: 'brake gently',
        ),
      );
      h.location.controller.add(sampleAt(0));
      fake.elapse(const Duration(seconds: 1));
      expect(h.recorder.lateReactions, 1);
    });
  });

  test('a failed poll surfaces on the tick and the drive continues', () {
    fakeAsync((fake) {
      final h = harness(fake);
      var call = 0;
      h.repo.responder = (_) {
        if (call++ == 0) throw const NetworkFailure();
        return updateAt(600);
      };
      h.location.controller.add(sampleAt(0));
      fake.elapse(const Duration(seconds: 1));
      expect(h.ticks.last.failure, isA<NetworkFailure>());

      h.location.controller.add(sampleAt(1));
      fake.elapse(const Duration(seconds: 1));
      expect(h.ticks.last.failure, isNull);
      expect(h.ticks.last.update, isNotNull);
    });
  });

  test('routeRefreshed swaps the id used for subsequent polls', () {
    fakeAsync((fake) {
      final h = harness(fake);
      h.location.controller.add(sampleAt(0));
      fake.elapse(const Duration(seconds: 1));
      expect(h.repo.calls.last.routeId, 'route-one');

      h.repo.refreshController.add(route.copyWith(routeId: 'route-two'));
      h.location.controller.add(sampleAt(1));
      fake.elapse(const Duration(seconds: 1));
      expect(h.repo.calls.last.routeId, 'route-two');
    });
  });

  test('stop finalizes the journey from recorded samples', () async {
    final location = FakeLocation();
    final repo = FakeRepo();
    final recorder = JourneyRecorder();
    final session = DriveSession(
      repository: repo,
      location: location,
      recorder: recorder,
    );
    session.start(route);
    for (var i = 0; i < 3; i++) {
      location.controller.add(sampleAt(i));
      await Future<void>.delayed(Duration.zero);
    }
    final Journey journey = await session.stop(journeyId: 'j1');
    expect(journey.id, 'j1');
    expect(journey.startedAt, t0);
    expect(journey.samples, isNotEmpty);
  });
}
