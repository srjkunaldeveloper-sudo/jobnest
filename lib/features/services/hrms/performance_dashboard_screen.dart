import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class PerformanceDashboardScreen extends StatelessWidget {
  const PerformanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Performance metrics backend analytics se aayenge.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Performance Dashboard"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewCard(context),
                const SizedBox(height: 32),
                
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
                        _buildMetricCard(context, "Completed Tasks", "45", Icons.task_alt_rounded, Colors.green),
                        _buildMetricCard(context, "Attendance %", "96%", Icons.calendar_month_rounded, Colors.blueAccent),
                        _buildMetricCard(context, "Productivity", "8.5/10", Icons.speed_rounded, Colors.orange),
                        _buildMetricCard(context, "Monthly Rating", "A-", Icons.star_rounded, Colors.purpleAccent),
                      ],
                    );
                  }
                ),
                const SizedBox(height: 32),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildGoalProgressCard(context),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTopPerformersCard(context),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
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
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Q3 2026 Analytics",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
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
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalProgressCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quarterly Goals",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildGoalItem(context, "Hire 20 Engineers", 0.75, Colors.blueAccent),
          const SizedBox(height: 16),
          _buildGoalItem(context, "Reduce Time-to-Hire", 0.90, Colors.green),
          const SizedBox(height: 16),
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
            Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("${(progress * 100).toInt()}%", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 8),
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performers",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
            child: Text(name[0], style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text(dept, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 20),
        ],
      ),
    );
  }
}
