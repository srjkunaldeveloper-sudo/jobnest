import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileHelpScreen extends StatelessWidget {
  const ProfileHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Help & Support"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildHelpTile(context, Icons.question_answer_outlined, "Frequently Asked Questions", "Find answers to common issues."),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(context, Icons.headset_mic_outlined, "Contact Support", "Chat with our enterprise support team."),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(context, Icons.bug_report_outlined, "Report a Bug", "Found an issue? Let our engineers know."),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(context, Icons.rate_review_outlined, "Send Feedback", "Tell us what you love or what we can improve."),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildHelpTile(context, Icons.gavel_outlined, "Terms & Privacy Policy", "Read our data and privacy agreements."),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpTile(BuildContext context, IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {},
    );
  }
}
