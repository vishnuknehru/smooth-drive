import 'package:flutter/material.dart';

import '../../features/drive/domain/entities/advice.dart';

/// Banner colors per advice action; separate palettes keep both themes at
/// WCAG AA contrast for the large banner text.
class AdviceColors extends ThemeExtension<AdviceColors> {
  const AdviceColors({required this.styles});

  final Map<AdviceAction, ({Color bg, Color fg})> styles;

  ({Color bg, Color fg}) of(AdviceAction action) => styles[action]!;

  static const light = AdviceColors(
    styles: {
      AdviceAction.maintain: (bg: Color(0xFF2E7D32), fg: Colors.white),
      AdviceAction.easeOff: (bg: Color(0xFFF9A825), fg: Color(0xFF201A00)),
      AdviceAction.brakeGently: (bg: Color(0xFFEF6C00), fg: Color(0xFF1F1200)),
      AdviceAction.brake: (bg: Color(0xFFC62828), fg: Colors.white),
      AdviceAction.prepareSignal: (bg: Color(0xFF1565C0), fg: Colors.white),
    },
  );

  static const dark = AdviceColors(
    styles: {
      AdviceAction.maintain: (bg: Color(0xFF66BB6A), fg: Color(0xFF08210B)),
      AdviceAction.easeOff: (bg: Color(0xFFFFCA28), fg: Color(0xFF241A00)),
      AdviceAction.brakeGently: (bg: Color(0xFFFF9800), fg: Color(0xFF261300)),
      AdviceAction.brake: (bg: Color(0xFFEF5350), fg: Color(0xFF2B0606)),
      AdviceAction.prepareSignal: (
        bg: Color(0xFF64B5F6),
        fg: Color(0xFF06233B),
      ),
    },
  );

  @override
  AdviceColors copyWith({Map<AdviceAction, ({Color bg, Color fg})>? styles}) =>
      AdviceColors(styles: styles ?? this.styles);

  @override
  AdviceColors lerp(AdviceColors? other, double t) =>
      t < 0.5 ? this : (other ?? this);
}

abstract final class AppTheme {
  static const _seed = Color(0xFF00696D); // calm teal

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      extensions: [
        brightness == Brightness.light ? AdviceColors.light : AdviceColors.dark,
      ],
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(64),
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(minVerticalPadding: 12),
    );
  }
}
