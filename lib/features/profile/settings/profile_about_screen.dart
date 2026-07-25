import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileAboutScreen extends StatelessWidget {
  const ProfileAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("About JobNest"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.work_rounded, size: 40, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "JobNest Enterprise",
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Version 4.2.0 (Build 2026.10.15)",
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildAboutTile(context, Icons.info_outline_rounded, "Developer Info", "Created by TechNova Solutions"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(context, Icons.code_rounded, "Open Source Credits", "Libraries and frameworks used"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(context, Icons.gavel_rounded, "Licenses", "View legal notices and licenses"),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Text(
                  "© 2026 JobNest Inc. All rights reserved.",
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context, IconData icon, String title, String subtitle) {
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
