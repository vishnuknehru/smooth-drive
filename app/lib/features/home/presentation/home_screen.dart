import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../shared/widgets/big_action_button.dart';
import '../../drive/data/geolocator_location_service.dart';
import '../../drive/domain/entities/route_analysis.dart';
import '../../drive/presentation/drive_controller.dart';

/// Destination of the bundled replay GPX (kingston-epsom): with
/// --dart-define=REPLAY_GPS=true, Start Drive runs that route end to end.
/// The real destination picker lands in Sprint 11.
const _replayDestination = Coord(lat: 51.33627, lon: -0.267567);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
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
              Icon(
                Icons.directions_car_filled,
                size: 96,
                color: scheme.primary,
              ),
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
                onPressed: () {
                  if (replayGpsEnabled) {
                    ref
                        .read(driveControllerProvider.notifier)
                        .startDrive(destination: _replayDestination);
                    context.push(Routes.drive);
                  } else {
                    // Destination picker lands in Sprint 11.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Journey setup coming soon'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Recent journeys',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'No journeys yet',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
