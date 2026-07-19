import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/utils/units.dart';
import 'package:smoothdrive/features/settings/data/prefs_settings_repository.dart';
import 'package:smoothdrive/features/settings/domain/settings.dart';

Future<PrefsSettingsRepository> repoWith(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  return PrefsSettingsRepository(await SharedPreferences.getInstance());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('load returns defaults when nothing is stored', () async {
    final repo = await repoWith({});
    expect(repo.load(), const Settings());
  });

  test('save then load round-trips every field', () async {
    final repo = await repoWith({});
    const settings = Settings(
      units: Units.metric,
      voiceEnabled: false,
      themeMode: AppThemeMode.dark,
      alertDistanceMeters: 800,
      baseUrl: 'http://192.168.1.10:8000',
    );
    await repo.save(settings);
    expect(repo.load(), settings);
  });

  test('unrecognized enum strings fall back to defaults', () async {
    final repo = await repoWith({
      'settings.units': 'nautical',
      'settings.themeMode': 'sepia',
    });
    final loaded = repo.load();
    expect(loaded.units, Units.imperial);
    expect(loaded.themeMode, AppThemeMode.system);
  });
}
