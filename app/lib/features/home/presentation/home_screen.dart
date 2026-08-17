import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/utils/units.dart';
import '../../../shared/widgets/big_action_button.dart';
import '../../drive/data/geolocator_location_service.dart';
import '../../drive/domain/entities/route_analysis.dart';
import '../../drive/presentation/drive_controller.dart';
import '../../settings/presentation/settings_controller.dart';
import '../../summary/domain/entities/journey.dart';
import '../../summary/presentation/summary_controller.dart';
import 'widgets/destination_sheet.dart';

/// Destination of the bundled replay GPX (kingston-epsom).
/// Used when --dart-define=REPLAY_GPS=true.
const _replayDestination = Coord(lat: 51.33627, lon: -0.267567);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final formatter = ref.watch(unitsFormatterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmoothDrive'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.directions_car_filled, size: 96, color: scheme.primary),
              const SizedBox(height: 12),
              Text(
                'Drive smoother.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              BigActionButton(
                label: 'Start Drive',
                icon: Icons.play_arrow_rounded,
                onPressed: () => _onStartDrive(context, ref),
              ),
              const SizedBox(height: 24),
              _RecentJourneys(formatter: formatter),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _onStartDrive(BuildContext context, WidgetRef ref) {
    if (replayGpsEnabled) {
      ref
          .read(driveControllerProvider.notifier)
          .startDrive(destination: _replayDestination);
      context.push(Routes.drive);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DestinationSheet(
        onDestinationSelected: (coord) {
          ref
              .read(driveControllerProvider.notifier)
              .startDrive(destination: coord);
          context.push(Routes.drive);
        },
      ),
    );
  }
}

class _RecentJourneys extends ConsumerWidget {
  const _RecentJourneys({required this.formatter});

  final UnitsFormatter formatter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJourneys = ref.watch(recentJourneysProvider);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent journeys',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        asyncJourneys.when(
          loading: () => const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (err, stack) => Text(
            'Could not load journeys',
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.error),
          ),
          data: (journeys) {
            if (journeys.isEmpty) {
              return Text(
                'No journeys yet',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: scheme.onSurfaceVariant),
              );
            }
            return Column(
              children: journeys
                  .map((j) => _JourneyTile(journey: j, formatter: formatter))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _JourneyTile extends StatelessWidget {
  const _JourneyTile({required this.journey, required this.formatter});

  final Journey journey;
  final UnitsFormatter formatter;

  @override
  Widget build(BuildContext context) {
    final date = journey.startedAt;
    final label =
        '${date.day}/${date.month}/${date.year}  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          '${journey.score}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      title: Text(label),
      subtitle: Text(
        '${formatter.formatDistance(journey.distanceMeters)}  ·  '
        '${formatter.formatDuration(Duration(seconds: journey.durationSeconds.round()))}',
      ),
      onTap: () => GoRouter.of(context).push(Routes.summary(journey.id)),
    );
  }
}
