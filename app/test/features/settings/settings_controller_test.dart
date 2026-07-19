import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/core/utils/units.dart';
import 'package:smoothdrive/features/settings/domain/settings.dart';
import 'package:smoothdrive/features/settings/presentation/settings_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);
  });

  test('initial state is defaults on a fresh install', () {
    expect(container.read(settingsControllerProvider), const Settings());
  });

  test('setUnits updates state and persists', () async {
    final controller = container.read(settingsControllerProvider.notifier);
    await controller.setUnits(Units.metric);
    expect(container.read(settingsControllerProvider).units, Units.metric);
    expect(prefs.getString('settings.units'), 'metric');
  });

  test('setVoiceEnabled and setThemeMode persist', () async {
    final controller = container.read(settingsControllerProvider.notifier);
    await controller.setVoiceEnabled(false);
    await controller.setThemeMode(AppThemeMode.dark);
    expect(prefs.getBool('settings.voice'), false);
    expect(prefs.getString('settings.themeMode'), 'dark');
  });

  test('setBaseUrl trims whitespace', () async {
    final controller = container.read(settingsControllerProvider.notifier);
    await controller.setBaseUrl('  http://192.168.1.5:8000  ');
    expect(
      container.read(settingsControllerProvider).baseUrl,
      'http://192.168.1.5:8000',
    );
  });

  test('a fresh container sees previously persisted settings', () async {
    await container
        .read(settingsControllerProvider.notifier)
        .setAlertDistanceMeters(800);

    final second = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(second.dispose);
    expect(second.read(settingsControllerProvider).alertDistanceMeters, 800);
  });
}
