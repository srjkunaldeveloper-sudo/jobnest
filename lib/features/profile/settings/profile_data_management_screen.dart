import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileDataManagementScreen extends StatefulWidget {
  const ProfileDataManagementScreen({super.key});

  @override
  State<ProfileDataManagementScreen> createState() =>
      _ProfileDataManagementScreenState();
}

class _ProfileDataManagementScreenState
    extends State<ProfileDataManagementScreen> {
  String _selectedExportFormat = "PDF (.pdf)";

  final List<String> _exportFormats = [
    "PDF (.pdf)",
    "Excel (.xlsx)",
    "CSV (.csv)",
    "JSON (.json)",
  ];

  final List<String> _retentionOptions = [
    "30 Days",
    "90 Days",
    "180 Days",
    "1 Year",
    "Never",
  ];

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Export account data.

    // TODO:
    // Import backup.

    // TODO:
    // Backup scheduler.

    // TODO:
    // Storage API.

    // TODO:
    // Data retention policy.

    // TODO:
    // GDPR / Privacy compliance.

    // TODO:
    // Cloud backup integration.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Management & Storage"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              provider.toggleBackupEmptyState();
              _showFeedback(
                context,
                provider.isBackupEmpty
                    ? "Switched to QA Empty Backup State"
                    : "Restored QA Populated Backup State",
              );
            },
            icon: Icon(
              provider.isBackupEmpty
                  ? AppIcons.cloud_off_rounded
                  : AppIcons.cloud_done_rounded,
              color: provider.isBackupEmpty
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
            tooltip: "Toggle Empty Backup State (QA)",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Data Overview
                _buildSectionHeader(
                  theme,
                  "Enterprise Data Overview",
                  "Live metrics of your recruitment assets, database footprint, and cloud archives.",
                  AppIcons.analytics_outlined,
                ),
                const SizedBox(height: 14),
                _buildDataOverviewCard(context, provider),
                const SizedBox(height: 32),

                // Section 2: Storage Management
                _buildSectionHeader(
                  theme,
                  "Storage Management & Allocation",
                  "Monitor server storage consumption and asset breakdown across your organization.",
                  AppIcons.storage_rounded,
                ),
                const SizedBox(height: 14),
                _buildStorageManagementCard(context, provider),
                const SizedBox(height: 32),

                // Section 3: Backup & Restore
                _buildSectionHeader(
                  theme,
                  "Cloud Backup & Disaster Recovery",
                  "Create point-in-time snapshots of your hiring pipelines and restore archived states.",
                  AppIcons.backup_outlined,
                ),
                const SizedBox(height: 14),
                _buildBackupRestoreCard(context, provider),
                const SizedBox(height: 32),

                // Section 4: Export Data
                _buildSectionHeader(
                  theme,
                  "Data Export & Portability",
                  "Export portable archives of your enterprise recruitment records in standard formats.",
                  AppIcons.download_rounded,
                ),
                const SizedBox(height: 14),
                _buildExportDataCard(context),
                const SizedBox(height: 32),

                // Section 5: Data Retention Policies
                _buildSectionHeader(
                  theme,
                  "Automated Data Retention Policies",
                  "Configure lifecycle rules for purging old applications and archiving closed requisitions.",
                  AppIcons.auto_delete_outlined,
                ),
                const SizedBox(height: 14),
                _buildRetentionCard(context, provider),
                const SizedBox(height: 32),

                // Section 6: Privacy & GDPR Controls
                _buildSectionHeader(
                  theme,
                  "Privacy & Compliance Controls (GDPR)",
                  "Manage telemetry collection, anonymized diagnostics, and product usage statistics.",
                  AppIcons.privacy_tip_outlined,
                ),
                const SizedBox(height: 14),
                _buildPrivacyControlsCard(context, provider),
                const SizedBox(height: 32),

                // Section 7: Download Center
                _buildSectionHeader(
                  theme,
                  "Download Center",
                  "Access pre-compiled compliance reports, billing histories, and candidate summaries.",
                  AppIcons.folder_shared_outlined,
                ),
                const SizedBox(height: 14),
                _buildDownloadCenterCard(context),
                const SizedBox(height: 32),

                // Section 8: Account Data Tools
                _buildSectionHeader(
                  theme,
                  "Account Data Tools & Maintenance",
                  "Manage local device caches, request GDPR data copies, and purge temporary exports.",
                  AppIcons.build_circle_outlined,
                ),
                const SizedBox(height: 14),
                _buildAccountDataCard(context),
                const SizedBox(height: 36),

                // Section 9: Reset Options
                _buildSectionHeader(
                  theme,
                  "System Reset Options",
                  "Restore module configurations to factory defaults without affecting candidate data.",
                  AppIcons.restart_alt_rounded,
                ),
                const SizedBox(height: 14),
                _buildResetOptionsCard(context, provider),
                const SizedBox(height: 36),

                // Section 10: Danger Zone
                _buildSectionHeader(
                  theme,
                  "Danger Zone",
                  "Irreversible destructive operations that permanently purge records from servers.",
                  AppIcons.warning_amber_rounded,
                  isDanger: true,
                ),
                const SizedBox(height: 14),
                _buildDangerZoneCard(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon, {
    bool isDanger = false,
  }) {
    final color = isDanger ? theme.colorScheme.error : theme.colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDanger ? color : null,
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

  Widget _buildDataOverviewCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final items = [
      _OverviewMetric(
        title: "Total Jobs",
        value: "48",
        subtitle: "Active & archived requisitions",
        icon: AppIcons.work_outline_rounded,
        color: Colors.blue,
      ),
      _OverviewMetric(
        title: "Total Candidates",
        value: "1,240",
        subtitle: "In talent pipeline database",
        icon: AppIcons.people_alt_outlined,
        color: Colors.purple,
      ),
      _OverviewMetric(
        title: "Interviews Logged",
        value: "156",
        subtitle: "Completed scorecard sessions",
        icon: AppIcons.calendar_today_rounded,
        color: Colors.amber.shade700,
      ),
      _OverviewMetric(
        title: "Team Members",
        value: "12",
        subtitle: "Licensed recruiters & HR",
        icon: AppIcons.group_outlined,
        color: Colors.green,
      ),
      _OverviewMetric(
        title: "Storage Used",
        value: "3.4 GB",
        subtitle: "Of 10.0 GB enterprise quota",
        icon: AppIcons.cloud_done_outlined,
        color: Colors.teal,
      ),
      _OverviewMetric(
        title: "Last Cloud Backup",
        value: provider.isBackupEmpty ? "None" : "2 hrs ago",
        subtitle: provider.isBackupEmpty
            ? "No backups recorded"
            : provider.lastBackupDate,
        icon: AppIcons.backup_outlined,
        color: provider.isBackupEmpty ? theme.colorScheme.error : Colors.indigo,
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: items.map((item) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 460),
          child: AppCard(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.color, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.value,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStorageManagementCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AppIcons.pie_chart_outline_rounded,
                      color: theme.colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "3.4 GB Used of 10.0 GB Total (34% Consumed)",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  "6.6 GB Available",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 12,
              child: Row(
                children: [
                  Expanded(
                    flex: 19,
                    child: Container(color: theme.colorScheme.primary),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(color: Colors.blue),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(color: Colors.amber.shade700),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(color: Colors.teal),
                  ),
                  Expanded(
                    flex: 66,
                    child: Container(
                        color: theme.colorScheme.surfaceContainerHighest),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            "Storage Allocation Breakdown:",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _buildStorageBarItem(
                context,
                "Candidate Resumes & CVs",
                "1.9 GB (19%)",
                0.19,
                theme.colorScheme.primary,
              ),
              _buildStorageBarItem(
                context,
                "Company Files & Assets",
                "0.8 GB (8%)",
                0.08,
                Colors.blue,
              ),
              _buildStorageBarItem(
                context,
                "Branding Images & Logos",
                "0.4 GB (4%)",
                0.04,
                Colors.amber.shade700,
              ),
              _buildStorageBarItem(
                context,
                "Contracts & Compliance Docs",
                "0.3 GB (3%)",
                0.03,
                Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageBarItem(
    BuildContext context,
    String label,
    String val,
    double percent,
    Color color,
  ) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 420),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(label,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              Text(val,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent * (100 / 34), // Relative to used capacity
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupRestoreCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    if (provider.isBackupEmpty) {
      return AppCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(AppIcons.cloud_off_rounded,
                  size: 40, color: theme.colorScheme.error),
            ),
            const SizedBox(height: 16),
            Text(
              "No Backups Available",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Your enterprise recruitment data currently has no cloud restore points created. Configure regular snapshots to prevent accidental data loss.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                provider.toggleBackupEmptyState();
                _showFeedback(context, "Initial backup archive created successfully!");
              },
              icon: const Icon(AppIcons.cloud_upload_rounded),
              label: const Text("Create First Backup"),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      );
    }

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 14,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(AppIcons.cloud_done_rounded,
                        color: Colors.green, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cloud Backup: ${provider.backupStatusLabel}",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Last backup completed: ${provider.lastBackupDate}",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Schedule Frequency:",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3)),
                    ),
                    child: DropdownButton<String>(
                      value: provider.backupFrequency,
                      underline: const SizedBox(),
                      icon: const Icon(AppIcons.arrow_drop_down_rounded),
                      items: ["Daily", "Weekly", "Monthly", "Manual Only"]
                          .map((f) => DropdownMenuItem(
                                value: f,
                                child: Text(f,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          provider.updateBackupFrequency(val);
                          _showFeedback(
                              context, "Backup schedule updated to $val");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () {
                  _showFeedback(context, "Initiating immediate cloud backup snapshot...");
                },
                icon: const Icon(AppIcons.backup_rounded, size: 18),
                label: const Text("Create New Backup"),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _showConfirmDialog(
                    context,
                    "Restore Cloud Backup",
                    "Are you sure you want to restore the system state from the last backup (${provider.lastBackupDate})? Any unsaved edits since then will be overwritten.",
                    "Restore Archive",
                    () {
                      _showFeedback(context, "System successfully restored from archive");
                    },
                  );
                },
                icon: const Icon(AppIcons.restore_rounded, size: 18),
                label: const Text("Restore Backup"),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _showFeedback(context, "Downloading backup archive (jobnest_backup_2026.zip)");
                },
                icon: const Icon(AppIcons.download_rounded, size: 18),
                label: const Text("Download Backup"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportDataCard(BuildContext context) {
    final theme = Theme.of(context);
    final exports = [
      "Export Recruiter Profile",
      "Export Company Information",
      "Export Job Requisitions",
      "Export Candidate Pipeline",
      "Export Team Member Roster",
      "Export Complete Account Archive",
    ];

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Text(
                "Select Export Target File Format:",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8,
                children: _exportFormats.map((format) {
                  final isSelected = _selectedExportFormat == format;
                  return ChoiceChip(
                    label: Text(format,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal)),
                    selected: isSelected,
                    onSelected: (sel) {
                      if (sel) setState(() => _selectedExportFormat = format);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exports.length,
            separatorBuilder: (ctx, i) => Divider(
                height: 20,
                color: theme.colorScheme.outline.withValues(alpha: 0.1)),
            itemBuilder: (context, index) {
              final title = exports[index];
              final isFull = title.contains("Complete Account");
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isFull
                            ? AppIcons.folder_zip_rounded
                            : AppIcons.insert_drive_file_outlined,
                        size: 20,
                        color: isFull
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight:
                              isFull ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showFeedback(context, "Exporting '$title' as $_selectedExportFormat");
                    },
                    icon: const Icon(AppIcons.download_rounded, size: 16),
                    label: Text("Export ${_selectedExportFormat.split(' ')[0]}"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      minimumSize: const Size(0, 36),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRetentionCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildRetentionRow(
            context,
            "Keep Candidate Profiles & Resumes",
            "Duration to retain inactive candidate data before anonymization.",
            provider.retentionCandidateData,
            (val) => provider.updateDataRetentionPolicy(candidateData: val),
          ),
          const Divider(height: 24),
          _buildRetentionRow(
            context,
            "Keep Job Requisition Records",
            "Duration to retain historical job specs and audit logs.",
            provider.retentionJobData,
            (val) => provider.updateDataRetentionPolicy(jobData: val),
          ),
          const Divider(height: 24),
          _buildRetentionRow(
            context,
            "Archive Closed Job Postings",
            "Automatically move filled or cancelled requisitions to cold storage.",
            provider.retentionClosedJobs,
            (val) => provider.updateDataRetentionPolicy(closedJobs: val),
          ),
          const Divider(height: 24),
          _buildRetentionRow(
            context,
            "Archive Rejected Candidates",
            "Move disqualified candidate applications out of active pipeline views.",
            provider.retentionRejectedCandidates,
            (val) => provider.updateDataRetentionPolicy(rejectedCandidates: val),
          ),
          const Divider(height: 24),
          _buildRetentionRow(
            context,
            "Auto-Delete Expired Audit Records",
            "Permanently purge system activity logs older than specified threshold.",
            provider.retentionAutoDeleteOld,
            (val) => provider.updateDataRetentionPolicy(autoDelete: val),
          ),
        ],
      ),
    );
  }

  Widget _buildRetentionRow(
    BuildContext context,
    String title,
    String subtitle,
    String currentVal,
    Function(String) onChanged,
  ) {
    final theme = Theme.of(context);
    return Wrap(
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
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          ),
          child: DropdownButton<String>(
            value: currentVal,
            underline: const SizedBox(),
            icon: const Icon(AppIcons.arrow_drop_down_rounded),
            items: _retentionOptions
                .map((opt) => DropdownMenuItem(
                      value: opt,
                      child: Text(opt,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                onChanged(val);
                _showFeedback(context, "Retention rule updated to '$val'");
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyControlsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final controls = [
      _PrivacyItem(
        key: 'analytics',
        title: "Analytics Collection",
        description:
            "Allow JobNest to collect anonymized telemetry on recruitment workflow speed and efficiency.",
        val: provider.dataAnalyticsCollection,
      ),
      _PrivacyItem(
        key: 'usage',
        title: "Product Usage Statistics",
        description:
            "Share aggregated feature usage diagnostics to help improve recruiter user experience.",
        val: provider.dataUsageStatistics,
      ),
      _PrivacyItem(
        key: 'crash',
        title: "Automated Crash Reporting",
        description:
            "Send stack traces and error diagnostics automatically when an unexpected system fault occurs.",
        val: provider.dataCrashReports,
      ),
      _PrivacyItem(
        key: 'suggestions',
        title: "Personalized AI Suggestions",
        description:
            "Allow local AI models to analyze requisition titles to suggest matching skill tags and candidates.",
        val: provider.dataPersonalizedSuggestions,
      ),
      _PrivacyItem(
        key: 'anonymous',
        title: "Anonymous Enterprise Improvement Program",
        description:
            "Contribute anonymized hiring velocity benchmarks to the global JobNest recruiter index.",
        val: provider.dataAnonymousImprovement,
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controls.length,
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = controls[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 8,
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
                Switch.adaptive(
                  value: item.val,
                  onChanged: (newVal) {
                    provider.toggleDataPrivacyControl(item.key, newVal);
                    _showFeedback(
                      context,
                      "${item.title} ${newVal ? 'enabled' : 'disabled'}",
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDownloadCenterCard(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      _DownloadItem(
          title: "Company Overview Report",
          filename: "company_overview_report.pdf",
          size: "1.2 MB",
          icon: AppIcons.picture_as_pdf_rounded,
          color: Colors.red),
      _DownloadItem(
          title: "Q2 Recruitment Diagnostics Report",
          filename: "q2_hiring_diagnostics.xlsx",
          size: "840 KB",
          icon: AppIcons.table_chart_rounded,
          color: Colors.green),
      _DownloadItem(
          title: "Complete Candidate Pipeline Summary",
          filename: "talent_pipeline_summary.csv",
          size: "2.4 MB",
          icon: AppIcons.insert_drive_file_rounded,
          color: Colors.blue),
      _DownloadItem(
          title: "Enterprise Billing History & Invoices",
          filename: "invoices_archive_2026.pdf",
          size: "3.1 MB",
          icon: AppIcons.receipt_long_rounded,
          color: Colors.purple),
      _DownloadItem(
          title: "Verification & Trust Compliance Badge",
          filename: "trust_verification_badge.pdf",
          size: "520 KB",
          icon: AppIcons.verified_rounded,
          color: Colors.teal),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (ctx, i) => Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15)),
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: item.color, size: 22),
                      ),
                      const SizedBox(width: 14),
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
                              "${item.filename}  •  ${item.size}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () {
                    _showFeedback(
                        context, "Downloading '${item.filename}' (${item.size})");
                  },
                  icon: const Icon(AppIcons.download_rounded, size: 18),
                  tooltip: "Download ${item.title}",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountDataCard(BuildContext context) {
    final theme = Theme.of(context);
    final tools = [
      _DataTool(
        title: "Request GDPR Complete Data Copy",
        description:
            "Generate an exhaustive, downloadable archive containing all personal info, login logs, and scorecard notes.",
        btnLabel: "Request Copy",
        icon: AppIcons.assignment_returned_outlined,
        onAction: () => _showFeedback(context, "GDPR Data Copy request queued. You will receive an email link shortly."),
      ),
      _DataTool(
        title: "Delete Downloaded Export Archives",
        description:
            "Purge temporary export archives and compiled spreadsheet packages generated on server storage.",
        btnLabel: "Delete Exports",
        icon: AppIcons.delete_sweep_outlined,
        onAction: () => _showFeedback(context, "All temporary export archives purged from server storage."),
      ),
      _DataTool(
        title: "Manage Cold Archived Requisitions",
        description:
            "Review closed job postings in cold storage or permanently remove them from the enterprise database.",
        btnLabel: "Manage Archive",
        icon: AppIcons.inventory_2_outlined,
        onAction: () => _showFeedback(context, "Opening cold storage archive explorer..."),
      ),
      _DataTool(
        title: "Clear Local Device Cache",
        description:
            "Clear temporary image thumbnails, resume previews, and offline search indexes from this device.",
        btnLabel: "Clear Cache",
        icon: AppIcons.layers_clear_outlined,
        onAction: () => _showFeedback(context, "Local device cache cleared successfully (142 MB freed)."),
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tools.length,
        separatorBuilder: (ctx, i) => Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15)),
        itemBuilder: (context, index) {
          final tool = tools[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(tool.icon,
                        color: theme.colorScheme.primary, size: 24),
                    const SizedBox(width: 14),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tool.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            tool.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: tool.onAction,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Text(tool.btnLabel),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResetOptionsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildResetRow(
            context,
            "Reset Job Hiring Preferences",
            "Restore default salary currencies, experience levels, and hiring workflow toggles.",
            "Reset Jobs",
            () {
              _showConfirmDialog(
                context,
                "Reset Job Preferences",
                "Are you sure you want to reset all job hiring preferences to factory defaults?",
                "Reset Preferences",
                () {
                  provider.resetJobPreferencesToDefault();
                  _showFeedback(
                      context, "Job preferences reset to factory defaults");
                },
              );
            },
          ),
          Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          _buildResetRow(
            context,
            "Reset Communication Settings",
            "Restore default notification channels and candidate automated message templates.",
            "Reset Communications",
            () {
              _showConfirmDialog(
                context,
                "Reset Communication Settings",
                "Are you sure you want to restore all communication channels and email templates to default?",
                "Reset Communications",
                () {
                  _showFeedback(context,
                      "Communication settings reset to defaults (Dummy action)");
                },
              );
            },
          ),
          Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          _buildResetRow(
            context,
            "Reset Notification Preferences",
            "Restore default push, email, and SMS alert frequencies for application updates.",
            "Reset Notifications",
            () {
              _showConfirmDialog(
                context,
                "Reset Notification Preferences",
                "Are you sure you want to reset all alert notification toggles to default?",
                "Reset Notifications",
                () {
                  _showFeedback(context,
                      "Notification preferences reset to defaults (Dummy action)");
                },
              );
            },
          ),
          Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          _buildResetRow(
            context,
            "Reset Theme & Appearance",
            "Restore default light/dark mode schedules, typography scaling, and language.",
            "Reset Theme",
            () {
              _showConfirmDialog(
                context,
                "Reset Theme & Appearance",
                "Are you sure you want to revert app appearance settings to system default?",
                "Reset Appearance",
                () {
                  _showFeedback(
                      context, "Theme and appearance reset to system default");
                },
              );
            },
          ),
          Divider(
              height: 24,
              color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          _buildResetRow(
            context,
            "Restore All Default System Settings",
            "Revert all profile customizations, preferences, and privacy rules to factory defaults in one step.",
            "Restore All Defaults",
            () {
              _showConfirmDialog(
                context,
                "Restore All Default Settings",
                "WARNING: This will reset all recruiter settings, job templates, communication rules, and data retention policies to factory defaults. Your candidate and job records will remain intact.",
                "Restore All Defaults",
                () {
                  provider.restoreDefaults();
                  _showFeedback(context,
                      "All profile settings successfully restored to factory defaults");
                },
                isDestructive: true,
              );
            },
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildResetRow(
    BuildContext context,
    String title,
    String subtitle,
    String btnLabel,
    VoidCallback onReset, {
    bool isPrimary = false,
  }) {
    final theme = Theme.of(context);
    return Wrap(
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
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPrimary ? theme.colorScheme.primary : null,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (isPrimary)
          FilledButton.tonal(
            onPressed: onReset,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
            child: Text(btnLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        else
          OutlinedButton(
            onPressed: onReset,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
            child: Text(btnLabel),
          ),
      ],
    );
  }

  Widget _buildDangerZoneCard(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: errorColor.withValues(alpha: 0.4), width: 1.5),
          color: errorColor.withValues(alpha: 0.05),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(AppIcons.delete_forever_rounded, color: errorColor, size: 26),
                const SizedBox(width: 10),
                Text(
                  "Permanent Enterprise Data Deletion",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: errorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "The following operations will permanently purge records from JobNest cloud servers. Once deleted, data cannot be recovered even from cloud backup snapshots.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: errorColor.withValues(alpha: 0.2)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Delete All Recruiter Activity Data",
                      "Are you sure you want to delete all personal recruiter activity logs, scorecard notes, and saved search filters? Candidate records will remain attached to the company.",
                      "Delete Recruiter Data",
                      () {
                        _showFeedback(context,
                            "Recruiter activity data deletion scheduled (Dummy action)");
                      },
                      isDestructive: true,
                    );
                  },
                  icon: Icon(AppIcons.person_remove_rounded,
                      color: errorColor, size: 18),
                  label: Text("Delete All Recruiter Data",
                      style: TextStyle(color: errorColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: errorColor),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Delete Company Information & Assets",
                      "WARNING: This will permanently delete company branding profiles, office photos, cover images, and verified employer badges. Only authorized organization admins can perform this action.",
                      "Delete Company Data",
                      () {
                        _showFeedback(context,
                            "Company assets deletion scheduled (Dummy action)");
                      },
                      isDestructive: true,
                    );
                  },
                  icon: Icon(AppIcons.business_rounded,
                      color: errorColor, size: 18),
                  label: Text("Delete Company Data",
                      style: TextStyle(color: errorColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: errorColor),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    _showConfirmDialog(
                      context,
                      "Permanent Account Deletion",
                      "EXTREME DANGER: This action cannot be undone. Your entire enterprise recruiter account, billing subscriptions, active requisitions, and candidate pipelines will be permanently destroyed.",
                      "Delete Account Permanently",
                      () {
                        _showFeedback(context,
                            "Permanent account deletion initiated (Dummy action)");
                      },
                      isDestructive: true,
                    );
                  },
                  icon: const Icon(AppIcons.delete_forever_rounded, size: 18),
                  label: const Text(
                    "Delete Account Permanently",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: errorColor,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message (Dummy action)"),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    String title,
    String content,
    String confirmLabel,
    VoidCallback onConfirm, {
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            style: isDestructive
                ? FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}

class _OverviewMetric {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  _OverviewMetric({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class _PrivacyItem {
  final String key;
  final String title;
  final String description;
  final bool val;

  _PrivacyItem({
    required this.key,
    required this.title,
    required this.description,
    required this.val,
  });
}

class _DownloadItem {
  final String title;
  final String filename;
  final String size;
  final IconData icon;
  final Color color;

  _DownloadItem({
    required this.title,
    required this.filename,
    required this.size,
    required this.icon,
    required this.color,
  });
}

class _DataTool {
  final String title;
  final String description;
  final String btnLabel;
  final IconData icon;
  final VoidCallback onAction;

  _DataTool({
    required this.title,
    required this.description,
    required this.btnLabel,
    required this.icon,
    required this.onAction,
  });
}
