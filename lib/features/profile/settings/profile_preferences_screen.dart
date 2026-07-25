import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfilePreferencesScreen extends StatelessWidget {
  const ProfilePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Preferences local/backend storage me save hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("App Preferences"),
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
                    _buildDropdownTile(context, Icons.language_rounded, "Language", "English (US)"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(context, Icons.palette_outlined, "Theme", "System Default"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(context, Icons.calendar_today_rounded, "Date Format", "MM/DD/YYYY"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(context, Icons.schedule_rounded, "Time Zone", "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi"),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(context, Icons.home_rounded, "Default Dashboard", "Home Dashboard"),
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

  Widget _buildDropdownTile(BuildContext context, IconData icon, String title, String currentValue) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(currentValue, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary)),
      trailing: const Icon(Icons.arrow_drop_down_rounded),
      onTap: () {},
    );
  }
}
