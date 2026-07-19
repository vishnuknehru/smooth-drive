import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/config/app_config.dart';
import 'package:smoothdrive/core/network/api_client.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/features/settings/presentation/settings_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('dio rebuilds when the base URL setting changes', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(dioProvider).options.baseUrl,
      AppConfig.defaultBaseUrl,
    );

    await container
        .read(settingsControllerProvider.notifier)
        .setBaseUrl('http://192.168.1.20:8000');
    // Allow the dependent provider to rebuild.
    await container.pump();

    expect(
      container.read(dioProvider).options.baseUrl,
      'http://192.168.1.20:8000',
    );
  });
}
