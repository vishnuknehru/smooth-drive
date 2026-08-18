import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/error/failure.dart';
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

/// Wall-clock threshold: if no GPS tick has arrived within this duration,
/// show the "GPS signal lost" banner. Uses wall clock (not GPS timestamps)
/// so replay mode never triggers it.
const _gpsStaleThreshold = Duration(seconds: 10);

class DriveScreen extends ConsumerStatefulWidget {
  const DriveScreen({super.key});

  @override
  ConsumerState<DriveScreen> createState() => _DriveScreenState();
}

class _DriveScreenState extends ConsumerState<DriveScreen> {
  bool _showDebug = true;
  Timer? _refreshTimer;

  /// Wall-clock timestamp of the most recent GPS tick received.
  /// Null until the first tick arrives. Reset when leaving driving state.
  DateTime? _lastTickAt;

  @override
  void initState() {
    super.initState();
    unawaited(WakelockPlus.enable().catchError((_) {}));
    // Periodic refresh so the GPS-staleness check updates even when ticks stop.
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    unawaited(WakelockPlus.disable().catchError((_) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driveControllerProvider);
    final formatter = ref.watch(unitsFormatterProvider);

    // Track wall-clock time of each arriving tick to detect GPS signal loss.
    ref.listen<DriveState>(driveControllerProvider, (prev, next) {
      if (next case DriveDriving(:final tick) when tick != null) {
        _lastTickAt = DateTime.now();
      } else if (next is! DriveDriving) {
        _lastTickAt = null;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: switch (state) {
          DriveAcquiringGps() => const _Progress('Getting a GPS fix…'),
          DriveAnalyzing() => const _Progress(
            'Analyzing your route…\nThis can take a moment',
          ),
          DriveSaving() => const _Progress('Saving your journey…'),
          DriveDriving(:final tick, :final startedAt) => _DrivingView(
            tick: tick,
            startedAt: startedAt,
            formatter: formatter,
            showDebug: _showDebug,
            lastTickAt: _lastTickAt,
            now: DateTime.now(),
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
            failure: failure,
            onOpenSettings: failure is LocationFailure
                ? () => unawaited(Geolocator.openAppSettings())
                : null,
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
    required this.lastTickAt,
    required this.now,
    required this.onToggleDebug,
    required this.onEnd,
  });

  final DriveTick? tick;
  final DateTime startedAt;
  final UnitsFormatter formatter;
  final bool showDebug;
  final DateTime? lastTickAt;
  final DateTime now;
  final VoidCallback onToggleDebug;
  final Future<void> Function() onEnd;

  bool get _isGpsStale =>
      lastTickAt != null && now.difference(lastTickAt!) >= _gpsStaleThreshold;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final elapsed = tick == null
        ? Duration.zero
        : tick!.sample.time.difference(startedAt);
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
                  label: const Text(
                    'End Drive',
                    style: TextStyle(fontSize: 18),
                  ),
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
            if (_isGpsStale)
              _StatusStrip(
                icon: Icons.gps_off,
                text: 'GPS signal lost',
                color: scheme.errorContainer,
                onColor: scheme.onErrorContainer,
              ),
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
          Expanded(
            child: Text(text, style: TextStyle(color: onColor)),
          ),
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
  const _ErrorView({
    required this.failure,
    required this.onClose,
    this.onOpenSettings,
  });

  final Failure failure;
  final VoidCallback onClose;

  /// Non-null for recoverable permission errors — shows "Open Settings" as
  /// the primary action so the user can unblock the app without hunting for it.
  final VoidCallback? onOpenSettings;

  IconData get _icon => switch (failure) {
    NetworkFailure() => Icons.wifi_off_rounded,
    UpstreamFailure() => Icons.cloud_off_outlined,
    LocationFailure() => Icons.location_off,
    _ => Icons.error_outline,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(_icon, size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text(
            failure.message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),
          if (onOpenSettings != null) ...[
            BigActionButton(label: 'Open Settings', onPressed: onOpenSettings!),
            const SizedBox(height: 12),
            TextButton(onPressed: onClose, child: const Text('Back to Home')),
          ] else
            BigActionButton(label: 'Back to Home', onPressed: onClose),
        ],
      ),
    );
  }
}
