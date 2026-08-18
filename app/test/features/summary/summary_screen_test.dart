import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/core/theme/app_theme.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/summary/data/file_journey_repository.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';
import 'package:smoothdrive/features/summary/domain/repositories/journey_repository.dart';
import 'package:smoothdrive/features/summary/presentation/summary_screen.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

class _FakeJourneyRepo implements JourneyRepository {
  _FakeJourneyRepo(this._journeys);

  final Map<String, Journey> _journeys;

  @override
  Future<void> save(Journey journey) async => _journeys[journey.id] = journey;

  @override
  Future<Journey?> load(String id) async => _journeys[id];

  @override
  Future<List<Journey>> recent({int limit = 10}) async =>
      _journeys.values.toList();
}

Journey _journey({
  int score = 72,
  int harshEvents = 2,
  int lateReactions = 1,
  double? compliance = 0.85,
}) => Journey(
  id: 'test-journey',
  startedAt: t0,
  endedAt: t0.add(const Duration(minutes: 12)),
  start: const Coord(lat: 51.0, lon: 0.0),
  end: const Coord(lat: 51.02, lon: 0.0),
  distanceMeters: 5000,
  durationSeconds: 720,
  harshEvents: List.generate(
    harshEvents,
    (i) => HarshEvent(
      time: t0.add(Duration(minutes: i)),
      location: const Coord(lat: 51.01, lon: 0.0),
      fromMps: 15,
      toMps: 0,
      peakDecelMs2: 4.5,
    ),
  ),
  lateReactions: lateReactions,
  score: score,
  speedComplianceRatio: compliance,
  samples: const [],
);

// Journey with speed samples so SpeedChart renders its data path.
Journey _journeyWithSamples() => Journey(
  id: 'test-journey',
  startedAt: t0,
  endedAt: t0.add(const Duration(minutes: 5)),
  start: const Coord(lat: 51.0, lon: 0.0),
  end: const Coord(lat: 51.02, lon: 0.0),
  distanceMeters: 2000,
  durationSeconds: 300,
  harshEvents: const [],
  lateReactions: 0,
  score: 90,
  speedComplianceRatio: 1.0,
  samples: List.generate(
    10,
    (i) => JourneySample(
      time: t0.add(Duration(seconds: i * 30)),
      coord: Coord(lat: 51.0 + i * 0.001, lon: 0.0),
      speedMps: 13.4 + i * 0.1,
      limitMph: 30,
    ),
  ),
);

Future<void> pumpSummary(
  WidgetTester tester, {
  required Journey journey,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        journeyRepositoryProvider.overrideWithValue(
          _FakeJourneyRepo({'test-journey': journey}),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        home: const SummaryScreen(journeyId: 'test-journey'),
      ),
    ),
  );
  // Wait for the AsyncValue to resolve.
  await tester.pump();
}

void main() {
  testWidgets('shows score, distance and duration', (tester) async {
    await pumpSummary(tester, journey: _journey(score: 72));
    expect(find.text('72'), findsAtLeastNWidgets(1));
    // Default units is imperial: 5000m ≈ 3.1 mi
    expect(find.textContaining('3.1 mi'), findsOneWidget);
    expect(find.textContaining('12m'), findsOneWidget);
  });

  testWidgets('shows harsh braking recommendation when events > 0', (
    tester,
  ) async {
    await pumpSummary(tester, journey: _journey(harshEvents: 3));
    expect(find.textContaining('harshly 3 times'), findsOneWidget);
  });

  testWidgets('shows late reaction recommendation', (tester) async {
    await pumpSummary(tester, journey: _journey(lateReactions: 2));
    expect(find.textContaining('reacted late to 2'), findsOneWidget);
  });

  testWidgets('shows positive message when no issues', (tester) async {
    await pumpSummary(
      tester,
      journey: _journey(harshEvents: 0, lateReactions: 0, compliance: 1.0),
    );
    expect(find.textContaining('Great drive'), findsOneWidget);
  });

  testWidgets('shows speed compliance warning when low', (tester) async {
    await pumpSummary(
      tester,
      journey: _journey(harshEvents: 0, lateReactions: 0, compliance: 0.7),
    );
    expect(find.textContaining('30%'), findsOneWidget);
  });

  testWidgets('speed chart renders when journey has samples', (tester) async {
    await pumpSummary(tester, journey: _journeyWithSamples());
    // SpeedChart is rendered — if it threw or showed "No speed data" the test
    // would fail. Just verify the screen is visible and score still shows.
    expect(find.text('90'), findsAtLeastNWidgets(1));
    // The chart itself is a Canvas widget with no text to assert on, but its
    // build method executes which is what matters for coverage.
    expect(find.textContaining('No speed data'), findsNothing);
  });

  testWidgets('error branch shows fallback message when journey missing', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          // Empty repo — load('missing-id') returns null → summaryJourney throws
          journeyRepositoryProvider.overrideWithValue(_FakeJourneyRepo({})),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const SummaryScreen(journeyId: 'missing-id'),
        ),
      ),
    );
    await tester.pump(); // resolve AsyncValue
    expect(find.textContaining('Could not load journey'), findsOneWidget);
  });
}
