import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';

class PerformanceDashboardScreen extends StatelessWidget {
  const PerformanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Performance metrics backend analytics se aayenge.
    return AppPageScaffold(
      title: "Performance Dashboard",
      body: SingleChildScrollView(
        padding: AppSpacing.edgeInsetsAll24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                _buildOverviewCard(context),
                AppSpacing.h32,
                
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 2);
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildMetricCard(context, "Completed Tasks", "45", AppIcons.task_alt_rounded, Colors.green),
                        _buildMetricCard(context, "Attendance %", "96%", AppIcons.calendar_month_rounded, Colors.blueAccent),
                        _buildMetricCard(context, "Productivity", "8.5/10", AppIcons.speed_rounded, Colors.orange),
                        _buildMetricCard(context, "Monthly Rating", "A-", AppIcons.star_rounded, Colors.purpleAccent),
                      ],
                    );
                  }
                ),
                AppSpacing.h32,
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildGoalProgressCard(context),
                    ),
                    AppSpacing.w24,
                    Expanded(
                      child: _buildTopPerformersCard(context),
                    ),
                  ],
                ),
                AppSpacing.h48,
              ],
            ),
          ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company Performance",
                style: AppText.h2,
              ),
              AppSpacing.h8,
              Text(
                "Q3 2026 Analytics",
                style: AppText.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.88,
                  strokeWidth: 8,
                  backgroundColor: Colors.green.withValues(alpha: 0.2),
                  color: Colors.green,
                ),
              ),
              Text(
                "88%",
                style: AppText.h3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              AppSpacing.w8,
              Expanded(
                child: Text(
                  title,
                  style: AppText.label.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppText.h1,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalProgressCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quarterly Goals",
            style: AppText.h3,
          ),
          AppSpacing.h24,
          _buildGoalItem(context, "Hire 20 Engineers", 0.75, Colors.blueAccent),
          AppSpacing.h16,
          _buildGoalItem(context, "Reduce Time-to-Hire", 0.90, Colors.green),
          AppSpacing.h16,
          _buildGoalItem(context, "Launch Employer Branding", 0.40, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildGoalItem(BuildContext context, String title, double progress, Color color) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppText.h3.copyWith(fontSize: 14)),
            Text("${(progress * 100).toInt()}%", style: AppText.label.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
        AppSpacing.h8,
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: color.withValues(alpha: 0.2),
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildTopPerformersCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performers",
            style: AppText.h3,
          ),
          AppSpacing.h16,
          _buildPerformerItem(context, "Rahul S.", "Engineering"),
          const Divider(),
          _buildPerformerItem(context, "Priya M.", "Sales"),
          const Divider(),
          _buildPerformerItem(context, "Amit P.", "HR"),
        ],
      ),
    );
  }

  Widget _buildPerformerItem(BuildContext context, String name, String dept) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(name[0], style: AppText.label.copyWith(color: theme.colorScheme.onPrimaryContainer)),
          ),
          AppSpacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppText.h3.copyWith(fontSize: 16)),
                Text(dept, style: AppText.label.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          const Icon(AppIcons.workspace_premium_rounded, color: Colors.amber, size: 20),
        ],
      ),
    );
  }
}
