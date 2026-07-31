import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_buttons.dart';

/// A reusable widget for displaying an empty state in the jobs list.
class JobsEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const JobsEmpty({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (primaryButtonText != null && onPrimaryPressed != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: 240, // Standard max width for buttons to look centered and proportional
                child: AppPrimaryButton(
                  text: primaryButtonText!,
                  onPressed: onPrimaryPressed,
                ),
              ),
            ],
            if (secondaryButtonText != null && onSecondaryPressed != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: 240,
                child: AppSecondaryButton(
                  text: secondaryButtonText!,
                  onPressed: onSecondaryPressed,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
