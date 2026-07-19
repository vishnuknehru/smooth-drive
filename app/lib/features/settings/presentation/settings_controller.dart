import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers.dart';
import '../../../core/utils/units.dart';
import '../data/prefs_settings_repository.dart';
import '../domain/settings.dart';
import '../domain/settings_repository.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    PrefsSettingsRepository(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  Settings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> setUnits(Units units) => _update(state.copyWith(units: units));

  Future<void> setVoiceEnabled(bool enabled) =>
      _update(state.copyWith(voiceEnabled: enabled));

  Future<void> setThemeMode(AppThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> setAlertDistanceMeters(double meters) =>
      _update(state.copyWith(alertDistanceMeters: meters));

  Future<void> setBaseUrl(String url) =>
      _update(state.copyWith(baseUrl: url.trim()));

  Future<void> _update(Settings next) {
    state = next;
    return ref.read(settingsRepositoryProvider).save(next);
  }
}
