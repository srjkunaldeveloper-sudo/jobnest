import 'package:flutter/material.dart';

class CandidatesHeader extends StatelessWidget {
  const CandidatesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Candidates",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Search and manage applicants.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildIconButton(context, Icons.search_rounded, () {}),
              const SizedBox(width: 8),
              _buildIconButton(context, Icons.tune_rounded, () {}),
              const SizedBox(width: 8),
              _buildIconButton(context, Icons.sort_rounded, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, VoidCallback onTap) {
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
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }
}
