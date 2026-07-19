import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/error/failure.dart';
import '../../../summary/domain/entities/journey.dart';
import '../entities/geo_sample.dart';
import '../entities/route_analysis.dart';
import '../entities/upcoming.dart';
import '../repositories/route_repository.dart';
import 'journey_recorder.dart';
import 'location_service.dart';

part 'drive_session.freezed.dart';

/// How many consecutive off-route responses before the UI shows the
/// off-route banner (single bad fixes shouldn't flash it).
const offRouteStreakThreshold = 5;

@freezed
abstract class DriveTick with _$DriveTick {
  const factory DriveTick({
    required GeoSample sample,

    /// Latest backend response; null until the first poll completes.
    PositionUpdate? update,

    /// Sign value in force at the current position, derived locally from
    /// the cached route events — no extra API call.
    int? currentLimitMph,
    required bool offRoute,

    /// Set while the latest poll failed; the drive keeps running on GPS.
    Failure? failure,
  }) = _DriveTick;
}

/// Orchestrates a drive: GPS stream in, throttled position polling against
/// the backend, [DriveTick]s out. Pure Dart — no Flutter or Riverpod
/// imports — so it tests with fakes and ports to iOS untouched.
class DriveSession {
  DriveSession({
    required this._repository,
    required this._location,
    required this._recorder,
    this._minRequestGap = AppConfig.minRequestGap,
    this._now = DateTime.now,
  });

  final RouteRepository _repository;
  final LocationService _location;
  final JourneyRecorder _recorder;
  final Duration _minRequestGap;
  final DateTime Function() _now;

  RouteAnalysis? _route;
  StreamController<DriveTick>? _out;
  StreamSubscription<GeoSample>? _positions;
  StreamSubscription<RouteAnalysis>? _refreshes;

  GeoSample? _lastSample;
  PositionUpdate? _lastUpdate;
  Failure? _lastFailure;
  bool _inFlight = false;
  DateTime? _lastRequestAt;
  int _requestSeq = 0;
  int _emittedSeq = 0;
  int _offRouteStreak = 0;

  RouteAnalysis? get route => _route;

  Stream<DriveTick> start(RouteAnalysis route) {
    assert(_out == null, 'session already started');
    _route = route;
    _out = StreamController<DriveTick>.broadcast();
    // Backend restarts are recovered inside the repository; just swap in
    // the re-analyzed route so polling uses the fresh id.
    _refreshes = _repository.routeRefreshed.listen((r) => _route = r);
    _positions = _location.positionStream().listen(_onSample);
    return _out!.stream;
  }

  Future<Journey> stop({required String journeyId}) async {
    await _positions?.cancel();
    await _refreshes?.cancel();
    await _out?.close();
    _out = null;
    return _recorder.finalize(id: journeyId);
  }

  void _onSample(GeoSample sample) {
    _lastSample = sample;
    _recorder.addSample(sample, currentLimitMph: _currentLimit());
    unawaited(_maybePoll(sample));
    _emit();
  }

  Future<void> _maybePoll(GeoSample sample) async {
    final route = _route;
    if (route == null || _inFlight) return;
    final now = _now();
    if (_lastRequestAt != null &&
        now.difference(_lastRequestAt!) < _minRequestGap) {
      return;
    }
    _inFlight = true;
    _lastRequestAt = now;
    final seq = ++_requestSeq;
    try {
      final update = await _repository.upcoming(
        routeId: route.routeId,
        position: sample.coord,
        speedMps: sample.speedMps,
      );
      if (seq <= _emittedSeq) return; // stale response
      _emittedSeq = seq;
      _lastUpdate = update;
      _lastFailure = null;
      if (update.offRoute) {
        _offRouteStreak++;
      } else {
        _offRouteStreak = 0;
        if (update.advice case final advice?) {
          _recorder.recordAdvice(advice);
        }
      }
      _emit();
    } on Failure catch (failure) {
      _lastFailure = failure;
      _emit();
    } finally {
      _inFlight = false;
    }
  }

  int? _currentLimit() {
    final position = _lastUpdate?.positionOnRouteMeters;
    final route = _route;
    if (position == null || route == null) return null;
    int? limit;
    for (final event in route.events) {
      if (event.type != EventType.speedLimit) continue;
      if (event.distanceMeters > position) break;
      limit = event.valueMph ?? limit;
    }
    return limit;
  }

  void _emit() {
    final sample = _lastSample;
    final out = _out;
    if (sample == null || out == null || out.isClosed) return;
    out.add(
      DriveTick(
        sample: sample,
        update: _lastUpdate,
        currentLimitMph: _currentLimit(),
        offRoute: _offRouteStreak >= offRouteStreakThreshold,
        failure: _lastFailure,
      ),
    );
  }
}
