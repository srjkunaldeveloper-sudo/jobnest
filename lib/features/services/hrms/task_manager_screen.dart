import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';

class TaskManagerScreen extends StatelessWidget {
  const TaskManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Task Management backend se sync hoga.
    return AppPageScaffold(
      title: "Task Manager",
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.add_rounded),
          tooltip: "New Task",
        ),
        AppSpacing.w8,
      ],
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.edgeInsetsAll24,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKanbanColumn(
              context,
              title: "To Do",
              count: "3",
              color: Colors.blueGrey,
              tasks: [
                _buildTaskCard(context, "Review Candidate Profiles", "Priya S.", "High", Colors.redAccent, "Today"),
                _buildTaskCard(context, "Draft Offer Letter", "Amit P.", "Medium", Colors.orange, "Tomorrow"),
                _buildTaskCard(context, "Update Job Posting", "Rahul S.", "Low", Colors.green, "Next Week"),
              ],
            ),
            AppSpacing.w24,
            _buildKanbanColumn(
              context,
              title: "In Progress",
              count: "2",
              color: Colors.blueAccent,
              tasks: [
                _buildTaskCard(context, "Conduct Final Interviews", "Priya S.", "High", Colors.redAccent, "Today"),
                _buildTaskCard(context, "Prepare Monthly Report", "Rahul S.", "Medium", Colors.orange, "Friday"),
              ],
            ),
            AppSpacing.w24,
            _buildKanbanColumn(
              context,
              title: "Completed",
              count: "4",
              color: Colors.green,
              tasks: [
                _buildTaskCard(context, "Onboard New Hires", "Amit P.", "Low", Colors.green, "Yesterday"),
                _buildTaskCard(context, "Send Rejection Emails", "Priya S.", "Medium", Colors.orange, "Yesterday"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKanbanColumn(BuildContext context, {required String title, required String count, required Color color, required List<Widget> tasks}) {
    final theme = Theme.of(context);
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    AppSpacing.w12,
                    Text(
                      title,
                      style: AppText.h3.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count,
                    style: AppText.label.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: tasks.map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: task,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, String title, String assignee, String priority, Color priorityColor, String dueDate) {
    final theme = Theme.of(context);
    return AppCard(
      padding: AppSpacing.edgeInsetsAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              priority,
              style: AppText.labelSmall.copyWith(
                color: priorityColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSpacing.h12,
          Text(
            title,
            style: AppText.h3.copyWith(fontSize: 14),
          ),
          AppSpacing.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      assignee[0],
                      style: AppText.labelSmall.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  AppSpacing.w8,
                  Text(
                    assignee,
                    style: AppText.label.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(AppIcons.calendar_today_rounded, size: 12, color: theme.colorScheme.onSurfaceVariant),
                  AppSpacing.w4,
                  Text(
                    dueDate,
                    style: AppText.labelSmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
