import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class WorkflowAutomationScreen extends StatelessWidget {
  const WorkflowAutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Workflow automation backend se configure hogi.
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Workflow Automation"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(AppIcons.add_circle_outline_rounded),
            tooltip: "Create Workflow",
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
              Text(
                "Active Automations",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildAutomationCard(
                context,
                title: "Auto Shortlist (AI)",
                description: "Automatically shortlist candidates scoring > 85% on AI matching.",
                icon: AppIcons.auto_awesome_rounded,
                color: Colors.deepPurpleAccent,
                isActive: true,
              ),
              const SizedBox(height: 16),
              _buildAutomationCard(
                context,
                title: "Auto Interview Reminder",
                description: "Send WhatsApp & Email reminders 24 hours before interview.",
                icon: AppIcons.notifications_active_rounded,
                color: Colors.blueAccent,
                isActive: true,
              ),
              const SizedBox(height: 16),
              _buildAutomationCard(
                context,
                title: "Candidate Follow-up",
                description: "Email candidates who haven't replied in 3 days.",
                icon: AppIcons.mark_email_read_rounded,
                color: Colors.orange,
                isActive: false,
              ),
              const SizedBox(height: 16),
              _buildAutomationCard(
                context,
                title: "Offer Reminder",
                description: "Alert hiring managers 2 days before offer expiration.",
                icon: AppIcons.assignment_late_rounded,
                color: Colors.redAccent,
                isActive: true,
              ),
              const SizedBox(height: 16),
              _buildAutomationCard(
                context,
                title: "Auto Status Update",
                description: "Change status to 'Rejected' if no action taken for 30 days.",
                icon: AppIcons.update_rounded,
                color: Colors.teal,
                isActive: false,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutomationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isActive,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green.withValues(alpha: 0.1) : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isActive ? "Running" : "Paused",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isActive ? Colors.green : theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch(
                    value: isActive,
                    onChanged: (val) {},
                    activeTrackColor: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isActive ? "Enabled" : "Disabled",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(AppIcons.settings_outlined, size: 18),
                label: const Text("Configure"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
