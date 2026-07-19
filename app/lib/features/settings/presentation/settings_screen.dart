import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/units.dart';
import '../domain/settings.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _baseUrlController;

  @override
  void initState() {
    super.initState();
    _baseUrlController = TextEditingController(
      text: ref.read(settingsControllerProvider).baseUrl,
    );
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final formatter = UnitsFormatter(settings.units);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader('Display'),
          ListTile(
            title: const Text('Units'),
            trailing: SegmentedButton<Units>(
              segments: const [
                ButtonSegment(value: Units.imperial, label: Text('mph')),
                ButtonSegment(value: Units.metric, label: Text('km/h')),
              ],
              selected: {settings.units},
              onSelectionChanged: (selection) =>
                  controller.setUnits(selection.single),
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: SegmentedButton<AppThemeMode>(
              segments: const [
                ButtonSegment(value: AppThemeMode.system, label: Text('Auto')),
                ButtonSegment(value: AppThemeMode.light, label: Text('Light')),
                ButtonSegment(value: AppThemeMode.dark, label: Text('Dark')),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (selection) =>
                  controller.setThemeMode(selection.single),
            ),
          ),
          const Divider(height: 32),
          const _SectionHeader('Alerts'),
          SwitchListTile(
            title: const Text('Voice alerts'),
            subtitle: const Text('Speak advice and upcoming events'),
            value: settings.voiceEnabled,
            onChanged: controller.setVoiceEnabled,
          ),
          ListTile(
            title: const Text('Alert distance'),
            subtitle: Slider(
              min: 200,
              max: 1000,
              divisions: 8,
              value: settings.alertDistanceMeters.clamp(200, 1000),
              label: formatter.formatDistance(settings.alertDistanceMeters),
              onChanged: controller.setAlertDistanceMeters,
            ),
            trailing: Text(
              formatter.formatDistance(settings.alertDistanceMeters),
            ),
          ),
          const Divider(height: 32),
          const _SectionHeader('Backend'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _baseUrlController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Server URL',
                helperText:
                    'Emulator: http://10.0.2.2:8000 — device: your Mac’s LAN IP',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  tooltip: 'Save',
                  onPressed: () => _saveBaseUrl(controller),
                ),
              ),
              onSubmitted: (_) => _saveBaseUrl(controller),
            ),
          ),
        ],
      ),
    );
  }

  void _saveBaseUrl(SettingsController controller) {
    controller.setBaseUrl(_baseUrlController.text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Server URL saved')));
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
