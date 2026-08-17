import 'package:flutter/material.dart';

import '../../domain/services/drive_session.dart';

/// MVP debugging aid: raw GPS + route position. Toggled by long-pressing
/// the drive screen.
class DebugRow extends StatelessWidget {
  const DebugRow({super.key, required this.tick});

  final DriveTick? tick;

  @override
  Widget build(BuildContext context) {
    final t = tick;
    final text = t == null
        ? 'waiting for GPS…'
        : '${t.sample.coord.lat.toStringAsFixed(5)}, '
            '${t.sample.coord.lon.toStringAsFixed(5)} · '
            '${t.sample.speedMps.toStringAsFixed(1)} m/s · '
            '${t.update == null ? 'no fix on route' : '${t.update!.positionOnRouteMeters.round()} m on route'}';
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
