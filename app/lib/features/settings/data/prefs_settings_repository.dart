import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/units.dart';
import '../domain/settings.dart';
import '../domain/settings_repository.dart';

class PrefsSettingsRepository implements SettingsRepository {
  PrefsSettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _kUnits = 'settings.units';
  static const _kVoice = 'settings.voice';
  static const _kThemeMode = 'settings.themeMode';
  static const _kAlertDistance = 'settings.alertDistanceMeters';
  static const _kBaseUrl = 'settings.baseUrl';

  @override
  Settings load() {
    const defaults = Settings();
    return Settings(
      units:
          Units.values.asNameMap()[_prefs.getString(_kUnits)] ?? defaults.units,
      voiceEnabled: _prefs.getBool(_kVoice) ?? defaults.voiceEnabled,
      themeMode:
          AppThemeMode.values.asNameMap()[_prefs.getString(_kThemeMode)] ??
          defaults.themeMode,
      alertDistanceMeters:
          _prefs.getDouble(_kAlertDistance) ?? defaults.alertDistanceMeters,
      baseUrl: _prefs.getString(_kBaseUrl) ?? defaults.baseUrl,
    );
  }

  @override
  Future<void> save(Settings settings) async {
    await Future.wait([
      _prefs.setString(_kUnits, settings.units.name),
      _prefs.setBool(_kVoice, settings.voiceEnabled),
      _prefs.setString(_kThemeMode, settings.themeMode.name),
      _prefs.setDouble(_kAlertDistance, settings.alertDistanceMeters),
      _prefs.setString(_kBaseUrl, settings.baseUrl),
    ]);
  }
}
