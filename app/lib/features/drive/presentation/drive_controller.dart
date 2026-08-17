import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/failure.dart';
import '../../../core/providers.dart';
import '../../summary/data/file_journey_repository.dart';
import '../../summary/domain/entities/journey.dart';
import '../data/geolocator_location_service.dart';
import '../data/route_repository_impl.dart';
import '../domain/entities/drive_state.dart';
import '../domain/entities/route_analysis.dart';
import '../domain/services/drive_session.dart';
import '../domain/services/journey_recorder.dart';
import '../domain/services/location_service.dart';

part 'drive_controller.g.dart';

@Riverpod(keepAlive: true)
class DriveController extends _$DriveController {
  DriveSession? _session;
  StreamSubscription<DriveTick>? _ticks;

  @override
  DriveState build() {
    ref.onDispose(_teardown);
    return const DriveState.idle();
  }

  Future<void> startDrive({required Coord destination}) async {
    if (state case DriveDriving() || DriveAcquiringGps() || DriveAnalyzing()) {
      return;
    }
    final location = ref.read(locationServiceProvider);
    state = const DriveState.acquiringGps();
    try {
      final permission = await location.ensurePermission();
      if (permission != LocationPermissionStatus.granted) {
        state = DriveState.error(
          failure: LocationFailure(_permissionMessage(permission)),
        );
        return;
      }
      final origin = await location.currentPosition();
      state = const DriveState.analyzing();
      final repository = ref.read(routeRepositoryProvider);
      final route = await repository.analyzeRoute(
        start: origin.coord,
        end: destination,
      );
      final session = DriveSession(
        repository: repository,
        location: location,
        recorder: JourneyRecorder(),
      );
      _session = session;
      state = DriveState.driving(
        route: route,
        startedAt: ref.read(clockProvider)(),
      );
      _ticks = session.start(route).listen((tick) {
        if (state case final DriveDriving driving) {
          state = driving.copyWith(
            tick: tick,
            // The session swaps routes after a backend-restart recovery.
            route: session.route ?? driving.route,
          );
        }
      });
    } on Failure catch (failure) {
      await _teardown();
      state = DriveState.error(failure: failure);
    }
  }

  Future<Journey?> endDrive() async {
    if (state is! DriveDriving) return null;
    state = const DriveState.saving();
    await _ticks?.cancel();
    _ticks = null;
    final session = _session!;
    _session = null;
    final journey = await session.stop(journeyId: _newJourneyId());
    await ref.read(journeyRepositoryProvider).save(journey);
    state = DriveState.done(journey: journey);
    return journey;
  }

  /// Back to idle from done/error so a new drive can start.
  void reset() {
    if (state case DriveDone() || DriveError()) {
      state = const DriveState.idle();
    }
  }

  Future<void> _teardown() async {
    await _ticks?.cancel();
    _ticks = null;
    _session = null;
  }

  String _newJourneyId() =>
      ref.read(clockProvider)().millisecondsSinceEpoch.toRadixString(16);

  String _permissionMessage(LocationPermissionStatus status) =>
      switch (status) {
        LocationPermissionStatus.serviceDisabled =>
          'Turn on location services to start a drive',
        LocationPermissionStatus.deniedForever =>
          'Location permission is blocked — enable it in system settings',
        _ => 'SmoothDrive needs your location to guide you along the route',
      };
}
