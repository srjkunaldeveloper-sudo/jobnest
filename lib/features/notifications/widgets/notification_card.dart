import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final bool isMultiSelectMode;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onSwipeRightRead;
  final VoidCallback onSwipeLeftDelete;
  final VoidCallback? onCtaTap;

  const NotificationCard({
    super.key,
    required this.item,
    required this.isMultiSelectMode,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onSwipeRightRead,
    required this.onSwipeLeftDelete,
    this.onCtaTap,
  });

  Color _getPriorityColor(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.high:
        return Colors.redAccent;
      case NotificationPriority.medium:
        return Colors.orange;
      case NotificationPriority.low:
        return Colors.blueGrey;
    }
  }

  String _getPriorityLabel(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.high:
        return "High";
      case NotificationPriority.medium:
        return "Medium";
      case NotificationPriority.low:
        return "Low";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = _getPriorityColor(item.priority);

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: item.isRead
            ? theme.colorScheme.surface
            : theme.colorScheme.primary.withValues(alpha: 0.04),
        borderRadius: AppRadius.large,
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : item.isRead
                  ? theme.dividerColor.withValues(alpha: 0.6)
                  : theme.colorScheme.primary.withValues(alpha: 0.3),
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.large,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: AppRadius.large,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selection Checkbox in Multi-Select Mode (with 48dp target)
                if (isMultiSelectMode) ...[
                  Semantics(
                    label: "Select ${item.title}",
                    checked: isSelected,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Checkbox(
                          value: isSelected,
                          onChanged: (_) => onTap(),
                          activeColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],

                // Type Icon (48dp touch/visual footprint)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.iconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      item.icon,
                      color: item.iconColor,
                      size: 24,
                    ),
                  ),
                ),
                AppSpacing.w16,

                // Title, Description, Time, Priority & CTA
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: Title and Unread Dot
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: item.isRead ? FontWeight.w600 : FontWeight.w800,
                                color: theme.colorScheme.onSurface,
                                height: 1.3,
                              ),
                            ),
                          ),
                          if (!item.isRead) ...[
                            AppSpacing.w8,
                            Semantics(
                              label: "Unread notification",
                              child: Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Description
                      Text(
                        item.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.h12,

                      // Bottom metadata row: Priority badge, Time & Optional CTA
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // Priority Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: priorityColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: priorityColor.withValues(alpha: 0.3),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              _getPriorityLabel(item.priority),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: priorityColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          // Time Stamp
                          Text(
                            item.time,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.85),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Optional CTA with 48dp minimum height touch target
                          if (item.optionalCta != null && !isMultiSelectMode) ...[
                            const SizedBox(width: 4),
                            Semantics(
                              label: item.optionalCta!,
                              button: true,
                              child: OutlinedButton(
                                onPressed: onCtaTap ?? onTap,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  side: BorderSide(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(48, 36), // Accessible tap target
                                ),
                                child: Text(
                                  item.optionalCta!,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // If in multi-select mode, don't allow swipe dismissible to prevent conflicts
    if (isMultiSelectMode) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: cardContent,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: ValueKey(item.id),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24.0),
          child: const Row(
            children: [
              Icon(AppIcons.mark_email_read_rounded, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                "Mark Read",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24.0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 8),
              Icon(AppIcons.delete_outline_rounded, color: Colors.white, size: 24),
            ],
          ),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            // Swipe right -> Mark as read
            onSwipeRightRead();
            return false; // Let parent handle state
          } else if (direction == DismissDirection.endToStart) {
            // Swipe left -> Delete
            onSwipeLeftDelete();
            return false; // Let parent handle deletion and snackbar undo
          }
          return false;
        },
        child: cardContent,
      ),
    );
  }
}
