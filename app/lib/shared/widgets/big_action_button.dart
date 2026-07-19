import 'package:flutter/material.dart';

/// Full-width, high-touch-target primary action button.
class BigActionButton extends StatelessWidget {
  const BigActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon case final icon?) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(label),
      );
    }
    return FilledButton(onPressed: onPressed, child: Text(label));
  }
}
