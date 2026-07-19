import 'settings.dart';

abstract interface class SettingsRepository {
  Settings load();

  Future<void> save(Settings settings);
}
