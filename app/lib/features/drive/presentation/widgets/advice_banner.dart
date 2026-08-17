import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/advice.dart';

/// Full-width, color-coded driving recommendation — the screen's focal
/// point after the speed itself.
class AdviceBanner extends StatelessWidget {
  const AdviceBanner({super.key, required this.advice});

  final Advice? advice;

  static const _titles = {
    AdviceAction.maintain: 'All clear',
    AdviceAction.easeOff: 'Ease off the accelerator',
    AdviceAction.brakeGently: 'Brake gently',
    AdviceAction.brake: 'Brake now',
    AdviceAction.prepareSignal: 'Signal ahead — be ready',
  };

  static const _icons = {
    AdviceAction.maintain: Icons.check_circle_outline,
    AdviceAction.easeOff: Icons.keyboard_double_arrow_down,
    AdviceAction.brakeGently: Icons.trending_down,
    AdviceAction.brake: Icons.warning_amber_rounded,
    AdviceAction.prepareSignal: Icons.traffic,
  };

  @override
  Widget build(BuildContext context) {
    final action = advice?.action ?? AdviceAction.maintain;
    final style = Theme.of(context).extension<AdviceColors>()!.of(action);
    final showMessage = advice != null && action != AdviceAction.maintain;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(_icons[action], size: 40, color: style.fg),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titles[action]!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: style.fg,
                  ),
                ),
                if (showMessage)
                  Text(
                    advice!.message,
                    style: TextStyle(fontSize: 16, color: style.fg),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
