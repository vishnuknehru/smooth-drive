import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/features/settings/presentation/settings_screen.dart';

void main() {
  Future<SharedPreferences> pumpSettings(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    return prefs;
  }

  testWidgets('voice toggle persists to prefs', (tester) async {
    final prefs = await pumpSettings(tester);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(prefs.getBool('settings.voice'), false);
  });

  testWidgets('units segmented button switches to metric', (tester) async {
    final prefs = await pumpSettings(tester);
    await tester.tap(find.text('km/h'));
    await tester.pumpAndSettle();
    expect(prefs.getString('settings.units'), 'metric');
  });

  testWidgets('base URL field saves via suffix icon', (tester) async {
    final prefs = await pumpSettings(tester);
    await tester.scrollUntilVisible(
      find.byType(TextField),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextField), 'http://192.168.0.42:8000');
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(prefs.getString('settings.baseUrl'), 'http://192.168.0.42:8000');
  });
}
