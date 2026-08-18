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
      home: Scaffold(body: DestinationSheet(onDestinationSelected: onSelected)),
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

  testWidgets('invalid input shows error, does not close sheet', (
    tester,
  ) async {
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
      'saved_places': ['{"name":"Home","lat":51.5,"lon":-0.1}'],
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

  testWidgets('keyboard submit on text field triggers navigation', (
    tester,
  ) async {
    Coord? selected;
    await _pumpSheet(tester, onSelected: (c) => selected = c);

    await tester.enterText(find.byType(TextField), '51.5074, -0.1278');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(selected, isNotNull);
    expect(selected!.lat, closeTo(51.5074, 0.0001));
  });

  testWidgets('"Save this location" saves typed coord and shows snackbar', (
    tester,
  ) async {
    await _pumpSheet(tester, onSelected: (_) {});

    // Type a valid coord first so the save logic has something to save.
    await tester.enterText(find.byType(TextField), '51.4, -0.2');
    await tester.pump();

    await tester.tap(find.byIcon(Icons.bookmark_add_outlined));
    await tester.pump(); // trigger async save
    await tester.pump(); // let SnackBar appear

    expect(find.textContaining('Saved as'), findsOneWidget);
  });

  testWidgets('"Save this location" without a coord shows error snackbar', (
    tester,
  ) async {
    await _pumpSheet(tester, onSelected: (_) {});

    // Don't enter any text — field is empty.
    await tester.tap(find.byIcon(Icons.bookmark_add_outlined));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Enter lat, lon first'), findsOneWidget);
  });

  testWidgets('delete button removes a saved place', (tester) async {
    SharedPreferences.setMockInitialValues({
      'saved_places': ['{"name":"Gym","lat":51.3,"lon":-0.15}'],
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          journeyRepositoryProvider.overrideWithValue(_NoopJourneyRepo()),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(body: DestinationSheet(onDestinationSelected: (_) {})),
        ),
      ),
    );

    expect(find.text('Gym'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Gym'), findsNothing);
  });
}
