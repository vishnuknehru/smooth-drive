import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/core/router/app_router.dart';
import 'package:smoothdrive/core/theme/app_theme.dart';
import 'package:smoothdrive/features/drive/domain/entities/drive_state.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/presentation/drive_controller.dart';
import 'package:smoothdrive/features/home/presentation/home_screen.dart';
import 'package:smoothdrive/features/summary/data/file_journey_repository.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';
import 'package:smoothdrive/features/summary/domain/repositories/journey_repository.dart';
import 'package:smoothdrive/features/summary/presentation/summary_controller.dart';

final _t0 = DateTime.utc(2026, 7, 1, 9);

class _StubDriveController extends DriveController {
  @override
  DriveState build() => const DriveState.idle();
}

class _FakeJourneyRepo implements JourneyRepository {
  _FakeJourneyRepo(this._journeys);
  final List<Journey> _journeys;

  @override
  Future<void> save(Journey j) async {}

  @override
  Future<Journey?> load(String id) async => _journeys.firstWhere(
    (j) => j.id == id,
    orElse: () => throw StateError('not found'),
  );

  @override
  Future<List<Journey>> recent({int limit = 10}) async =>
      _journeys.take(limit).toList();
}

Journey _journey({String id = 'j1', int score = 80}) => Journey(
  id: id,
  startedAt: _t0,
  endedAt: _t0.add(const Duration(minutes: 10)),
  start: const Coord(lat: 51.0, lon: 0.0),
  end: const Coord(lat: 51.02, lon: 0.0),
  distanceMeters: 3000,
  durationSeconds: 600,
  harshEvents: const [],
  lateReactions: 0,
  score: score,
  samples: const [],
);

Future<void> pumpHome(
  WidgetTester tester, {
  List<Journey> journeys = const [],
  bool repoError = false,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        driveControllerProvider.overrideWith(() => _StubDriveController()),
        journeyRepositoryProvider.overrideWithValue(
          repoError ? _ErrorJourneyRepo() : _FakeJourneyRepo(journeys),
        ),
        // Wire recentJourneysProvider to the fake/error repo directly.
        recentJourneysProvider.overrideWith(
          (ref) => repoError
              ? throw StateError('load error')
              : Future.value(journeys),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        // Minimal router so context.push works in the widget under test.
        home: const HomeScreen(),
        routes: {
          Routes.settings: (_) => const Scaffold(body: Text('Settings')),
        },
      ),
    ),
  );
  await tester.pump(); // resolve AsyncValue
}

class _ErrorJourneyRepo implements JourneyRepository {
  @override
  Future<void> save(Journey j) async {}
  @override
  Future<Journey?> load(String id) async => null;
  @override
  Future<List<Journey>> recent({int limit = 10}) async =>
      throw StateError('simulated error');
}

void main() {
  testWidgets('shows Start Drive button and SmoothDrive title', (tester) async {
    await pumpHome(tester);
    expect(find.text('SmoothDrive'), findsOneWidget);
    expect(find.text('Start Drive'), findsOneWidget);
  });

  testWidgets('shows "No journeys yet" when recent list is empty', (
    tester,
  ) async {
    await pumpHome(tester, journeys: []);
    expect(find.text('No journeys yet'), findsOneWidget);
  });

  testWidgets('recent journey tile shows score, distance, duration', (
    tester,
  ) async {
    await pumpHome(tester, journeys: [_journey(score: 85)]);
    expect(find.text('85'), findsOneWidget); // CircleAvatar score
    // 3000m ≈ 1.9 mi imperial
    expect(find.textContaining('1.9 mi'), findsOneWidget);
    expect(find.textContaining('10m'), findsOneWidget);
  });

  testWidgets('error loading recent journeys shows fallback message', (
    tester,
  ) async {
    await pumpHome(tester, repoError: true);
    expect(find.textContaining('Could not load'), findsOneWidget);
  });
}
