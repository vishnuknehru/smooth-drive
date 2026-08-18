import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/utils/units.dart';
import 'package:smoothdrive/features/drive/domain/entities/advice.dart';
import 'package:smoothdrive/features/drive/domain/entities/geo_sample.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/domain/entities/upcoming.dart';
import 'package:smoothdrive/features/drive/domain/services/journey_recorder.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

GeoSample sample(int second, {double speedMps = 13.4, double lat = 51.0}) =>
    GeoSample(
      time: t0.add(Duration(seconds: second)),
      coord: Coord(lat: lat + second * 0.0001, lon: 0.0),
      speedMps: speedMps,
      accuracyM: 5,
    );

Advice advice(AdviceAction action, {int? targetMph, EventType? eventType}) =>
    Advice(
      action: action,
      targetMph: targetMph,
      event: eventType == null
          ? null
          : UpcomingEvent(
              type: eventType,
              distanceAheadMeters: 100,
              location: const Coord(lat: 51.0, lon: 0.0),
            ),
      message: 'test',
    );

void main() {
  test('braking advice counts once per advice change', () {
    final recorder = JourneyRecorder();
    final brake30 = advice(
      AdviceAction.brakeGently,
      targetMph: 30,
      eventType: EventType.speedLimit,
    );

    recorder.recordAdvice(brake30);
    recorder.recordAdvice(brake30); // repeated -> ignored
    expect(recorder.lateReactions, 1);

    // Same action for a different event counts again.
    recorder.recordAdvice(
      advice(
        AdviceAction.brakeGently,
        targetMph: 12,
        eventType: EventType.roundabout,
      ),
    );
    expect(recorder.lateReactions, 2);
  });

  test('ease_off and maintain are not late reactions', () {
    final recorder = JourneyRecorder();
    recorder.recordAdvice(
      advice(
        AdviceAction.easeOff,
        targetMph: 30,
        eventType: EventType.speedLimit,
      ),
    );
    recorder.recordAdvice(advice(AdviceAction.maintain));
    recorder.recordAdvice(
      advice(AdviceAction.prepareSignal, eventType: EventType.trafficSignal),
    );
    expect(recorder.lateReactions, 0);
  });

  test('escalation ease_off -> brake counts one late reaction', () {
    final recorder = JourneyRecorder();
    recorder.recordAdvice(
      advice(
        AdviceAction.easeOff,
        targetMph: 30,
        eventType: EventType.speedLimit,
      ),
    );
    recorder.recordAdvice(
      advice(
        AdviceAction.brake,
        targetMph: 30,
        eventType: EventType.speedLimit,
      ),
    );
    expect(recorder.lateReactions, 1);
  });

  test('finalize computes compliance against known limits', () {
    final recorder = JourneyRecorder();
    // 30 mph zone: two compliant (30 mph), two speeding (40 mph),
    // one with unknown limit (excluded).
    final mph30 = 30 * mpsPerMph;
    final mph40 = 40 * mpsPerMph;
    recorder.addSample(sample(0, speedMps: mph30), currentLimitMph: 30);
    recorder.addSample(sample(1, speedMps: mph30), currentLimitMph: 30);
    recorder.addSample(sample(2, speedMps: mph40), currentLimitMph: 30);
    recorder.addSample(sample(3, speedMps: mph40), currentLimitMph: 30);
    recorder.addSample(sample(4, speedMps: mph40), currentLimitMph: null);

    final journey = recorder.finalize(id: 'j1');
    expect(journey.speedComplianceRatio, 0.5);
    expect(journey.startedAt, t0);
    expect(journey.samples, isNotEmpty);
  });

  test('finalize with no known limits leaves compliance null', () {
    final recorder = JourneyRecorder();
    recorder.addSample(sample(0));
    recorder.addSample(sample(1));
    expect(recorder.finalize(id: 'j2').speedComplianceRatio, isNull);
  });

  test('samples are decimated to one per 2 seconds', () {
    final recorder = JourneyRecorder();
    for (var i = 0; i < 10; i++) {
      recorder.addSample(sample(i));
    }
    final journey = recorder.finalize(id: 'j3');
    expect(journey.samples, hasLength(5));
  });

  test('isEmpty is true before any samples are added', () {
    expect(JourneyRecorder().isEmpty, isTrue);
  });

  test('isEmpty is false after the first sample', () {
    final recorder = JourneyRecorder();
    recorder.addSample(sample(0));
    expect(recorder.isEmpty, isFalse);
  });
}
