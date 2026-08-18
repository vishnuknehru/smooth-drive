import 'package:flutter/material.dart';

import '../../../../core/utils/units.dart';

/// Current speed, readable at arm's length on a dashboard mount.
class SpeedDisplay extends StatelessWidget {
  const SpeedDisplay({
    super.key,
    required this.speedMps,
    required this.formatter,
  });

  final double speedMps;
  final UnitsFormatter formatter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${formatter.speedValue(speedMps)}',
          style: TextStyle(
            fontSize: 96,
            height: 1,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: scheme.onSurface,
          ),
        ),
        Text(
          formatter.speedUnit,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
