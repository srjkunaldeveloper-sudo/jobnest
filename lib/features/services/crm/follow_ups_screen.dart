import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class FollowUpsScreen extends StatelessWidget {
  const FollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Follow-ups CRM tasks backend se ayenge.
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Follow-ups"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(AppIcons.add_task_rounded),
            tooltip: "New Follow-up",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildFollowUpCard(
                context,
                title: "Call TechCorp HR for Feedback",
                dueDate: "Today, 3:00 PM",
                priority: "High",
                priorityColor: Colors.redAccent,
                assignee: "Rahul S.",
                status: "Pending",
              ),
              const SizedBox(height: 16),
              _buildFollowUpCard(
                context,
                title: "Send updated JD to Alpha Inc",
                dueDate: "Tomorrow, 10:00 AM",
                priority: "Medium",
                priorityColor: Colors.orange,
                assignee: "Priya M.",
                status: "In Progress",
              ),
              const SizedBox(height: 16),
              _buildFollowUpCard(
                context,
                title: "Schedule onboarding meeting with Beta LLC",
                dueDate: "Oct 15, 2:00 PM",
                priority: "Low",
                priorityColor: Colors.green,
                assignee: "Amit P.",
                status: "Pending",
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowUpCard(
    BuildContext context, {
    required String title,
    required String dueDate,
    required String priority,
    required Color priorityColor,
    required String assignee,
    required String status,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(
                status,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(AppIcons.calendar_today_rounded, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    dueDate,
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(AppIcons.edit_outlined, size: 18),
                label: const Text("Edit"),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(AppIcons.check_circle_outline_rounded, size: 18),
                label: const Text("Mark Complete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
