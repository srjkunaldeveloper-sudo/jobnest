import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/providers/profile_data_provider.dart';

class ProfileNotificationsScreen extends StatelessWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProfileDataProvider>();

    // ===== BACKEND TODO =====
    // TODO: Notification preferences API.
    // TODO: Notification settings backend sync hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Notification Preferences"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            children: [
              _buildSection(
                context,
                title: "Delivery Methods",
                child: Column(
                  children: [
                    _buildSwitchTile(
                      context,
                      title: "Push Notifications",
                      subtitle: "Receive real-time alerts directly on your mobile and desktop devices.",
                      value: provider.pushNotifications,
                      onChanged: (val) => provider.setPushNotifications(val),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildSwitchTile(
                      context,
                      title: "Email Notifications",
                      subtitle: "Receive daily digests, candidate applications, and updates via email.",
                      value: provider.emailNotifications,
                      onChanged: (val) => provider.setEmailNotifications(val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Alert Types",
                child: Column(
                  children: [
                    _buildSwitchTile(
                      context,
                      title: "Interview Reminders",
                      subtitle: "Get notified 30 minutes before scheduled candidate interviews or meetings.",
                      value: provider.interviewReminders,
                      onChanged: (val) => provider.setInterviewReminders(val),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildSwitchTile(
                      context,
                      title: "Marketing Updates",
                      subtitle: "Receive promotional offers, recruitment tips, and product newsletters.",
                      value: provider.marketingUpdates,
                      onChanged: (val) => provider.setMarketingUpdates(val),
                    ),
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
          padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
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

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Semantics(
      label: "$title. $subtitle. Status: ${value ? 'Enabled' : 'Disabled'}",
      toggled: value,
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(subtitle, style: const TextStyle(height: 1.3, fontSize: 13)),
          ),
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
