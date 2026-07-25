import 'package:flutter/material.dart';

class ServicesRecent extends StatelessWidget {
  const ServicesRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Recently Used backend/local storage se aayega.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recently Used",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRecentCard(
                context,
                title: "Job Templates",
                time: "2 hours ago",
                icon: Icons.post_add_rounded,
                color: Colors.teal,
              ),
              const SizedBox(width: 12),
              _buildRecentCard(
                context,
                title: "Communication Hub",
                time: "Yesterday",
                icon: Icons.email_rounded,
                color: Colors.indigo,
              ),
              const SizedBox(width: 12),
              _buildRecentCard(
                context,
                title: "CRM Dashboard",
                time: "2 days ago",
                icon: Icons.people_rounded,
                color: Colors.cyan,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCard(
    BuildContext context, {
    required String title,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
