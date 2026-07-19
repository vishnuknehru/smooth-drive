import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/app.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/features/settings/presentation/settings_screen.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const SmoothDriveApp(),
      ),
    );
  }

  testWidgets('boots to Home with a Start Drive button', (tester) async {
    await pumpApp(tester);
    expect(find.text('SmoothDrive'), findsOneWidget);
    expect(find.text('Start Drive'), findsOneWidget);
  });

  testWidgets('settings icon navigates to Settings', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
