import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/error/failure.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/features/drive/data/geolocator_location_service.dart';
import 'package:smoothdrive/features/drive/data/route_repository_impl.dart';
import 'package:smoothdrive/features/drive/domain/entities/drive_state.dart';
import 'package:smoothdrive/features/drive/domain/entities/geo_sample.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/domain/entities/upcoming.dart';
import 'package:smoothdrive/features/drive/domain/repositories/route_repository.dart';
import 'package:smoothdrive/features/drive/domain/services/location_service.dart';
import 'package:smoothdrive/features/drive/presentation/drive_controller.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);
const destination = Coord(lat: 51.33627, lon: -0.267567);

const route = RouteAnalysis(
  routeId: 'route-one',
  distanceMeters: 2224,
  geometry: [Coord(lat: 51.0, lon: 0.0)],
  events: [],
);

GeoSample sampleAt(int second) => GeoSample(
      time: t0.add(Duration(seconds: second)),
      coord: const Coord(lat: 51.0, lon: 0.0),
      speedMps: 15,
      accuracyM: 5,
    );

class FakeLocation implements LocationService {
  FakeLocation({this.permission = LocationPermissionStatus.granted});

  final LocationPermissionStatus permission;
  final controller = StreamController<GeoSample>.broadcast(sync: true);

  @override
  Future<LocationPermissionStatus> ensurePermission() async => permission;

  @override
  Future<GeoSample> currentPosition() async => sampleAt(0);

  @override
  Stream<GeoSample> positionStream() => controller.stream;
}

class FakeRepo implements RouteRepository {
  FakeRepo({this.analyzeFailure});

  final Failure? analyzeFailure;
  final refreshController =
      StreamController<RouteAnalysis>.broadcast(sync: true);

  @override
  Stream<RouteAnalysis> get routeRefreshed => refreshController.stream;

  @override
  Future<RouteAnalysis> analyzeRoute({
    required Coord start,
    required Coord end,
  }) async {
    if (analyzeFailure case final failure?) throw failure;
    return route;
  }

  @override
  Future<PositionUpdate> upcoming({
    required String routeId,
    required Coord position,
    double? speedMps,
  }) async =>
      PositionUpdate(
        routeId: routeId,
        positionOnRouteMeters: 100,
        offRoute: false,
        events: const [],
      );

  @override
  Future<bool> healthCheck() async => true;
}

ProviderContainer makeContainer({
  required FakeLocation location,
  required FakeRepo repo,
}) {
  final container = ProviderContainer(
    overrides: [
      locationServiceProvider.overrideWithValue(location),
      routeRepositoryProvider.overrideWithValue(repo),
      clockProvider.overrideWithValue(() => t0),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('happy path: idle -> driving, ticks update the state', () async {
    final location = FakeLocation();
    final container =
        makeContainer(location: location, repo: FakeRepo());
    final controller = container.read(driveControllerProvider.notifier);

    expect(container.read(driveControllerProvider), const DriveState.idle());

    await controller.startDrive(destination: destination);
    final driving = container.read(driveControllerProvider);
    expect(driving, isA<DriveDriving>());
    expect((driving as DriveDriving).route.routeId, 'route-one');

    location.controller.add(sampleAt(1));
    await Future<void>.delayed(Duration.zero);
    final ticked = container.read(driveControllerProvider) as DriveDriving;
    expect(ticked.tick, isNotNull);
    expect(ticked.tick!.sample.speedMps, 15);
  });

  test('permission denied -> error state with guidance', () async {
    final container = makeContainer(
      location: FakeLocation(permission: LocationPermissionStatus.deniedForever),
      repo: FakeRepo(),
    );
    final controller = container.read(driveControllerProvider.notifier);
    await controller.startDrive(destination: destination);
    final state = container.read(driveControllerProvider);
    expect(state, isA<DriveError>());
    expect((state as DriveError).failure, isA<LocationFailure>());
    expect(state.failure.message, contains('system settings'));
  });

  test('analyze failure -> error state, reset returns to idle', () async {
    final container = makeContainer(
      location: FakeLocation(),
      repo: FakeRepo(analyzeFailure: const UpstreamFailure()),
    );
    final controller = container.read(driveControllerProvider.notifier);
    await controller.startDrive(destination: destination);
    expect(container.read(driveControllerProvider), isA<DriveError>());

    controller.reset();
    expect(container.read(driveControllerProvider), const DriveState.idle());
  });

  test('endDrive finalizes and lands in done with a journey', () async {
    final location = FakeLocation();
    final container =
        makeContainer(location: location, repo: FakeRepo());
    final controller = container.read(driveControllerProvider.notifier);

    await controller.startDrive(destination: destination);
    for (var i = 0; i < 3; i++) {
      location.controller.add(sampleAt(i));
      await Future<void>.delayed(Duration.zero);
    }
    final journey = await controller.endDrive();
    expect(journey, isNotNull);
    final state = container.read(driveControllerProvider);
    expect(state, isA<DriveDone>());
    expect((state as DriveDone).journey.id, journey!.id);
  });

  test('startDrive is a no-op while already driving', () async {
    final location = FakeLocation();
    final repo = FakeRepo();
    final container = makeContainer(location: location, repo: repo);
    final controller = container.read(driveControllerProvider.notifier);

    await controller.startDrive(destination: destination);
    final first = container.read(driveControllerProvider);
    await controller.startDrive(destination: destination);
    expect(container.read(driveControllerProvider), same(first));
  });
}
