import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CommunicationTimelineScreen extends StatelessWidget {
  const CommunicationTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Communications CRM backend se load hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Communication Timeline"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(AppIcons.add_comment_rounded),
            tooltip: "Log Interaction",
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
              _buildTimelineItem(
                context,
                title: "Offer Shared",
                subtitle: "Sent via email to TechCorp for Senior Developer role.",
                time: "Today, 10:30 AM",
                icon: AppIcons.local_activity_rounded,
                color: Colors.purpleAccent,
                isFirst: true,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Meeting Completed",
                subtitle: "Final round interview wrap-up meeting with client.",
                time: "Yesterday, 4:00 PM",
                icon: AppIcons.groups_rounded,
                color: Colors.blueAccent,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Interview Scheduled",
                subtitle: "Technical round scheduled for Rahul Sharma.",
                time: "Oct 12, 11:00 AM",
                icon: AppIcons.event_rounded,
                color: Colors.orange,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Call Completed",
                subtitle: "Discussed candidate feedback with TechCorp HR.",
                time: "Oct 10, 2:15 PM",
                icon: AppIcons.phone_in_talk_rounded,
                color: Colors.green,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Email Sent",
                subtitle: "Sent initial shortlist of 5 candidates.",
                time: "Oct 8, 09:45 AM",
                icon: AppIcons.email_rounded,
                color: theme.colorScheme.primary,
                isFirst: false,
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
    required bool isFirst,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : theme.dividerColor,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : theme.dividerColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          time,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
