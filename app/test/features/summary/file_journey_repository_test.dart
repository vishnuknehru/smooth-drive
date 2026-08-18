import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/summary/data/file_journey_repository.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

Journey _makeJourney(String id, {int score = 80, DateTime? startedAt}) =>
    Journey(
      id: id,
      startedAt: startedAt ?? t0,
      endedAt: t0.add(const Duration(minutes: 10)),
      start: const Coord(lat: 51.0, lon: 0.0),
      end: const Coord(lat: 51.02, lon: 0.0),
      distanceMeters: 5000,
      durationSeconds: 600,
      harshEvents: const [],
      lateReactions: 0,
      score: score,
      samples: const [],
    );

FileJourneyRepository _repo(Directory dir) =>
    FileJourneyRepository(overrideDir: dir);

void main() {
  late Directory tmp;

  setUp(() => tmp = Directory.systemTemp.createTempSync('journey_test_'));
  tearDown(() => tmp.deleteSync(recursive: true));

  test('save and load round-trips a journey', () async {
    final repo = _repo(tmp);
    final journey = _makeJourney('abc123');

    await repo.save(journey);
    final loaded = await repo.load('abc123');

    expect(loaded, isNotNull);
    expect(loaded!.id, 'abc123');
    expect(loaded.score, 80);
    expect(loaded.distanceMeters, 5000);
  });

  test('load returns null for a missing id', () async {
    final repo = _repo(tmp);
    expect(await repo.load('not_there'), isNull);
  });

  test('recent returns journeys sorted newest first', () async {
    final repo = _repo(tmp);
    final older = _makeJourney('j1', startedAt: t0);
    final newer = _makeJourney(
      'j2',
      startedAt: t0.add(const Duration(hours: 1)),
    );

    await repo.save(older);
    await repo.save(newer);

    final results = await repo.recent();
    expect(results.length, 2);
    expect(results.first.id, 'j2');
    expect(results.last.id, 'j1');
  });

  test('recent respects the limit', () async {
    final repo = _repo(tmp);
    for (var i = 0; i < 5; i++) {
      await repo.save(
        _makeJourney('j$i', startedAt: t0.add(Duration(hours: i))),
      );
    }
    final results = await repo.recent(limit: 3);
    expect(results.length, 3);
  });

  test('recent skips corrupt files without throwing', () async {
    final repo = _repo(tmp);
    await repo.save(_makeJourney('good'));

    // Write a corrupt JSON file alongside the valid one.
    File('${tmp.path}/journeys/bad.json').writeAsStringSync('{ not valid');

    final results = await repo.recent();
    expect(results.length, 1);
    expect(results.first.id, 'good');
  });

  test('save and load round-trips harshEvents and samples', () async {
    final repo = _repo(tmp);
    final journey = Journey(
      id: 'rich-journey',
      startedAt: t0,
      endedAt: t0.add(const Duration(minutes: 5)),
      start: const Coord(lat: 51.0, lon: 0.0),
      end: const Coord(lat: 51.02, lon: 0.0),
      distanceMeters: 2000,
      durationSeconds: 300,
      harshEvents: [
        HarshEvent(
          time: t0.add(const Duration(seconds: 30)),
          location: const Coord(lat: 51.01, lon: 0.0),
          fromMps: 15.0,
          toMps: 2.0,
          peakDecelMs2: 4.5,
        ),
      ],
      lateReactions: 1,
      score: 75,
      samples: [
        JourneySample(
          time: t0.add(const Duration(seconds: 10)),
          coord: const Coord(lat: 51.005, lon: 0.0),
          speedMps: 13.4,
          limitMph: 30,
        ),
      ],
    );

    await repo.save(journey);
    final loaded = await repo.load('rich-journey');

    expect(loaded, isNotNull);
    expect(loaded!.harshEvents, hasLength(1));
    expect(loaded.harshEvents.single.peakDecelMs2, closeTo(4.5, 0.01));
    expect(loaded.samples, hasLength(1));
    expect(loaded.samples.single.limitMph, 30);
  });
}
