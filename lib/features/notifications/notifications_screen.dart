import '../../core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
import 'package:jobnest/features/notifications/providers/notification_provider.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';
import 'package:jobnest/features/notifications/widgets/notification_card.dart';
import 'package:jobnest/features/profile/settings/profile_notifications_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // Push notifications (FCM).

  // TODO:
  // Real-time notifications.

  // TODO:
  // Notification pagination.

  // TODO:
  // Read status synchronization.

  // TODO:
  // Deep linking.

  String _selectedFilter = "All";
  
  // Multi-select mode state
  bool _isMultiSelectMode = false;
  final Set<String> _selectedIds = {};

  // Group expansion states (Section 3)
  bool _isTodayExpanded = true;
  bool _isYesterdayExpanded = true;
  bool _isEarlierExpanded = true;

  final List<String> _filterChips = [
    "All",
    "Unread",
    "Jobs",
    "Candidates",
    "Interviews",
    "AI",
    "System",
  ];

  List<NotificationItem> _getFilteredNotifications(List<NotificationItem> all) {
    if (_selectedFilter == "All") {
      return all;
    } else if (_selectedFilter == "Unread") {
      return all.where((item) => !item.isRead).toList();
    } else {
      return all.where((item) => item.category == _selectedFilter).toList();
    }
  }

  void _markAllAsRead(NotificationProvider provider) {
    provider.markAllNotificationsAsRead();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All notifications marked as read"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) {
          _isMultiSelectMode = false;
        }
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _deleteSelected(NotificationProvider provider) {
    final count = _selectedIds.length;
    final idsToDelete = Set<String>.from(_selectedIds);
    final deletedItems = provider.notifications.where((item) => idsToDelete.contains(item.id)).toList();
    
    provider.bulkDeleteNotifications(idsToDelete);
    setState(() {
      _selectedIds.clear();
      _isMultiSelectMode = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$count notification${count > 1 ? 's' : ''} deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            for (var item in deletedItems.reversed) {
              provider.addNotification(item);
            }
          },
        ),
      ),
    );
  }

  void _markSelectedAsRead(NotificationProvider provider) {
    final count = _selectedIds.length;
    provider.bulkMarkReadNotifications(_selectedIds);
    setState(() {
      _selectedIds.clear();
      _isMultiSelectMode = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$count notification${count > 1 ? 's' : ''} marked as read"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleTap(NotificationItem item, NotificationProvider provider) {
    if (_isMultiSelectMode) {
      _toggleSelection(item.id);
      return;
    }

    // Mark read on tap
    if (!item.isRead) {
      provider.toggleNotificationRead(item.id, read: true);
    }

    // Dummy navigation action
    _showDummyNavigationSheet(item);
  }

  void _showDummyNavigationSheet(NotificationItem item) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: item.iconColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 26),
                    ),
                    AppSpacing.w16,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.category.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            item.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpacing.h16,
                Text(
                  item.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                AppSpacing.h24,
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Close Preview", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<NotificationProvider>();
    final allNotifications = provider.notifications;
    final filtered = _getFilteredNotifications(allNotifications);
    final bool isLoading = provider.isLoading;
    final bool isError = provider.isError;

    final todayItems = filtered.where((item) => item.section == "Today").toList();
    final yesterdayItems = filtered.where((item) => item.section == "Yesterday").toList();
    final earlierItems = filtered.where((item) => item.section == "Earlier").toList();

    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: _isMultiSelectMode
          ? _buildMultiSelectAppBar(theme, provider, filtered)
          : _buildNormalAppBar(theme, provider),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Details
                if (!_isMultiSelectMode) _buildHeaderSubtitle(theme),

                // Filter Chips Row
                _buildFilterChipsRow(theme),

                // Content List, Loading Skeleton, Error State, or Empty State
                Expanded(
                  child: isLoading
                      ? _buildSkeletonList()
                      : isError
                          ? _buildErrorState(theme, provider)
                          : filtered.isEmpty
                              ? _buildEmptyState(theme, provider)
                              : _buildNotificationsList(
                                  theme,
                                  provider,
                                  todayItems,
                                  yesterdayItems,
                                  earlierItems,
                                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar(ThemeData theme, NotificationProvider provider) {
    final hasUnread = provider.unreadNotificationsCount > 0;
    return AppBar(
      // backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      title: const Text(
        "Notifications",
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      actions: [
        Semantics(
          label: "Mark All Read",
          button: true,
          child: IconButton(
            tooltip: "Mark All Read",
            icon: const Icon(AppIcons.done_all_rounded),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            onPressed: hasUnread ? () => _markAllAsRead(provider) : null,
          ),
        ),
        Semantics(
          label: "More Options",
          button: true,
          child: PopupMenuButton<String>(
            tooltip: "More Options",
            icon: const Icon(AppIcons.more_vert_rounded),
            constraints: const BoxConstraints(minWidth: 48),
            onSelected: (value) {
              if (value == "settings") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileNotificationsScreen(),
                  ),
                );
              } else if (value == "clear_all") {
                provider.clearAllNotifications();
              } else if (value == "simulate_alert") {
                _simulateNewNotification(provider);
              } else if (value == "simulate_loading") {
                provider.simulateNotificationsLoading();
              } else if (value == "simulate_error") {
                provider.simulateNotificationsError();
              } else if (value == "simulate_empty") {
                provider.simulateNotificationsEmpty();
              } else if (value == "restore") {
                provider.restoreNotificationsDefault();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "settings",
                child: Row(
                  children: [
                    Icon(AppIcons.settings_outlined, size: 20),
                    SizedBox(width: 12),
                    Text("Notification Settings"),
                  ],
                ),
              ),
              if (kDebugMode) ...[
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: "simulate_alert",
                  child: Row(
                    children: [
                      Icon(AppIcons.add_alert_outlined, size: 20, color: Colors.teal),
                      SizedBox(width: 12),
                      Text("QA: Simulate New Alert", style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: "simulate_loading",
                  child: Row(
                    children: [
                      Icon(AppIcons.hourglass_empty_rounded, size: 20, color: Colors.blue),
                      SizedBox(width: 12),
                      Text("QA: Loading Skeleton", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: "simulate_error",
                  child: Row(
                    children: [
                      Icon(AppIcons.error_outline_rounded, size: 20, color: Colors.orange),
                      SizedBox(width: 12),
                      Text("QA: Error State", style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: "simulate_empty",
                  child: Row(
                    children: [
                      Icon(AppIcons.inbox_outlined, size: 20, color: Colors.purple),
                      SizedBox(width: 12),
                      Text("QA: Empty State", style: TextStyle(color: Colors.purple)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: "restore",
                  child: Row(
                    children: [
                      Icon(AppIcons.restore_rounded, size: 20, color: Colors.green),
                      SizedBox(width: 12),
                      Text("QA: Restore Defaults", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: "clear_all",
                child: Row(
                  children: [
                    Icon(AppIcons.delete_sweep_outlined, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text("Clear All", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  PreferredSizeWidget _buildMultiSelectAppBar(
    ThemeData theme,
    NotificationProvider provider,
    List<NotificationItem> currentFiltered,
  ) {
    final bool allSelected = _selectedIds.length == currentFiltered.length && currentFiltered.isNotEmpty;
    return AppBar(
      backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(AppIcons.close_rounded),
        tooltip: "Clear Selection",
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        onPressed: () {
          setState(() {
            _isMultiSelectMode = false;
            _selectedIds.clear();
          });
        },
      ),
      title: Text(
        "${_selectedIds.length} Selected",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
      actions: [
        Semantics(
          label: allSelected ? "Deselect All" : "Select All",
          button: true,
          child: IconButton(
            tooltip: allSelected ? "Deselect All" : "Select All",
            icon: Icon(allSelected ? AppIcons.deselect_rounded : AppIcons.select_all_rounded, color: theme.colorScheme.primary),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            onPressed: () {
              setState(() {
                if (allSelected) {
                  _selectedIds.clear();
                  _isMultiSelectMode = false;
                } else {
                  _selectedIds.addAll(currentFiltered.map((e) => e.id));
                }
              });
            },
          ),
        ),
        Semantics(
          label: "Mark Selected Read",
          button: true,
          child: IconButton(
            tooltip: "Mark Selected Read",
            icon: Icon(AppIcons.mark_email_read_rounded, color: theme.colorScheme.primary),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            onPressed: _selectedIds.isNotEmpty ? () => _markSelectedAsRead(provider) : null,
          ),
        ),
        Semantics(
          label: "Delete Selected",
          button: true,
          child: IconButton(
            tooltip: "Delete Selected",
            icon: const Icon(AppIcons.delete_outline_rounded, color: Colors.red),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            onPressed: _selectedIds.isNotEmpty ? () => _deleteSelected(provider) : null,
          ),
        ),
        AppSpacing.w8,
      ],
    );
  }

  Widget _buildHeaderSubtitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        "Keep track of recruitment activities and important updates.",
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildFilterChipsRow(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: _filterChips.map((chip) {
          final isSelected = _selectedFilter == chip;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Semantics(
              label: "Filter by $chip",
              selected: isSelected,
              button: true,
              child: FilterChip(
                label: Text(chip),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = chip;
                  });
                },
                // backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                selectedColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                checkmarkColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: AppSkeletonCard(),
        );
      },
    );
  }

  Widget _buildErrorState(ThemeData theme, NotificationProvider provider) {
    return AppErrorState(
      title: "Unable to load notifications",
      message: "An unexpected network error occurred while syncing your recruitment activities. Please check your connection and try again.",
      primaryButtonText: "Retry",
      onRetry: () => provider.refreshNotifications(),
      iconData: AppIcons.error_outline_rounded,
    );
  }

  Widget _buildEmptyState(ThemeData theme, NotificationProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _selectedFilter == "Unread"
                    ? AppIcons.done_all_rounded
                    : AppIcons.notifications_off_outlined,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            AppSpacing.h24,
            Text(
              _selectedFilter == "Unread"
                  ? "You're all caught up."
                  : "No notifications found",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.h8,
            Text(
              _selectedFilter == "Unread"
                  ? "There are no unread recruitment activities waiting for your attention."
                  : "When you receive new hiring updates, applications, or system alerts, they will appear here.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.h24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => provider.refreshNotifications(),
                    icon: const Icon(AppIcons.refresh_rounded),
                    label: const Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                if (_selectedFilter != "All") ...[
                  AppSpacing.w12,
                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => setState(() => _selectedFilter = "All"),
                      child: const Text("View All", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    ThemeData theme,
    NotificationProvider provider,
    List<NotificationItem> today,
    List<NotificationItem> yesterday,
    List<NotificationItem> earlier,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      physics: const BouncingScrollPhysics(),
      children: [
        if (today.isNotEmpty) ...[
          _buildSectionHeader(
            theme,
            "Today",
            today.length,
            _isTodayExpanded,
            () => setState(() => _isTodayExpanded = !_isTodayExpanded),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isTodayExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
              children: today.map((item) => _buildCard(item, provider)).toList(),
            ),
            secondChild: const SizedBox(width: double.infinity, height: 0),
          ),
          AppSpacing.h12,
        ],
        if (yesterday.isNotEmpty) ...[
          _buildSectionHeader(
            theme,
            "Yesterday",
            yesterday.length,
            _isYesterdayExpanded,
            () => setState(() => _isYesterdayExpanded = !_isYesterdayExpanded),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isYesterdayExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
              children: yesterday.map((item) => _buildCard(item, provider)).toList(),
            ),
            secondChild: const SizedBox(width: double.infinity, height: 0),
          ),
          AppSpacing.h12,
        ],
        if (earlier.isNotEmpty) ...[
          _buildSectionHeader(
            theme,
            "Earlier",
            earlier.length,
            _isEarlierExpanded,
            () => setState(() => _isEarlierExpanded = !_isEarlierExpanded),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isEarlierExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
              children: earlier.map((item) => _buildCard(item, provider)).toList(),
            ),
            secondChild: const SizedBox(width: double.infinity, height: 0),
          ),
          AppSpacing.h24,
        ],
      ],
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    int count,
    bool isExpanded,
    VoidCallback onToggle,
  ) {
    return Semantics(
      label: "$title section, $count notifications, ${isExpanded ? 'Expanded' : 'Collapsed'}",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                AppSpacing.w8,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count.toString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  isExpanded ? AppIcons.expand_less_rounded : AppIcons.expand_more_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(NotificationItem item, NotificationProvider provider) {
    return NotificationCard(
      item: item,
      isMultiSelectMode: _isMultiSelectMode,
      isSelected: _selectedIds.contains(item.id),
      onTap: () => _handleTap(item, provider),
      onLongPress: () {
        if (!_isMultiSelectMode) {
          setState(() {
            _isMultiSelectMode = true;
            _selectedIds.add(item.id);
          });
        } else {
          _toggleSelection(item.id);
        }
      },
      onSwipeRightRead: () {
        provider.toggleNotificationRead(item.id, read: true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Marked as read"),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onSwipeLeftDelete: () {
        final removedItem = item;
        provider.deleteNotification(item.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Notification deleted"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                provider.addNotification(removedItem);
              },
            ),
          ),
        );
      },
    );
  }

  void _simulateNewNotification(NotificationProvider provider) {
    final newItem = NotificationItem(
      id: "notif_sim_${DateTime.now().millisecondsSinceEpoch}",
      type: NotificationType.newApplicationReceived,
      title: "New Application Received",
      description: "Priya Nair applied for Lead DevOps Specialist just now via LinkedIn Referral.",
      time: "Just now",
      section: "Today",
      priority: NotificationPriority.high,
      optionalCta: "View Candidate",
      isRead: false,
    );

    provider.addNotification(newItem);
    setState(() {
      _selectedFilter = "All";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New notification simulated!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
