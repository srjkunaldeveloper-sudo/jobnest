import 'package:flutter/material.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class HomeDailyTasks extends StatefulWidget {
  const HomeDailyTasks({super.key});

  @override
  State<HomeDailyTasks> createState() => _HomeDailyTasksState();
}

class _HomeDailyTasksState extends State<HomeDailyTasks> {
  // Dummy State
  final Map<String, bool> _tasks = {
    "Interview with Rahul Sharma": true,
    "Follow up with Priya Singh": false,
    "Send Offer Letter": true,
    "Review Java Candidates": false,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    int completedTasks = _tasks.values.where((v) => v).length;
    int totalTasks = _tasks.length;
    double progress = completedTasks / totalTasks;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Tasks",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          AppSpacing.h4,
          Text(
            "Things that need your attention today.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h16,
          // ===== BACKEND TODO =====
          // TODO: Backend se tasks load honge.
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Progress",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$completedTasks of $totalTasks tasks completed",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                AppSpacing.h12,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  ),
                ),
                AppSpacing.h24,
                // Task List
                _buildTaskItem(
                  context,
                  title: "Interview with Rahul Sharma",
                  priority: "High",
                  priorityColor: Colors.redAccent,
                  time: "10:30 AM",
                ),
                _buildTaskItem(
                  context,
                  title: "Follow up with Priya Singh",
                  priority: "Medium",
                  priorityColor: Colors.orangeAccent,
                  time: "12:00 PM",
                ),
                _buildTaskItem(
                  context,
                  title: "Send Offer Letter",
                  priority: "High",
                  priorityColor: Colors.redAccent,
                  time: "02:00 PM",
                ),
                _buildTaskItem(
                  context,
                  title: "Review Java Candidates",
                  priority: "Low",
                  priorityColor: Colors.blueAccent,
                  time: "04:30 PM",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, {
    required String title,
    required String priority,
    required Color priorityColor,
    required String time,
  }) {
    final theme = Theme.of(context);
    bool isCompleted = _tasks[title] ?? false;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isCompleted,
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _tasks[title] = val;
                  });
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: isCompleted ? FontWeight.normal : FontWeight.w600,
                    color: isCompleted ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                  child: Text(title),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(fontSize: 10, color: priorityColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      time,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      "•",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      isCompleted ? "Completed" : "Pending",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isCompleted ? Colors.green : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
