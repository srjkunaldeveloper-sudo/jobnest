import '../../core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

import 'package:jobnest/features/dashboard/widgets/home_header.dart';
import 'package:jobnest/features/dashboard/widgets/home_search.dart';
import 'package:jobnest/features/dashboard/widgets/home_focus.dart';
import 'package:jobnest/features/dashboard/widgets/home_quick_stats.dart';
import 'package:jobnest/features/dashboard/widgets/home_analytics.dart';
import 'package:jobnest/features/dashboard/widgets/home_ai_assistant.dart';
import 'package:jobnest/features/dashboard/widgets/home_quick_actions.dart';
import 'package:jobnest/features/dashboard/widgets/home_daily_tasks.dart';
import 'package:jobnest/features/dashboard/widgets/home_activity_timeline.dart';
import 'package:jobnest/features/dashboard/widgets/home_smart_notifications.dart';
import 'package:jobnest/features/dashboard/widgets/home_hiring_probability.dart';
import 'package:jobnest/features/dashboard/widgets/home_pipeline_snapshot.dart';
import 'package:jobnest/features/dashboard/widgets/home_today_interviews.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNavigateToJobs;
  final VoidCallback? onNavigateToCandidates;
  final VoidCallback? onNavigateToInterviews;

  HomeScreen({
    super.key,
    this.onProfileTap,
    this.onNavigateToJobs,
    this.onNavigateToCandidates,
    this.onNavigateToInterviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    final bool isError = provider.isDashboardError;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => provider.refreshDashboard(),
          color: theme.colorScheme.primary,
          displacement: 40,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double hPad = constraints.maxWidth > 480 ? 24.0 : 20.0;
              final double vPad = 16.0;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Header
                    HomeHeader(onProfileTap: onProfileTap),

                    // Section 2 & 3: Search & Quick Search Chips
                    HomeSearch(),

                    // Section 7: Error State Handling
                    if (isError)
                      _buildErrorState(context, provider)
                    else ...[
                      // Section 4 & 6: Today's Focus (Graceful empty handling & interactive rows)
                      HomeFocus(
                        onNavigateToJobs: onNavigateToJobs,
                        onNavigateToCandidates: onNavigateToCandidates,
                        onNavigateToInterviews: onNavigateToInterviews,
                      ),

                      // Section 5 & 6: Quick Stats (Shimmer loading & empty metrics banner)
                      HomeQuickStats(),

                      // Pipeline Snapshot overview
                      const HomePipelineSnapshot(),

                      // Today's Interviews list card
                      const HomeTodayInterviews(),

                      // Section 5: Analytics
                      HomeAnalytics(),

                      // Section 5: AI Assistant
                      HomeAiAssistant(),

                      // Section 5 & 9: Quick Actions (Accessibility & shimmer)
                      HomeQuickActions(),

                      // Section 5 & 6: Daily Tasks
                      HomeDailyTasks(),

                      // Section 5 & 6: Activity Timeline
                      HomeActivityTimeline(),

                      // Section 5: Smart Notifications
                      HomeSmartNotifications(),

                      // Section 5: Hiring Probability
                      HomeHiringProbability(),
                    ],

                    AppSpacing.h16,
                    // Enterprise QA State Simulation Footer
                    _buildQaSimulationFooter(context, provider),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, DashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: AppErrorState(
          title: "Enterprise Synchronization Failed",
          message: "We couldn't connect to the recruitment data server. Please check your network connection or verify server authentication.",
          primaryButtonText: "Retry Synchronization",
          onRetry: () => provider.refreshDashboard(),
          secondaryButtonText: "Restore Offline Pipeline",
          onSecondaryAction: () => provider.restoreDefault(),
          iconData: AppIcons.cloud_off_rounded,
        ),
      ),
    );
  }

  Widget _buildQaSimulationFooter(BuildContext context, DashboardProvider provider) {
    if (!kDebugMode) return const SizedBox.shrink();
    final theme = Theme.of(context);
    
    Color statusColor = Colors.green;
    String statusText = "Online (Latency 24ms)";
    if (provider.isDashboardLoading) {
      statusColor = Colors.amber;
      statusText = "Syncing with cloud...";
    } else if (provider.isDashboardError) {
      statusColor = theme.colorScheme.error;
      statusText = "Disconnected (Network Error)";
    } else if (provider.jobs.isEmpty && provider.candidates.isEmpty && provider.interviews.isEmpty) {
      statusColor = Colors.blueAccent;
      statusText = "Online (Pipeline Empty)";
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  AppIcons.dns_rounded,
                  color: statusColor,
                  size: 18,
                ),
              ),
              AppSpacing.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enterprise Server Status: $statusText",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "QA Mode • Test dashboard responsiveness & simulation states below",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQaChip(
                context,
                label: "Default Pipeline",
                icon: AppIcons.restore_rounded,
                isActive: !provider.isDashboardLoading && !provider.isDashboardError && provider.jobs.isNotEmpty,
                onTap: () => provider.restoreDefault(),
              ),
              _buildQaChip(
                context,
                label: "Skeleton Loading",
                icon: AppIcons.hourglass_top_rounded,
                isActive: provider.isDashboardLoading,
                onTap: () => provider.simulateLoading(),
              ),
              _buildQaChip(
                context,
                label: "Empty State",
                icon: AppIcons.inbox_rounded,
                isActive: !provider.isDashboardLoading && !provider.isDashboardError && provider.jobs.isEmpty && provider.candidates.isEmpty,
                onTap: () => provider.simulateEmpty(),
              ),
              _buildQaChip(
                context,
                label: "Network Error",
                icon: AppIcons.wifi_off_rounded,
                isActive: provider.isDashboardError,
                onTap: () => provider.simulateError(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQaChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: "Simulate $label",
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isActive ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.4),
                width: isActive ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
