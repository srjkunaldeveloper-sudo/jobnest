import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Attendance API future me connect hogi.
    return AppPageScaffold(
      title: "Attendance Dashboard",
      body: SingleChildScrollView(
        padding: AppSpacing.edgeInsetsAll24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                _buildSummaryCards(context),
                AppSpacing.h32,
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildRecentCheckIns(context),
                    ),
                    AppSpacing.w24,
                    Expanded(
                      child: _buildAttendanceCalendarMock(context),
                    ),
                  ],
                ),
                AppSpacing.h48,
              ],
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
            _buildStatCard(context, "Present", "102", AppIcons.check_circle_rounded, Colors.green),
            _buildStatCard(context, "Absent", "12", AppIcons.cancel_rounded, Colors.redAccent),
            _buildStatCard(context, "Late", "7", AppIcons.watch_later_rounded, Colors.orange),
            _buildStatCard(context, "On Leave", "3", AppIcons.event_busy_rounded, Colors.blueGrey),
          ],
        );
      }
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll16,
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
          AppSpacing.w16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: AppText.h1,
              ),
              Text(
                title,
                style: AppText.label.copyWith(
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
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Check-ins",
                style: AppText.h3,
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              ),
            ],
          ),
          AppSpacing.h16,
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
            child: Text(name[0], style: AppText.label.copyWith(color: theme.colorScheme.onPrimaryContainer)),
          ),
          AppSpacing.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppText.h3.copyWith(fontSize: 16)),
                Text(dept, style: AppText.caption.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: AppText.h3.copyWith(fontSize: 16)),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: AppText.labelSmall.copyWith(
                    color: statusColor,
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
      padding: AppSpacing.edgeInsetsAll24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Overview",
            style: AppText.h3,
          ),
          AppSpacing.h24,
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
          AppSpacing.h32,
          Text(
            "Trend",
            style: AppText.h3.copyWith(fontSize: 16),
          ),
          AppSpacing.h8,
          LinearProgressIndicator(
            value: 0.85,
            minHeight: 12,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: Colors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          AppSpacing.h8,
          Text(
            "85% on-time attendance this week.",
            style: AppText.caption.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
              color == Colors.green ? AppIcons.check_rounded : (color == Colors.orange ? AppIcons.warning_rounded : AppIcons.more_horiz_rounded),
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
