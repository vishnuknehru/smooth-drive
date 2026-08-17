import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/router/app_router.dart';
import '../../../core/utils/units.dart';
import '../../../shared/widgets/big_action_button.dart';
import '../../settings/presentation/settings_controller.dart';
import '../domain/entities/drive_state.dart';
import '../domain/services/drive_session.dart';
import 'drive_controller.dart';
import 'widgets/advice_banner.dart';
import 'widgets/debug_row.dart';
import 'widgets/speed_display.dart';
import 'widgets/speed_limit_sign.dart';
import 'widgets/upcoming_events_list.dart';

class DriveScreen extends ConsumerStatefulWidget {
  const DriveScreen({super.key});

  @override
  ConsumerState<DriveScreen> createState() => _DriveScreenState();
}

class _DriveScreenState extends ConsumerState<DriveScreen> {
  bool _showDebug = true;

  @override
  void initState() {
    super.initState();
    // Screen stays awake for the whole drive (dashboard-mount MVP).
    unawaited(WakelockPlus.enable().catchError((_) {}));
  }

  @override
  void dispose() {
    unawaited(WakelockPlus.disable().catchError((_) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driveControllerProvider);
    final formatter = ref.watch(unitsFormatterProvider);
    return Scaffold(
      body: SafeArea(
        child: switch (state) {
          DriveAcquiringGps() => const _Progress('Getting a GPS fix…'),
          DriveAnalyzing() =>
            const _Progress('Analyzing your route…\nThis can take a moment'),
          DriveSaving() => const _Progress('Saving your journey…'),
          DriveDriving(:final tick, :final startedAt) =>
            _DrivingView(
              tick: tick,
              startedAt: startedAt,
              formatter: formatter,
              showDebug: _showDebug,
              onToggleDebug: () => setState(() => _showDebug = !_showDebug),
              onEnd: () async {
                final controller = ref.read(driveControllerProvider.notifier);
                await controller.endDrive();
              },
            ),
          DriveDone(:final journey) => _DoneView(
              score: journey.score,
              onViewSummary: () {
                ref.read(driveControllerProvider.notifier).reset();
                context.go(Routes.summary(journey.id));
              },
              onClose: () {
                ref.read(driveControllerProvider.notifier).reset();
                context.go(Routes.home);
              },
            ),
          DriveError(:final failure) => _ErrorView(
              message: failure.message,
              onClose: () {
                ref.read(driveControllerProvider.notifier).reset();
                context.go(Routes.home);
              },
            ),
          _ => const SizedBox.shrink(), // idle: router redirects home
        },
      ),
    );
  }
}

class _DrivingView extends StatelessWidget {
  const _DrivingView({
    required this.tick,
    required this.startedAt,
    required this.formatter,
    required this.showDebug,
    required this.onToggleDebug,
    required this.onEnd,
  });

  final DriveTick? tick;
  final DateTime startedAt;
  final UnitsFormatter formatter;
  final bool showDebug;
  final VoidCallback onToggleDebug;
  final Future<void> Function() onEnd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final elapsed =
        tick == null ? Duration.zero : tick!.sample.time.difference(startedAt);
    return GestureDetector(
      onLongPress: onToggleDebug,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: onEnd,
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: const Text('End Drive', style: TextStyle(fontSize: 18)),
                  style: TextButton.styleFrom(foregroundColor: scheme.error),
                ),
                Text(
                  formatter.formatDuration(elapsed),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SpeedLimitSign(
                  limitMph: tick?.currentLimitMph,
                  formatter: formatter,
                ),
                SpeedDisplay(
                  speedMps: tick?.sample.speedMps ?? 0,
                  formatter: formatter,
                ),
              ],
            ),
            const Spacer(),
            if (tick?.failure != null)
              _StatusStrip(
                icon: Icons.cloud_off,
                text: 'Connection lost — guidance paused, retrying',
                color: scheme.errorContainer,
                onColor: scheme.onErrorContainer,
              ),
            if (tick?.offRoute == true)
              _StatusStrip(
                icon: Icons.fork_right,
                text: 'Off route',
                color: scheme.tertiaryContainer,
                onColor: scheme.onTertiaryContainer,
              ),
            AdviceBanner(advice: tick?.update?.advice),
            const SizedBox(height: 16),
            UpcomingEventsList(
              events: tick?.update?.events ?? const [],
              formatter: formatter,
            ),
            const SizedBox(height: 8),
            if (showDebug) DebugRow(tick: tick),
          ],
        ),
      ),
    );
  }
}

class _StatusStrip extends StatelessWidget {
  const _StatusStrip({
    required this.icon,
    required this.text,
    required this.color,
    required this.onColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: onColor, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: onColor))),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _DoneView extends StatelessWidget {
  const _DoneView({
    required this.score,
    required this.onViewSummary,
    required this.onClose,
  });

  final int score;
  final VoidCallback onViewSummary;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Drive complete',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Smoothness score: $score',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32),
          BigActionButton(label: 'View Summary', onPressed: onViewSummary),
          const SizedBox(height: 12),
          TextButton(onPressed: onClose, child: const Text('Back to Home')),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.error_outline,
              size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),
          BigActionButton(label: 'Back to Home', onPressed: onClose),
        ],
      ),
    );
  }
}
