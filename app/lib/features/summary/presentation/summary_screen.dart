import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/units.dart';
import '../../settings/presentation/settings_controller.dart';
import '../domain/entities/journey.dart';
import 'summary_controller.dart';
import 'widgets/recommendations_card.dart';
import 'widgets/score_gauge.dart';
import 'widgets/speed_chart.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key, required this.journeyId});

  final String journeyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJourney = ref.watch(summaryJourneyProvider(journeyId));
    final formatter = ref.watch(unitsFormatterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Journey Summary')),
      body: asyncJourney.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load journey: $e')),
        data: (journey) => _SummaryBody(
          journey: journey,
          formatter: formatter,
        ),
      ),
    );
  }
}

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.journey, required this.formatter});

  final Journey journey;
  final UnitsFormatter formatter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final elapsed = Duration(seconds: journey.durationSeconds.round());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Score gauge
          Center(
            child: ScoreGauge(score: journey.score),
          ),
          const SizedBox(height: 8),
          Text(
            'Smoothness score',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),

          // Stats row
          _StatsRow(
            items: [
              _Stat(
                label: 'Distance',
                value: formatter.formatDistance(journey.distanceMeters),
              ),
              _Stat(
                label: 'Duration',
                value: formatter.formatDuration(elapsed),
              ),
              _Stat(
                label: 'Harsh braking',
                value: '${journey.harshEvents.length}',
              ),
              if (journey.speedComplianceRatio != null)
                _Stat(
                  label: 'Speed compliance',
                  value:
                      '${(journey.speedComplianceRatio! * 100).round()}%',
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Speed profile chart
          Text(
            'Speed profile  (${formatter.speedUnit})',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          SpeedChart(journey: journey, formatter: formatter),
          const SizedBox(height: 16),

          // Recommendations
          RecommendationsCard(journey: journey),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.items});

  final List<_Stat> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items
          .map(
            (s) => Expanded(
              child: Column(
                children: [
                  Text(
                    s.value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    s.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Stat {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;
}
