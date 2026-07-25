import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ActivityLogsScreen extends StatelessWidget {
  const ActivityLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Activity Logs backend events se sync honge.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("System Activity Logs"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded),
            tooltip: "Export Logs",
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
                "Recent Activities",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                context,
                title: "Offer Released",
                subtitle: "Offer letter generated and sent to Rahul Sharma for 'Senior UI Designer'.",
                time: "Today, 02:30 PM",
                icon: Icons.local_activity_rounded,
                color: Colors.purpleAccent,
                isFirst: true,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Interview Scheduled",
                subtitle: "Technical round scheduled for Priya Singh with TechCorp.",
                time: "Today, 11:15 AM",
                icon: Icons.event_rounded,
                color: Colors.orange,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Job Published",
                subtitle: "New posting 'Backend Engineer - Python' published to job boards.",
                time: "Yesterday, 4:45 PM",
                icon: Icons.publish_rounded,
                color: Colors.green,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Candidate Added",
                subtitle: "Amit Patel was added to the candidate pool via LinkedIn integration.",
                time: "Yesterday, 10:05 AM",
                icon: Icons.person_add_rounded,
                color: Colors.blueAccent,
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: "Recruiter Logged In",
                subtitle: "System login successful from new IP address (Mumbai).",
                time: "Oct 10, 08:30 AM",
                icon: Icons.login_rounded,
                color: theme.colorScheme.onSurfaceVariant,
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
