import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [if (icon != null) icon!, Text(text)],
      ),
    );
  }
}
