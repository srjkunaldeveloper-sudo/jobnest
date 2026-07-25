import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Attendance API future me connect hogi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Attendance Dashboard"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(context),
                const SizedBox(height: 32),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildRecentCheckIns(context),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildAttendanceCalendarMock(context),
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

  Widget _buildSummaryCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 2);
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.0,
          children: [
            _buildStatCard(context, "Present", "102", Icons.check_circle_rounded, Colors.green),
            _buildStatCard(context, "Absent", "12", Icons.cancel_rounded, Colors.redAccent),
            _buildStatCard(context, "Late", "7", Icons.watch_later_rounded, Colors.orange),
            _buildStatCard(context, "On Leave", "3", Icons.event_busy_rounded, Colors.blueGrey),
          ],
        );
      }
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCheckIns(BuildContext context) {
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
                "Today's Check-ins",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCheckInItem(context, "Rahul Sharma", "09:05 AM", "Engineering", Colors.green, "On Time"),
          const Divider(),
          _buildCheckInItem(context, "Priya Singh", "09:30 AM", "HR & Admin", Colors.orange, "Late"),
          const Divider(),
          _buildCheckInItem(context, "Amit Patel", "08:50 AM", "Sales", Colors.green, "On Time"),
          const Divider(),
          _buildCheckInItem(context, "Sneha K.", "09:45 AM", "Marketing", Colors.orange, "Late"),
        ],
      ),
    );
  }

  Widget _buildCheckInItem(BuildContext context, String name, String time, String dept, Color statusColor, String statusText) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(name[0], style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text(dept, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCalendarMock(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Overview",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayCircle(context, "Mon", Colors.green),
              _buildDayCircle(context, "Tue", Colors.green),
              _buildDayCircle(context, "Wed", Colors.orange),
              _buildDayCircle(context, "Thu", Colors.green),
              _buildDayCircle(context, "Fri", theme.colorScheme.surfaceContainerHighest),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "Trend",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.85,
            minHeight: 12,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: Colors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 8),
          Text(
            "85% on-time attendance this week.",
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCircle(BuildContext context, String day, Color color) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color == theme.colorScheme.surfaceContainerHighest ? color : color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              color == Colors.green ? Icons.check_rounded : (color == Colors.orange ? Icons.warning_rounded : Icons.more_horiz_rounded),
              color: color == theme.colorScheme.surfaceContainerHighest ? theme.colorScheme.onSurfaceVariant : color,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
