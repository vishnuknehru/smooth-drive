import 'package:flutter/material.dart';

import '../../../../core/utils/units.dart';
import '../../domain/entities/route_analysis.dart';
import '../../domain/entities/upcoming.dart';

/// The next few events ahead, largest first — glanceable, not scrollable.
class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({
    super.key,
    required this.events,
    required this.formatter,
    this.maxItems = 3,
  });

  final List<UpcomingEvent> events;
  final UnitsFormatter formatter;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shown = events.take(maxItems).toList();
    if (shown.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No events ahead on this route',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      );
    }
    return Column(
      children: [
        for (final event in shown)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                _EventIcon(event: event),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _label(event),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'in ${formatter.formatDistance(event.distanceAheadMeters)}',
                  style: TextStyle(fontSize: 20, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _label(UpcomingEvent event) => switch (event.type) {
        EventType.speedLimit => event.valueMph == null
            ? 'Speed limit change'
            : formatter.formatLimit(event.valueMph!),
        EventType.trafficSignal => 'Traffic signal',
        EventType.roundabout => 'Roundabout',
        EventType.unknown => 'Road change',
      };
}

class _EventIcon extends StatelessWidget {
  const _EventIcon({required this.event});

  final UpcomingEvent event;

  @override
  Widget build(BuildContext context) {
    if (event.type == EventType.speedLimit && event.valueMph != null) {
      return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD32F2F), width: 4),
        ),
        child: Text(
          '${event.valueMph}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      );
    }
    final icon = switch (event.type) {
      EventType.trafficSignal => Icons.traffic,
      EventType.roundabout => Icons.roundabout_left,
      _ => Icons.info_outline,
    };
    return Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary);
  }
}
