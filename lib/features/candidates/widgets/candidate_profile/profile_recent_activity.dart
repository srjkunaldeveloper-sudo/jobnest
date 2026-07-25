import 'package:flutter/material.dart';

class ProfileRecentActivity extends StatelessWidget {
  const ProfileRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              _buildActivityItem(
                context,
                title: "Interview Completed",
                subtitle: "Technical Round 1",
                time: "Today, 11:30 AM",
                icon: Icons.forum_rounded,
                isLast: false,
                color: Colors.blueAccent,
              ),
              _buildActivityItem(
                context,
                title: "Shortlisted",
                subtitle: "By Senior Recruiter",
                time: "Yesterday, 2:15 PM",
                icon: Icons.check_circle_rounded,
                isLast: false,
                color: Colors.green,
              ),
              _buildActivityItem(
                context,
                title: "Candidate Applied",
                subtitle: "Via JobNest Portal",
                time: "15 Oct 2023, 10:00 AM",
                icon: Icons.upload_file_rounded,
                isLast: true,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required bool isLast,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: theme.dividerColor.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
