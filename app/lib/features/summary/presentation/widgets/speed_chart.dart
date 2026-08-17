import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/units.dart';
import '../../domain/entities/journey.dart';

class SpeedChart extends StatelessWidget {
  const SpeedChart({super.key, required this.journey, required this.formatter});

  final Journey journey;
  final UnitsFormatter formatter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (journey.samples.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text('No speed data recorded')),
      );
    }

    final t0 = journey.startedAt.millisecondsSinceEpoch.toDouble();

    List<FlSpot> speedSpots = [];
    List<FlSpot> limitSpots = [];

    for (final s in journey.samples) {
      final xSec = (s.time.millisecondsSinceEpoch - t0) / 1000;
      speedSpots.add(FlSpot(xSec, formatter.speedValue(s.speedMps).toDouble()));
      if (s.limitMph != null) {
        limitSpots.add(
          FlSpot(xSec, formatter.limitValue(s.limitMph!).toDouble()),
        );
      }
    }

    final maxY = [
      ...speedSpots.map((s) => s.y),
      ...limitSpots.map((s) => s.y),
      10.0,
    ].reduce((a, b) => a > b ? a : b) * 1.1;

    final xMax = speedSpots.last.x;

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: xMax,
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: scheme.outlineVariant,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (v, meta) => Text(
                  '${v.toInt()}',
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (v, meta) {
                  final min = (v / 60).round();
                  return Text(
                    '${min}m',
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            // Actual speed
            LineChartBarData(
              spots: speedSpots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: scheme.primary,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: scheme.primary.withValues(alpha: 0.08),
              ),
            ),
            // Speed limit (if present)
            if (limitSpots.isNotEmpty)
              LineChartBarData(
                spots: limitSpots,
                isCurved: false,
                color: const Color(0xFFD32F2F),
                barWidth: 1.5,
                dashArray: [6, 4],
                dotData: const FlDotData(show: false),
              ),
          ],
        ),
      ),
    );
  }
}
