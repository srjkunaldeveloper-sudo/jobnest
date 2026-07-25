import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class TaskManagerScreen extends StatelessWidget {
  const TaskManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Task Management backend se sync hoga.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Task Manager"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            tooltip: "New Task",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(24.0),
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
            const SizedBox(width: 24),
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
            const SizedBox(width: 24),
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
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.all(16),
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
              style: theme.textTheme.labelSmall?.copyWith(
                color: priorityColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    assignee,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 12, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    dueDate,
                    style: theme.textTheme.labelSmall?.copyWith(
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
