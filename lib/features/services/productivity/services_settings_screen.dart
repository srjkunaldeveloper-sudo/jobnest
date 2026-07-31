import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/page_layouts/app_page_scaffold.dart';

class ServicesSettingsScreen extends StatelessWidget {
  const ServicesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Settings backend/local storage me save hongi.
    return AppPageScaffold(
      title: "Services Settings",
      body: SingleChildScrollView(
        padding: AppSpacing.edgeInsetsAll24,
        child: Column(
          children: [
              _buildSettingsSection(
                context,
                title: "Automation Preferences",
                children: [
                  _buildSwitchTile(context, "Enable Auto Shortlist", "Automatically move candidates to 'Shortlisted' if AI score > 85.", true),
                  const Divider(),
                  _buildSwitchTile(context, "Auto-Reject Notifications", "Send gentle rejection emails immediately to candidates below threshold.", false),
                  const Divider(),
                  _buildSwitchTile(context, "Pipeline Auto-Advancement", "Move deals across CRM pipeline automatically on status updates.", true),
                ],
              ),
              const SizedBox(height: 24),
              _buildSettingsSection(
                context,
                title: "Notification Preferences",
                children: [
                  _buildSwitchTile(context, "Email Notifications", "Receive daily summaries of recruiter activities and goals.", true),
                  const Divider(),
                  _buildSwitchTile(context, "Push Notifications", "Receive real-time alerts for new job applications on mobile.", true),
                  const Divider(),
                  _buildSwitchTile(context, "Slack Integration Alerts", "Send automated hiring updates directly to your Slack channel.", false),
                ],
              ),
              const SizedBox(height: 24),
              _buildSettingsSection(
                context,
                title: "AI Preferences",
                children: [
                  _buildSwitchTile(context, "AI Candidate Matching", "Use deep learning to parse and match resumes to JDs.", true),
                  const Divider(),
                  _buildSwitchTile(context, "Generative AI Assist", "Suggest dynamic interview questions and offer letters.", true),
                  const Divider(),
                  _buildSwitchTile(context, "Bias Reduction Filter", "Hide names and avatars during initial candidate screening.", false),
                ],
              ),
              const SizedBox(height: 24),
              _buildSettingsSection(
                context,
                title: "Application Settings",
                children: [
                  ListTile(
                    title: const Text("Default Candidate Filters"),
                    subtitle: const Text("Manage the preset filters used on the Candidates Dashboard."),
                    trailing: const Icon(AppIcons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Theme Settings"),
                    subtitle: const Text("System Default (Dark Mode enabled)"),
                    trailing: const Icon(AppIcons.palette_rounded, size: 20),
                    onTap: () {},
                  ),
                ],
              ),
              AppSpacing.h48,
            ],
          ),
        ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, {required String title, required List<Widget> children}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: AppText.h3.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(BuildContext context, String title, String subtitle, bool initialValue) {
    return SwitchListTile(
      title: Text(title, style: AppText.h3.copyWith(fontSize: 16)),
      subtitle: Text(subtitle, style: AppText.caption),
      value: initialValue,
      onChanged: (val) {},
    );
  }
}
