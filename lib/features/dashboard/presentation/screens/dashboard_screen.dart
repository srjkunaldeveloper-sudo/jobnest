import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_buttons.dart';
import '../providers/dashboard_provider.dart';
import '../providers/dashboard_state.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/recent_activity_tile.dart';
import '../widgets/stat_card.dart';
import '../widgets/dashboard_header.dart';

/// The main dashboard screen displaying summary statistics, quick actions, and recent activities.
class DashboardScreen extends StatefulWidget {
  final DashboardProvider provider;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final ValueChanged<String> onQuickAction;
  final VoidCallback onViewAllActivities;

  const DashboardScreen({
    super.key,
    required this.provider,
    required this.onNotificationTap,
    required this.onProfileTap,
    required this.onQuickAction,
    required this.onViewAllActivities,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.loadDashboard();
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'application':
        return AppIcons.description_outlined;
      case 'interview':
        return AppIcons.event_outlined;
      case 'candidate':
        return AppIcons.person_outline;
      default:
        return AppIcons.notifications_none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListenableBuilder(
        listenable: widget.provider,
        builder: (context, _) {
          final state = widget.provider.state;

          if (state.status == DashboardStatus.initial ||
              state.status == DashboardStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DashboardStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      AppIcons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'Failed to load dashboard.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 200,
                      child: AppPrimaryButton(
                        text: 'Retry',
                        icon: AppIcons.refresh,
                        onPressed: widget.provider.loadDashboard,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final summary = state.summary;
          final activities = state.recentActivities.take(5).toList();

          return RefreshIndicator(
            onRefresh: widget.provider.refreshDashboard,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(
                      onProfileTap: widget.onProfileTap,
                    ),
                    const SizedBox(height: 24),

                    // 2) Statistics
                    if (summary != null) ...[
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.5,
                            children: [
                              StatCard(
                                icon: AppIcons.work_outline,
                                title: 'Total Jobs',
                                value: summary.totalJobs.toString(),
                              ),
                              StatCard(
                                icon: AppIcons.work,
                                title: 'Active Jobs',
                                value: summary.activeJobs.toString(),
                              ),
                              StatCard(
                                icon: AppIcons.people_outline,
                                title: 'Candidates',
                                value: summary.totalCandidates.toString(),
                              ),
                              StatCard(
                                icon: AppIcons.how_to_reg,
                                title: 'Shortlisted',
                                value: summary.shortlistedCandidates.toString(),
                              ),
                              StatCard(
                                icon: AppIcons.event,
                                title: 'Interviews Today',
                                value: summary.interviewsToday.toString(),
                              ),
                              StatCard(
                                icon: AppIcons.task_alt,
                                title: 'Hired',
                                value: summary.hiredCandidates.toString(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 3) Quick Actions
                    if (state.quickActions.isNotEmpty) ...[
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth > 600 ? 6 : 4;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: state.quickActions.length,
                            itemBuilder: (context, index) {
                              final action = state.quickActions[index];
                              return QuickActionCard(
                                icon: action.icon,
                                title: action.title,
                                enabled: action.enabled,
                                onTap: action.enabled
                                    ? () => widget.onQuickAction(action.route)
                                    : null,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 4) Recent Activity
                    if (activities.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Activity',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextButton(
                            onPressed: widget.onViewAllActivities,
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        clipBehavior: Clip.antiAlias,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            final isLast = index == activities.length - 1;
                            return RecentActivityTile(
                              icon: _getActivityIcon(activity.type),
                              title: activity.title,
                              description: activity.description,
                              time: _formatTime(activity.createdAt),
                              showDivider: !isLast,
                              onTap: () {
                                // Additional logic can be added here
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
