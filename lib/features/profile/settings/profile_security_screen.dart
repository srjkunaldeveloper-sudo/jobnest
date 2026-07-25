import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileSecurityScreen extends StatelessWidget {
  const ProfileSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Security APIs future me integrate hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Security & Privacy"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildSection(
                context,
                title: "Change Password",
                child: Column(
                  children: [
                    _buildPasswordField(context, "Current Password"),
                    const SizedBox(height: 16),
                    _buildPasswordField(context, "New Password"),
                    const SizedBox(height: 16),
                    _buildPasswordField(context, "Confirm New Password"),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Update Password"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Authentication",
                child: SwitchListTile(
                  title: const Text("Two-Factor Authentication", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Add an extra layer of security to your account using an authenticator app."),
                  value: true,
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Active Devices & Login History",
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.laptop_mac_rounded),
                      title: const Text("MacBook Pro (Current)"),
                      subtitle: const Text("Bangalore, India • Active now"),
                      trailing: TextButton(onPressed: () {}, child: const Text("Log Out")),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone_iphone_rounded),
                      title: const Text("iPhone 14 Pro"),
                      subtitle: const Text("Bangalore, India • Last active 2 hours ago"),
                      trailing: TextButton(onPressed: () {}, child: const Text("Log Out")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Privacy Settings",
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Profile Visibility", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text("Allow candidates to see your profile details."),
                      value: true,
                      onChanged: (val) {},
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text("Data Collection", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text("Allow JobNest to collect anonymized usage data to improve the platform."),
                      value: false,
                      onChanged: (val) {},
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
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "••••••••",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: const Icon(Icons.visibility_off_rounded),
          ),
        ),
      ],
    );
  }
}
