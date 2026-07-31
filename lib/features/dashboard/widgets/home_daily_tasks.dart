import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/features/dashboard/models/models.dart';
import 'package:jobnest/features/dashboard/providers/dashboard_provider.dart';

class HomeDailyTasks extends StatelessWidget {
  const HomeDailyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DashboardProvider>();
    
    final int completedTasks = provider.completedTasksCount;
    final int totalTasks = provider.totalTasksCount;
    final double progress = provider.tasksProgress;

    final bool isEmpty = provider.dailyTasks.isEmpty;
    final bool isLoading = provider.isDashboardLoading;

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
          if (isLoading)
            const AppShimmerLoading(
              width: double.infinity,
              height: 220,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            )
          else if (isEmpty)
            AppCard(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.task_alt_rounded,
                      size: 56,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "All caught up for today!",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "No pending recruitment tasks or applicant reviews requiring your immediate attention.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
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
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "$completedTasks of $totalTasks tasks completed",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
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
                  ...provider.dailyTasks.map((task) => _buildTaskItem(context, task, provider)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, DailyTaskItem task, DashboardProvider provider) {
    final theme = Theme.of(context);
    final bool isCompleted = task.isCompleted;
    final Color priorityColor = task.priorityColor;

    return Semantics(
      label: "Task ${task.title}, Priority ${task.priority}, Time ${task.time}",
      checked: isCompleted,
      child: Padding(
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
                    provider.toggleTaskCompletion(task.id);
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                activeColor: theme.colorScheme.primary,
              ),
            ),
            AppSpacing.w12,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  provider.toggleTaskCompletion(task.id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            task.priority,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: priorityColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          task.time,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
