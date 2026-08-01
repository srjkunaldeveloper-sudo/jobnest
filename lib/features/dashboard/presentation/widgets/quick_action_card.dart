import 'package:flutter/material.dart';
import '../../../../core/widgets/app_card.dart';

/// A reusable chip-style widget for displaying quick actions on the dashboard.
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool enabled;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        borderRadius: 24.0, // Keeping chip-like pill radius
        onTap: enabled ? onTap : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
