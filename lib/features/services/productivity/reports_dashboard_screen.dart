import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ReportsDashboardScreen extends StatelessWidget {
  const ReportsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Reports analytics API se load honge.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Reports & Analytics"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 800 ? 5 : (constraints.maxWidth > 600 ? 3 : 2);
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _buildMetricCard(context, "Applications", "1,240", Icons.description_rounded, Colors.blueAccent),
                        _buildMetricCard(context, "Interviews", "312", Icons.forum_rounded, Colors.orange),
                        _buildMetricCard(context, "Offers", "45", Icons.local_activity_rounded, Colors.purpleAccent),
                        _buildMetricCard(context, "Hiring Rate", "14.4%", Icons.percent_rounded, Colors.green),
                        _buildMetricCard(context, "Time To Hire", "18 Days", Icons.timer_rounded, Colors.redAccent),
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
                      child: _buildTrendChartCard(context, "Weekly Hiring Trend"),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildRecruiterPerformanceCard(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                _buildDepartmentHiringCard(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChartCard(BuildContext context, String title) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_rounded, size: 16),
                label: const Text("Export"),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Dummy Chart Representation
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChartBar(context, 0.4, "Mon"),
                _buildChartBar(context, 0.6, "Tue"),
                _buildChartBar(context, 0.9, "Wed"),
                _buildChartBar(context, 0.7, "Thu"),
                _buildChartBar(context, 0.5, "Fri"),
                _buildChartBar(context, 0.2, "Sat"),
                _buildChartBar(context, 0.3, "Sun"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(BuildContext context, double heightRatio, String label) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 150 * heightRatio,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildRecruiterPerformanceCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recruiter Performance",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildRecruiterStat(context, "Rahul Sharma", "12 Offers", 0.9),
          const SizedBox(height: 16),
          _buildRecruiterStat(context, "Priya Singh", "8 Offers", 0.6),
          const SizedBox(height: 16),
          _buildRecruiterStat(context, "Amit Patel", "5 Offers", 0.4),
        ],
      ),
    );
  }

  Widget _buildRecruiterStat(BuildContext context, String name, String stat, double progress) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text(stat, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildDepartmentHiringCard(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Department Hiring (Open Roles)",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildDepartmentStat(context, "Engineering", "24", Colors.blueAccent)),
              const SizedBox(width: 16),
              Expanded(child: _buildDepartmentStat(context, "Sales", "12", Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildDepartmentStat(context, "Marketing", "8", Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildDepartmentStat(context, "Design", "4", Colors.purpleAccent)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentStat(BuildContext context, String title, String value, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
