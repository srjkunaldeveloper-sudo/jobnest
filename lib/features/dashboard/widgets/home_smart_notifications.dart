import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/features/notifications/notifications_screen.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

class HomeSmartNotifications extends StatelessWidget {
  const HomeSmartNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<RecruitmentDataProvider>();
    final bool isLoading = provider.isDashboardLoading;
    final notifications = provider.notifications.take(4).toList();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Smart Notifications",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "View All",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: theme.colorScheme.primary,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: Notifications API connect hogi.
          if (isLoading)
            const AppShimmerLoading(
              width: double.infinity,
              height: 250,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            )
          else if (notifications.isEmpty)
            AppCard(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  "No recent notifications available.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: notifications.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  final isLast = idx == notifications.length - 1;
                  return Column(
                    children: [
                      _buildNotificationRow(context, item, isLast),
                      if (!isLast) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationRow(BuildContext context, NotificationItem item, bool isLast) {
    final theme = Theme.of(context);
    final priorityString = _getPriorityString(item.priority);
    final priorityColor = _getPriorityColor(item.priority);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NotificationsScreen(),
          ),
        );
      },
      child: Padding(
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
                          priorityString,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.time,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: item.isRead ? FontWeight.normal : FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Action Button
            Semantics(
              label: "View Notification: ${item.title}",
              button: true,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                child: Center(
                  child: FilledButton.tonal(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(60, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("View"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPriorityString(NotificationPriority p) {
    switch (p) {
      case NotificationPriority.high:
        return "High";
      case NotificationPriority.medium:
        return "Medium";
      case NotificationPriority.low:
        return "Low";
    }
  }

  Color _getPriorityColor(NotificationPriority p) {
    switch (p) {
      case NotificationPriority.high:
        return Colors.redAccent;
      case NotificationPriority.medium:
        return Colors.orangeAccent;
      case NotificationPriority.low:
        return Colors.blueAccent;
    }
  }
}
