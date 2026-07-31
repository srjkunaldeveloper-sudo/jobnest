import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileAboutScreen extends StatelessWidget {
  const ProfileAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Version check and OTA update API.
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(AppIcons.work_rounded, size: 44, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "JobNest Enterprise",
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Version 4.2.0 • Build 2026.10.15",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildAboutTile(
                      context,
                      icon: AppIcons.info_outline_rounded,
                      title: "Application Name",
                      subtitle: "JobNest Enterprise Recruiting & ATS Suite",
                      onTap: () {},
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(
                      context,
                      icon: AppIcons.verified_user_outlined,
                      title: "Current Version & Build",
                      subtitle: "Release v4.2.0 (Build 2026.10.15 Enterprise Production)",
                      onTap: () {},
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(
                      context,
                      icon: AppIcons.gavel_outlined,
                      title: "Terms of Service",
                      subtitle: "Master Services Agreement (MSA) and acceptable use terms",
                      onTap: () => _showLegalSheet(context, "Terms of Service", "By utilizing JobNest Enterprise, your company agrees to adhere to our standard recruitment compliance guidelines, anti-bias algorithms protocol, and uptime Service Level Agreements (SLA 99.99%)."),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(
                      context,
                      icon: AppIcons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      subtitle: "GDPR, CCPA, and SOC2 Type II data protection agreements",
                      onTap: () => _showLegalSheet(context, "Privacy Policy", "All applicant resumes, interview feedback, and recruiter notes are encrypted using AES-256 at rest and TLS 1.3 in transit. We never monetize or sell recruitment data to external third parties."),
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildAboutTile(
                      context,
                      icon: AppIcons.article_outlined,
                      title: "Open Source Licenses",
                      subtitle: "View legal notices and third-party software libraries used",
                      onTap: () {
                        showLicensePage(
                          context: context,
                          applicationName: "JobNest Enterprise",
                          applicationVersion: "4.2.0 (Build 2026.10.15)",
                          applicationIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(AppIcons.work_rounded, size: 48, color: theme.colorScheme.primary),
                          ),
                        );
                      },
                    ),
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

  Widget _buildAboutTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Semantics(
      label: "$title. $subtitle",
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
          trailing: Icon(AppIcons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showLegalSheet(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(AppIcons.close_rounded),
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(content, style: const TextStyle(height: 1.5, fontSize: 14)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
