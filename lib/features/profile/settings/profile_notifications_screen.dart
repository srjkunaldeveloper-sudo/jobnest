import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileNotificationsScreen extends StatelessWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Notification settings backend sync hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Notifications"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildSection(
                context,
                title: "Delivery Methods",
                child: Column(
                  children: [
                    _buildSwitchTile(context, "Email Notifications", "Receive updates via your registered email address.", true),
                    const Divider(),
                    _buildSwitchTile(context, "Push Notifications", "Receive alerts directly on your device.", true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Alert Types",
                child: Column(
                  children: [
                    _buildSwitchTile(context, "Interview Alerts", "Get notified when an interview is scheduled or changed.", true),
                    const Divider(),
                    _buildSwitchTile(context, "Candidate Updates", "Alerts for new applications or candidate status changes.", true),
                    const Divider(),
                    _buildSwitchTile(context, "Marketing Emails", "Receive promotional offers and feature updates from JobNest.", false),
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

  Widget _buildSection(BuildContext context, {required String title, required Widget child}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: child,
        ),
      ],
    );
  }

  Widget _buildSwitchTile(BuildContext context, String title, String subtitle, bool initialValue) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      value: initialValue,
      onChanged: (val) {},
    );
  }
}
