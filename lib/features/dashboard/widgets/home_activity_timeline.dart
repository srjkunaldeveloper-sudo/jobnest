import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class HomeActivityTimeline extends StatelessWidget {
  const HomeActivityTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Activity",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              )
            ],
          ),
          AppSpacing.h8,
          // ===== BACKEND TODO =====
          // TODO: Activity timeline backend events se populate hogi.
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTimelineItem(
                  context,
                  title: "Candidate Applied",
                  subtitle: "Aarav Sharma applied for Backend Engineer",
                  time: "2 minutes ago",
                  icon: Icons.person_add_rounded,
                  iconColor: Colors.blueAccent,
                  isLast: false,
                ),
                _buildTimelineItem(
                  context,
                  title: "Interview Scheduled",
                  subtitle: "Technical round for UI/UX",
                  time: "15 minutes ago",
                  icon: Icons.calendar_month_rounded,
                  iconColor: Colors.purpleAccent,
                  isLast: false,
                ),
                _buildTimelineItem(
                  context,
                  title: "Job Posted",
                  subtitle: "Senior Flutter Developer",
                  time: "1 hour ago",
                  icon: Icons.work_rounded,
                  iconColor: Colors.orangeAccent,
                  isLast: false,
                ),
                _buildTimelineItem(
                  context,
                  title: "Candidate Selected",
                  subtitle: "Priya Singh for Data Scientist",
                  time: "Yesterday",
                  icon: Icons.verified_rounded,
                  iconColor: Colors.teal,
                  isLast: false,
                ),
                _buildTimelineItem(
                  context,
                  title: "Offer Letter Sent",
                  subtitle: "Offer letter generated for Priya Singh",
                  time: "Yesterday",
                  icon: Icons.mail_rounded,
                  iconColor: Colors.green,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconColor,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline connector
          Column(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: theme.dividerColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0), // Spacing between items
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
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
                    style: theme.textTheme.bodyMedium?.copyWith(
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
