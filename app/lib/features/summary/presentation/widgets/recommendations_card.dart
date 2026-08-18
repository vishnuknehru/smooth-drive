import 'package:flutter/material.dart';

import '../../domain/entities/journey.dart';

class RecommendationsCard extends StatelessWidget {
  const RecommendationsCard({super.key, required this.journey});

  final Journey journey;

  List<String> _recommendations() {
    final items = <String>[];
    final harsh = journey.harshEvents.length;
    if (harsh > 0) {
      items.add(
        'You braked harshly $harsh time${harsh > 1 ? 's' : ''}. '
        'Try lifting off the accelerator earlier.',
      );
    }
    if (journey.lateReactions > 0) {
      final n = journey.lateReactions;
      items.add(
        'You reacted late to $n speed reduction${n > 1 ? 's' : ''}. '
        'Watch for speed limit signs further ahead.',
      );
    }
    final compliance = journey.speedComplianceRatio;
    if (compliance != null && compliance < 0.9) {
      final pct = ((1 - compliance) * 100).round();
      items.add('You exceeded the speed limit for $pct% of the journey.');
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final recs = _recommendations();
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            if (recs.isEmpty)
              Row(
                children: [
                  Icon(Icons.check_circle, color: scheme.primary),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Great drive! No harsh braking detected.'),
                  ),
                ],
              )
            else
              for (final rec in recs) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: scheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(rec)),
                  ],
                ),
                if (rec != recs.last) const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }
}
