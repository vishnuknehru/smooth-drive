import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/features/drive/domain/entities/advice.dart';
import 'package:smoothdrive/features/drive/domain/entities/geo_sample.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/domain/entities/upcoming.dart';
import 'package:smoothdrive/features/drive/domain/services/drive_session.dart';
import 'package:smoothdrive/services/voice/voice_announcer.dart';
import 'package:smoothdrive/services/voice/voice_service.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

class FakeVoice implements VoiceService {
  final spoken = <String>[];

  @override
  Future<void> speak(String text) async => spoken.add(text);

  @override
  Future<void> stop() async {}

  @override
  void dispose() {}
}

class _DisposeSpy implements VoiceService {
  _DisposeSpy(this._inner, {required this.onDispose});
  final VoiceService _inner;
  final void Function() onDispose;

  @override
  Future<void> speak(String text) => _inner.speak(text);
  @override
  Future<void> stop() => _inner.stop();
  @override
  void dispose() => onDispose();
}

const _baseCoord = Coord(lat: 51.0, lon: 0.0);
const _signalCoord = Coord(lat: 51.01, lon: 0.0);

GeoSample _sample(int sec) => GeoSample(
  time: t0.add(Duration(seconds: sec)),
  coord: _baseCoord,
  speedMps: 13,
  accuracyM: 5,
);

DriveTick _tick({
  Advice? advice,
  List<UpcomingEvent> events = const [],
  int sec = 0,
}) => DriveTick(
  sample: _sample(sec),
  update: PositionUpdate(
    routeId: 'r',
    positionOnRouteMeters: 100,
    offRoute: false,
    events: events,
    advice: advice,
  ),
  currentLimitMph: null,
  offRoute: false,
);

void main() {
  test('maintain advice is not spoken', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.maintain, message: 'ok'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, isEmpty);
  });

  test('non-maintain advice change is spoken', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.easeOff, message: 'Ease off'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['Ease off']);
  });

  test('same advice key is not re-spoken', () async {
    final voice = FakeVoice();
    // Advance time beyond 5s gap between ticks
    var sec = 0;
    final a = VoiceAnnouncer(
      voice: voice,
      now: () => t0.add(Duration(seconds: sec)),
    );
    const adv = Advice(
      action: AdviceAction.brakeGently,
      message: 'Brake gently',
    );
    await a.onTick(
      _tick(advice: adv),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    sec = 10; // well past gap
    await a.onTick(
      _tick(advice: adv),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    // Only spoken once (same key)
    expect(voice.spoken.length, 1);
  });

  test('5-second gap enforced between advice announcements', () async {
    final voice = FakeVoice();
    var sec = 0;
    final a = VoiceAnnouncer(
      voice: voice,
      now: () => t0.add(Duration(seconds: sec)),
    );
    // First advice
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.easeOff, message: 'A'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    sec = 2; // within gap
    // Different advice (key changes) but gap not elapsed
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.brake, message: 'B'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['A']); // 'B' suppressed by gap

    sec = 6; // past gap
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.maintain, message: 'C'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    // maintain not spoken
    expect(voice.spoken.length, 1);

    sec = 7;
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.brake, message: 'D'),
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['A', 'D']);
  });

  test('event within alert distance is spoken', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        events: const [
          UpcomingEvent(
            type: EventType.trafficSignal,
            distanceAheadMeters: 150,
            location: _signalCoord,
          ),
        ],
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['Traffic signal ahead']);
  });

  test('event outside alert distance is not spoken', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        events: const [
          UpcomingEvent(
            type: EventType.trafficSignal,
            distanceAheadMeters: 400,
            location: _signalCoord,
          ),
        ],
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, isEmpty);
  });

  test('event already announced is not re-spoken', () async {
    final voice = FakeVoice();
    var sec = 0;
    final a = VoiceAnnouncer(
      voice: voice,
      now: () => t0.add(Duration(seconds: sec)),
    );
    const event = UpcomingEvent(
      type: EventType.roundabout,
      distanceAheadMeters: 100,
      location: _signalCoord,
    );
    await a.onTick(
      _tick(events: [event]),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    sec = 10;
    await a.onTick(
      _tick(events: [event]),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken.length, 1); // announced once
  });

  test('voice disabled suppresses all announcements', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.brake, message: 'Brake'),
        events: const [
          UpcomingEvent(
            type: EventType.trafficSignal,
            distanceAheadMeters: 50,
            location: _signalCoord,
          ),
        ],
      ),
      voiceEnabled: false,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, isEmpty);
  });

  test('advice spoken takes priority over event announcement', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        advice: const Advice(action: AdviceAction.easeOff, message: 'Ease off'),
        events: const [
          UpcomingEvent(
            type: EventType.trafficSignal,
            distanceAheadMeters: 50,
            location: _signalCoord,
          ),
        ],
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    // Only advice spoken, event deferred to next tick (after gap)
    expect(voice.spoken, ['Ease off']);
  });

  test('speed limit event text includes mph value', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        events: const [
          UpcomingEvent(
            type: EventType.speedLimit,
            distanceAheadMeters: 100,
            location: _signalCoord,
            valueMph: 30,
          ),
        ],
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['Speed limit changing to 30 miles per hour']);
  });

  test('unknown event type is announced as "Hazard ahead"', () async {
    final voice = FakeVoice();
    final a = VoiceAnnouncer(voice: voice, now: () => t0);
    await a.onTick(
      _tick(
        events: const [
          UpcomingEvent(
            type: EventType.unknown,
            distanceAheadMeters: 100,
            location: _signalCoord,
          ),
        ],
      ),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken, ['Hazard ahead']);
  });

  test('dispose delegates to the underlying voice service', () {
    final voice = FakeVoice();
    var disposed = false;
    // Wrap FakeVoice so we can observe dispose().
    final wrapper = _DisposeSpy(voice, onDispose: () => disposed = true);
    VoiceAnnouncer(voice: wrapper, now: () => t0).dispose();
    expect(disposed, isTrue);
  });

  test('reset clears state so events and advice re-trigger', () async {
    final voice = FakeVoice();
    var sec = 0;
    final a = VoiceAnnouncer(
      voice: voice,
      now: () => t0.add(Duration(seconds: sec)),
    );
    const event = UpcomingEvent(
      type: EventType.trafficSignal,
      distanceAheadMeters: 50,
      location: _signalCoord,
    );
    await a.onTick(
      _tick(events: [event]),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken.length, 1);

    a.reset();
    sec = 10;
    await a.onTick(
      _tick(events: [event]),
      voiceEnabled: true,
      alertDistanceMeters: 200,
    );
    expect(voice.spoken.length, 2); // same event triggers again after reset
  });
}
