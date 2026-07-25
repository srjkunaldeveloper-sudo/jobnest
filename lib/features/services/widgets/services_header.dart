import 'package:flutter/material.dart';

class ServicesHeader extends StatelessWidget {
  const ServicesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "AI tools and productivity services for recruiters.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildIconButton(context, Icons.search_rounded),
            const SizedBox(width: 8),
            _buildIconButton(context, Icons.history_rounded),
            const SizedBox(width: 8),
            _buildIconButton(context, Icons.more_vert_rounded),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
        onPressed: () {},
        splashRadius: 20,
      ),
    );
  }
}
