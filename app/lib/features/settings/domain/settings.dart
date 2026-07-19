import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/utils/units.dart';

part 'settings.freezed.dart';

enum AppThemeMode { system, light, dark }

@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    @Default(Units.imperial) Units units,
    @Default(true) bool voiceEnabled,
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(AppConfig.defaultAlertDistanceMeters) double alertDistanceMeters,
    @Default(AppConfig.defaultBaseUrl) String baseUrl,
  }) = _Settings;
}
