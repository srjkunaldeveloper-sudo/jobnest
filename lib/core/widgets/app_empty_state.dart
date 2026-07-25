import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
