import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/core/theme/app_theme.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/home/presentation/widgets/destination_sheet.dart';
import 'package:smoothdrive/features/summary/data/file_journey_repository.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';
import 'package:smoothdrive/features/summary/domain/repositories/journey_repository.dart';

class _NoopJourneyRepo implements JourneyRepository {
  @override
  Future<void> save(Journey j) async {}
  @override
  Future<Journey?> load(String id) async => null;
  @override
  Future<List<Journey>> recent({int limit = 10}) async => [];
}

Future<ProviderScope> _pumpSheet(
  WidgetTester tester, {
  required void Function(Coord) onSelected,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final scope = ProviderScope(
    key: UniqueKey(),
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      journeyRepositoryProvider.overrideWithValue(_NoopJourneyRepo()),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: DestinationSheet(onDestinationSelected: onSelected),
      ),
    ),
  );
  await tester.pumpWidget(scope);
  return scope;
}

void main() {
  testWidgets('valid lat,lon submits the destination', (tester) async {
    Coord? selected;
    await _pumpSheet(tester, onSelected: (c) => selected = c);

    await tester.enterText(find.byType(TextField), '51.5074, -0.1278');
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pump();

    expect(selected, isNotNull);
    expect(selected!.lat, closeTo(51.5074, 0.0001));
    expect(selected!.lon, closeTo(-0.1278, 0.0001));
  });

  testWidgets('invalid input shows error, does not close sheet',
      (tester) async {
    Coord? selected;
    await _pumpSheet(tester, onSelected: (c) => selected = c);

    await tester.enterText(find.byType(TextField), 'not a coord');
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pump();

    expect(selected, isNull);
    expect(find.textContaining('valid'), findsOneWidget);
  });

  testWidgets('saved place tile calls onDestinationSelected', (tester) async {
    SharedPreferences.setMockInitialValues({
      'saved_places': [
        '{"name":"Home","lat":51.5,"lon":-0.1}',
      ],
    });
    final prefs = await SharedPreferences.getInstance();
    Coord? selected;
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          journeyRepositoryProvider.overrideWithValue(_NoopJourneyRepo()),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: DestinationSheet(onDestinationSelected: (c) => selected = c),
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    await tester.tap(find.text('Home'));
    await tester.pump();

    expect(selected, isNotNull);
    expect(selected!.lat, closeTo(51.5, 0.0001));
  });
}
