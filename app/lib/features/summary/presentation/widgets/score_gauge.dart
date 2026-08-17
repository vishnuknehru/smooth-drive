import 'dart:math' as math;

import 'package:flutter/material.dart';

class ScoreGauge extends StatelessWidget {
  const ScoreGauge({super.key, required this.score, this.size = 160});

  final int score;
  final double size;

  Color _scoreColor() {
    if (score >= 80) return const Color(0xFF2E7D32);
    if (score >= 60) return const Color(0xFFF9A825);
    return const Color(0xFFC62828);
  }

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor();
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _GaugePainter(score: score, color: color),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: size * 0.34,
                  fontWeight: FontWeight.w700,
                  color: color,
                  height: 1,
                ),
              ),
              Text(
                'out of 100',
                style: TextStyle(
                  fontSize: size * 0.1,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.score, required this.color});

  final int score;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final paint = Paint()
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Background track
    paint.color = color.withValues(alpha: 0.15);
    canvas.drawCircle(center, radius, paint);

    // Filled arc (top → clockwise)
    paint.color = color;
    final sweep = 2 * math.pi * (score.clamp(0, 100) / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      score != old.score || color != old.color;
}
