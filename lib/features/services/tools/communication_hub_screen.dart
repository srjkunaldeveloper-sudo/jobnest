import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CommunicationHubScreen extends StatelessWidget {
  const CommunicationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Communication APIs future me integrate hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Communication Hub"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Templates",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTemplateCard(
                  context,
                  title: "Offer Letter",
                  subject: "Job Offer from JobNest",
                  icon: Icons.celebration_rounded,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildTemplateCard(
                  context,
                  title: "Interview Invite",
                  subject: "Invitation: Technical Interview for Flutter Developer",
                  icon: Icons.event_available_rounded,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 16),
                _buildTemplateCard(
                  context,
                  title: "Rejection Email",
                  subject: "Update regarding your application",
                  icon: Icons.block_rounded,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                _buildTemplateCard(
                  context,
                  title: "Interview Reminder",
                  subject: "Reminder: Upcoming Interview Today",
                  icon: Icons.alarm_rounded,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context, {
    required String title,
    required String subject,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Subject: $subject",
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility_rounded, size: 18),
                label: const Text("Preview"),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_rounded, size: 18),
                label: const Text("Edit"),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text("Send"),
                style: FilledButton.styleFrom(
                  backgroundColor: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
