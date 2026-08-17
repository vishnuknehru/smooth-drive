import 'package:flutter/material.dart';

import '../../../../core/utils/units.dart';

/// UK-style speed-limit roundel; dashed grey when the limit is unknown.
class SpeedLimitSign extends StatelessWidget {
  const SpeedLimitSign({
    super.key,
    required this.limitMph,
    required this.formatter,
    this.diameter = 96,
  });

  final int? limitMph;
  final UnitsFormatter formatter;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final known = limitMph != null;
    return Semantics(
      label: known
          ? 'Speed limit ${formatter.formatLimit(limitMph!)}'
          : 'Speed limit unknown',
      child: Container(
        width: diameter,
        height: diameter,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: known ? const Color(0xFFD32F2F) : Colors.grey,
            width: diameter / 12,
          ),
        ),
        child: Text(
          known ? '${formatter.limitValue(limitMph!)}' : '—',
          style: TextStyle(
            fontSize: diameter / 3,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
