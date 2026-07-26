import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileCommunicationScreen extends StatelessWidget {
  const ProfileCommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch communication preferences.

    // TODO:
    // Update communication settings.

    // TODO:
    // Email service integration.

    // TODO:
    // SMS provider integration.

    // TODO:
    // WhatsApp Business API integration.

    // TODO:
    // Push notification service.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Communication Settings"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => provider.toggleCommunicationEmptyState(),
            icon: Icon(
              provider.isCommunicationEmpty
                  ? Icons.speaker_notes_off_rounded
                  : Icons.speaker_notes_outlined,
              color: provider.isCommunicationEmpty
                  ? theme.colorScheme.error
                  : null,
            ),
            tooltip: provider.isCommunicationEmpty
                ? "Restore Configured Settings"
                : "Simulate Unconfigured / Empty State",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: provider.isCommunicationEmpty
          ? _buildEmptyState(context, provider)
          : _buildPopulatedState(context, provider),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: AppCard(
            padding: const EdgeInsets.all(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer
                        .withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.speaker_notes_off_rounded,
                    size: 56,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Configure your communication preferences to improve candidate engagement.",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Establish automated touchpoints, SMS alerts, WhatsApp integration, and quiet hours to streamline recruitment workflows and maintain professional SLA standards.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: () {
                    provider.toggleCommunicationEmptyState();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Communication preferences initialized (Dummy action)",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune_rounded),
                  label: const Text(
                    "Configure Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopulatedState(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Communication Channels
              _buildSectionHeader(
                theme,
                "Communication Channels",
                "Enable or disable messaging gateways used for candidate and team notifications.",
                Icons.hub_outlined,
              ),
              const SizedBox(height: 14),
              _buildChannelsGrid(context, provider),
              const SizedBox(height: 32),

              // Section 2: Candidate Communication
              _buildSectionHeader(
                theme,
                "Candidate Communication",
                "Manage automated touchpoints dispatched during hiring pipeline stages.",
                Icons.person_pin_circle_outlined,
              ),
              const SizedBox(height: 14),
              _buildCandidateSettingsList(context, provider),
              const SizedBox(height: 32),

              // Section 3: Team Communication
              _buildSectionHeader(
                theme,
                "Team Communication",
                "Configure internal recruiter alerts, interview scorecard reminders, and announcements.",
                Icons.groups_outlined,
              ),
              const SizedBox(height: 14),
              _buildTeamSettingsList(context, provider),
              const SizedBox(height: 32),

              // Section 4: Automated Messages
              _buildSectionHeader(
                theme,
                "Automated Message Templates",
                "Customize placeholder response copy for immediate candidate engagement.",
                Icons.auto_awesome_motion_outlined,
              ),
              const SizedBox(height: 14),
              _buildAutomatedTemplatesSection(context, provider),
              const SizedBox(height: 32),

              // Section 5: Quiet Hours
              _buildSectionHeader(
                theme,
                "Quiet Hours & Do Not Disturb",
                "Mute non-urgent notifications outside active recruitment working hours.",
                Icons.nightlight_round_outlined,
              ),
              const SizedBox(height: 14),
              _buildQuietHoursCard(context, provider),
              const SizedBox(height: 32),

              // Section 6: Email Signature
              _buildSectionHeader(
                theme,
                "Recruiter Email Signature",
                "Professional branding appended to outgoing candidate correspondence.",
                Icons.border_color_outlined,
              ),
              const SizedBox(height: 14),
              _buildEmailSignatureCard(context, provider),
              const SizedBox(height: 32),

              // Section 7: Default Language
              _buildSectionHeader(
                theme,
                "Default Communication Language",
                "Select primary language for automated candidate messages and templates.",
                Icons.translate_rounded,
              ),
              const SizedBox(height: 14),
              _buildLanguageSelectorCard(context, provider),
              const SizedBox(height: 32),

              // Section 8: Test Communication
              _buildSectionHeader(
                theme,
                "Test Communication Channels",
                "Dispatch sample alerts to verify gateway connectivity and formatting.",
                Icons.send_to_mobile_rounded,
              ),
              const SizedBox(height: 14),
              _buildTestCommunicationCard(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelsGrid(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: provider.communicationChannels.map((chan) {
        return _buildChannelCard(context, provider, chan);
      }).toList(),
    );
  }

  Widget _buildChannelCard(
    BuildContext context,
    ProfileDataProvider provider,
    CommunicationChannelItem chan,
  ) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 450),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: chan.isEnabled
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                chan.icon,
                color: chan.isEnabled
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chan.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    chan.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Switch.adaptive(
              value: chan.isEnabled,
              onChanged: (val) {
                provider.toggleCommunicationChannel(chan.id, val);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${chan.name} channel ${val ? 'enabled' : 'disabled'} (Dummy action)",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateSettingsList(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return _buildSettingsList(
      context,
      provider.candidateCommunicationSettings,
      (id, val) => provider.toggleCandidateCommunicationSetting(id, val),
    );
  }

  Widget _buildTeamSettingsList(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return _buildSettingsList(
      context,
      provider.teamCommunicationSettings,
      (id, val) => provider.toggleTeamCommunicationSetting(id, val),
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    List<CommunicationSettingItem> items,
    Function(String, bool) onToggle,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (ctx, index) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 10,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _showPreviewDialog(context, item.title),
                      icon: const Icon(Icons.visibility_outlined, size: 16),
                      label: const Text("Preview"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        minimumSize: const Size(0, 34),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Switch.adaptive(
                      value: item.isEnabled,
                      onChanged: (val) {
                        onToggle(item.id, val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${item.title} ${val ? 'enabled' : 'disabled'} (Dummy action)",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAutomatedTemplatesSection(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: provider.automatedMessages.map((tmpl) {
        return _buildTemplateCard(context, provider, tmpl);
      }).toList(),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    ProfileDataProvider provider,
    AutomatedMessageTemplateItem tmpl,
  ) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 450),
      child: AppCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tmpl.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: tmpl.isEnabled,
                  onChanged: (val) {
                    provider.toggleAutomatedMessageTemplate(tmpl.id, val);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${tmpl.title} automated trigger ${val ? 'enabled' : 'disabled'} (Dummy action)",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tmpl.trigger,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.15),
                ),
              ),
              child: Text(
                tmpl.templateBody,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  height: 1.4,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _showEditTemplateDialog(context, provider, tmpl),
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text("Edit Template"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuietHoursCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quiet Hours Schedule",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Automatically suppress non-essential alerts during off-duty windows.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: provider.quietHoursEnabled,
                onChanged: (val) {
                  provider.updateQuietHours(enabled: val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Quiet hours ${val ? 'activated' : 'disabled'} (Dummy action)",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
          if (provider.quietHoursEnabled) ...[
            const SizedBox(height: 18),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _buildTimePickerBox(
                  context,
                  provider,
                  "Start Time",
                  provider.quietHoursStartTime,
                  true,
                ),
                _buildTimePickerBox(
                  context,
                  provider,
                  "End Time",
                  provider.quietHoursEndTime,
                  false,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timezone",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.public_rounded,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            provider.quietHoursTimezone,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "During Quiet Hours: Mute non-urgent communications",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              subtitle: const Text(
                "Urgent SLA escalations and interview cancellations will still bypass quiet hours.",
                style: TextStyle(fontSize: 12),
              ),
              value: provider.muteNonUrgentDuringQuietHours,
              onChanged: (val) {
                if (val != null) {
                  provider.updateQuietHours(muteNonUrgent: val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Non-urgent mute ${val ? 'enabled' : 'disabled'} (Dummy action)",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimePickerBox(
    BuildContext context,
    ProfileDataProvider provider,
    String label,
    String timeVal,
    bool isStart,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            final newTime = isStart
                ? (timeVal == "10:00 PM" ? "09:00 PM" : "10:00 PM")
                : (timeVal == "08:00 AM" ? "07:30 AM" : "08:00 AM");
            if (isStart) {
              provider.updateQuietHours(startTime: newTime);
            } else {
              provider.updateQuietHours(endTime: newTime);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$label updated to $newTime (Dummy action)",
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  timeVal,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSignatureCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Signature Preview",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showEditSignatureDialog(context, provider),
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text("Edit Signature"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.sigRecruiterName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  provider.sigDesignation,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.sigCompanyName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Divider(
                  height: 1,
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone_outlined,
                            size: 14, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Text(provider.sigPhone,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.language_rounded,
                            size: 14, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Text(provider.sigWebsite,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelectorCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final languages = [
      "English (United States)",
      "Hindi (India)",
      "Spanish (Spain)",
      "French (France)",
      "German (Germany)",
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: languages.map((lang) {
          final isSel = provider.communicationLanguage == lang;
          return ChoiceChip(
            label: Text(lang),
            selected: isSel,
            onSelected: (selected) {
              if (selected) {
                provider.updateCommunicationLanguage(lang);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Communication language set to $lang (Dummy action)",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTestCommunicationCard(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Test email dispatched to recruiter inbox (Dummy action)",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.email_rounded, size: 18),
            label: const Text("Send Test Email"),
          ),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Test SMS sent to verified phone number (Dummy action)",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.sms_rounded, size: 18),
            label: const Text("Send Test SMS"),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.teal.shade700,
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Test push notification triggered on active device (Dummy action)",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.notifications_active_rounded, size: 18),
            label: const Text("Send Test Notification"),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.indigo.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _showPreviewDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.preview_rounded),
            const SizedBox(width: 10),
            Expanded(child: Text("Preview: $title")),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sample Candidate / Team Notification Preview:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Hello [Recipient],\n\nThis is an automated preview of the \"$title\" communication channel from JobNest Recruitment Portal.\n\nBest regards,\nTalent Acquisition Team",
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showEditTemplateDialog(
    BuildContext context,
    ProfileDataProvider provider,
    AutomatedMessageTemplateItem tmpl,
  ) {
    final controller = TextEditingController(text: tmpl.templateBody);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Edit Template: ${tmpl.title}"),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available placeholders: {candidate_name}, {company_name}, {job_title}, {time}",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter message template text...",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              provider.updateAutomatedMessageTemplate(
                tmpl.id,
                controller.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${tmpl.title} template updated (Dummy action)",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Save Template"),
          ),
        ],
      ),
    );
  }

  void _showEditSignatureDialog(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final nameCtrl =
        TextEditingController(text: provider.sigRecruiterName);
    final desigCtrl =
        TextEditingController(text: provider.sigDesignation);
    final compCtrl =
        TextEditingController(text: provider.sigCompanyName);
    final phoneCtrl = TextEditingController(text: provider.sigPhone);
    final webCtrl = TextEditingController(text: provider.sigWebsite);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Edit Recruiter Email Signature"),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: "Recruiter Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: desigCtrl,
                  decoration: const InputDecoration(
                    labelText: "Designation",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: compCtrl,
                  decoration: const InputDecoration(
                    labelText: "Company Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: webCtrl,
                  decoration: const InputDecoration(
                    labelText: "Website URL",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              provider.updateEmailSignature(
                name: nameCtrl.text.trim(),
                designation: desigCtrl.text.trim(),
                company: compCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                website: webCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Email signature updated (Dummy action)",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Save Signature"),
          ),
        ],
      ),
    );
  }
}
