import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class HomeSmartNotifications extends StatelessWidget {
  const HomeSmartNotifications({super.key});

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
                "Smart Notifications",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              Icon(
                Icons.notifications_active_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ],
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: Notifications API connect hogi.
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildNotificationItem(
                  context,
                  title: "Urgent Hiring Alert",
                  time: "Just now",
                  priority: "High",
                  priorityColor: Colors.redAccent,
                  isLast: false,
                ),
                const Divider(height: 1),
                _buildNotificationItem(
                  context,
                  title: "Interview starts in 20 min",
                  time: "20 min",
                  priority: "High",
                  priorityColor: Colors.redAccent,
                  isLast: false,
                ),
                const Divider(height: 1),
                _buildNotificationItem(
                  context,
                  title: "12 New Applications",
                  time: "1 hour ago",
                  priority: "Medium",
                  priorityColor: Colors.orangeAccent,
                  isLast: false,
                ),
                const Divider(height: 1),
                _buildNotificationItem(
                  context,
                  title: "Offer Letter Pending",
                  time: "3 hours ago",
                  priority: "Low",
                  priorityColor: Colors.blueAccent,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String time,
    required String priority,
    required Color priorityColor,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Indicator dot
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: priorityColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: priorityColor,
                        ),
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
                const SizedBox(height: 6),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Action Button
          FilledButton.tonal(
            onPressed: () {},
            style: FilledButton.styleFrom(
              minimumSize: const Size(60, 32),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            child: const Text("View"),
          ),
        ],
      ),
    );
  }
}
