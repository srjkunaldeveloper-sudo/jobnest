import 'package:flutter/material.dart';
import 'package:jobnest/core/services/session_manager.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/auth/auth_flow_screen.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  bool _twoFactor = true;
  bool _profileVisibility = true;
  bool _dataCollection = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Logout token invalidation.
    // TODO: Fetch recruiter profile.
    // TODO: Security APIs future me integrate hongi.
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Security & Privacy Settings"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              _buildSection(
                context,
                title: "Account Security & Credentials",
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
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password updated successfully!"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.lock_reset_rounded),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        label: const Text("Update Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Multi-Factor Authentication",
                child: _buildSwitch(
                  title: "Two-Factor Authentication (2FA)",
                  subtitle: "Add an extra layer of security to your enterprise account using an authenticator app.",
                  value: _twoFactor,
                  onChanged: (val) => setState(() => _twoFactor = val),
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Active Devices & Sessions",
                child: Column(
                  children: [
                    _buildDeviceTile(
                      context, 
                      Icons.laptop_mac_rounded, 
                      "MacBook Pro (Current Session)", 
                      "Bangalore, India • Active now • IP 192.168.1.1", 
                      true
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDeviceTile(
                      context, 
                      Icons.phone_iphone_rounded, 
                      "iPhone 14 Pro Max", 
                      "Bangalore, India • Last active 2 hours ago", 
                      false
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: "Enterprise Privacy Settings",
                child: Column(
                  children: [
                    _buildSwitch(
                      title: "Public Recruiter Profile Visibility",
                      subtitle: "Allow prospective candidates and clients to view your professional credentials.",
                      value: _profileVisibility,
                      onChanged: (val) => setState(() => _profileVisibility = val),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildSwitch(
                      title: "Anonymized Analytics Sharing",
                      subtitle: "Allow JobNest to collect anonymized recruitment metric diagnostics.",
                      value: _dataCollection,
                      onChanged: (val) => setState(() => _dataCollection = val),
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

  Widget _buildSwitch({
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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

  Widget _buildDeviceTile(BuildContext context, IconData icon, String title, String subtitle, bool isCurrent) {
    final theme = Theme.of(context);
    return Semantics(
      label: "$title. $subtitle",
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrent ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13)),
          ),
          trailing: TextButton(
            onPressed: () => _showLogoutDialog(context),
            style: TextButton.styleFrom(
              minimumSize: const Size(64, 48),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(
              isCurrent ? "Active" : "Log Out",
              style: TextStyle(
                color: isCurrent ? Colors.green : theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Terminate Session"),
        content: const Text("Are you sure you want to log out of JobNest on this device?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop(); // Close dialog
              await SessionManager.instance.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthFlowScreen()),
                (route) => false,
              );
            },
            style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
            child: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
