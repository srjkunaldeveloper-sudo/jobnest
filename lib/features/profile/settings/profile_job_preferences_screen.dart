import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';

class ProfileJobPreferencesScreen extends StatelessWidget {
  const ProfileJobPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch recruiter preferences.

    // TODO:
    // Update recruiter preferences.

    // TODO:
    // Apply defaults during job creation.

    // TODO:
    // Sync preferences across devices.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Preferences"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => provider.toggleJobPreferencesEmptyState(),
            icon: Icon(
              provider.isJobPreferencesEmpty
                  ? AppIcons.work_off_rounded
                  : AppIcons.work_outline_rounded,
              color: provider.isJobPreferencesEmpty
                  ? theme.colorScheme.error
                  : null,
            ),
            tooltip: provider.isJobPreferencesEmpty
                ? "Restore Configured Preferences"
                : "Simulate Unconfigured / Empty State",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: provider.isJobPreferencesEmpty
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
                    AppIcons.work_off_rounded,
                    size: 56,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Configure your hiring preferences to speed up job creation.",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Establish reusable default templates for employment types, salary ranges, preferred hiring locations, required skills, and interview durations to streamline requisition publishing.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: () {
                    provider.toggleJobPreferencesEmptyState();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Hiring preferences initialized (Dummy action)",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(AppIcons.tune_rounded),
                  label: const Text(
                    "Set Preferences",
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
              // Section 1: Default Job Settings
              _buildSectionHeader(
                theme,
                "Default Job Settings",
                "Configure baseline classification values pre-populated when drafting new requisitions.",
                AppIcons.work_history_outlined,
              ),
              const SizedBox(height: 14),
              _buildDefaultJobSettingsCard(context, provider),
              const SizedBox(height: 32),

              // Section 2: Default Salary Structure
              _buildSectionHeader(
                theme,
                "Default Salary Structure",
                "Set standard compensation brackets, currency, and payout frequency.",
                AppIcons.payments_outlined,
              ),
              const SizedBox(height: 14),
              _buildDefaultSalaryCard(context, provider),
              const SizedBox(height: 32),

              // Section 3: Default Skills Required
              _buildSectionHeader(
                theme,
                "Default Skills Required",
                "Maintain reusable technical and professional competency tags for candidate matching.",
                AppIcons.psychology_outlined,
              ),
              const SizedBox(height: 14),
              _buildDefaultSkillsCard(context, provider),
              const SizedBox(height: 32),

              // Section 4: Preferred Hiring Locations
              _buildSectionHeader(
                theme,
                "Preferred Hiring Locations",
                "Specify target cities and geographic regions for talent sourcing.",
                AppIcons.location_on_outlined,
              ),
              const SizedBox(height: 14),
              _buildPreferredLocationsCard(context, provider),
              const SizedBox(height: 32),

              // Section 5: Hiring Workflow Settings
              _buildSectionHeader(
                theme,
                "Hiring Workflow Settings",
                "Automate requisition archiving, application gates, and duplicate candidate checks.",
                AppIcons.rule_rounded,
              ),
              const SizedBox(height: 14),
              _buildHiringWorkflowSettingsCard(context, provider),
              const SizedBox(height: 32),

              // Section 6: Interview Defaults
              _buildSectionHeader(
                theme,
                "Interview Defaults",
                "Set preferred session format and standard duration for candidate scheduling.",
                AppIcons.event_available_outlined,
              ),
              const SizedBox(height: 14),
              _buildInterviewDefaultsCard(context, provider),
              const SizedBox(height: 32),

              // Section 7: Default Job Visibility
              _buildSectionHeader(
                theme,
                "Default Job Visibility",
                "Control default exposure level across public boards and internal portals.",
                AppIcons.visibility_outlined,
              ),
              const SizedBox(height: 14),
              _buildJobVisibilityCard(context, provider),
              const SizedBox(height: 36),

              // Section 8: Save & Reset Actions
              _buildSaveResetActions(context, provider),
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

  Widget _buildDefaultJobSettingsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final employmentTypes = [
      "Full-Time",
      "Part-Time",
      "Internship",
      "Contract",
      "Temporary",
      "Freelance",
    ];
    final workplaceTypes = ["On-site", "Remote", "Hybrid"];
    final experienceLevels = [
      "Fresher",
      "1–2 Years",
      "3–5 Years",
      "5–8 Years",
      "8+ Years",
    ];
    final educationReqs = [
      "Bachelor's Degree / B.Tech",
      "Master's Degree / M.Tech",
      "Diploma / Certification",
      "Any Graduate",
    ];
    final noticePeriods = [
      "Immediate",
      "15 Days",
      "30 Days or Immediate",
      "60 Days",
      "90 Days",
    ];
    final hiringPriorities = [
      "Urgent",
      "High Priority",
      "Normal / Standard",
      "Low Priority",
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Default Employment Type",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: employmentTypes.map((type) {
              final isSel = provider.defaultEmploymentType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSel,
                onSelected: (val) {
                  if (val) {
                    provider.updateJobPreferenceDropdowns(employmentType: type);
                    _showFeedback(context, "Employment type set to $type");
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),

          Text(
            "Default Workplace Type",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: workplaceTypes.map((type) {
              final isSel = provider.defaultWorkplaceType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSel,
                onSelected: (val) {
                  if (val) {
                    provider.updateJobPreferenceDropdowns(workplaceType: type);
                    _showFeedback(context, "Workplace type set to $type");
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),

          Text(
            "Default Experience Level Required",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experienceLevels.map((lvl) {
              final isSel = provider.defaultExperienceLevel == lvl;
              return ChoiceChip(
                label: Text(lvl),
                selected: isSel,
                onSelected: (val) {
                  if (val) {
                    provider.updateJobPreferenceDropdowns(experienceLevel: lvl);
                    _showFeedback(context, "Experience level set to $lvl");
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),

          Wrap(
            spacing: 20,
            runSpacing: 16,
            children: [
              _buildDropdownSelector(
                context,
                "Default Education Requirement",
                provider.defaultEducationRequirement,
                educationReqs,
                (val) => provider.updateJobPreferenceDropdowns(educationReq: val),
              ),
              _buildDropdownSelector(
                context,
                "Default Notice Period",
                provider.defaultNoticePeriod,
                noticePeriods,
                (val) => provider.updateJobPreferenceDropdowns(noticePeriod: val),
              ),
              _buildDropdownSelector(
                context,
                "Default Hiring Priority",
                provider.defaultHiringPriority,
                hiringPriorities,
                (val) => provider.updateJobPreferenceDropdowns(hiringPriority: val),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSelector(
    BuildContext context,
    String label,
    String currentVal,
    List<String> options,
    Function(String) onChanged,
  ) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: options.contains(currentVal) ? currentVal : options.first,
                isExpanded: true,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (val) {
                  if (val != null) {
                    onChanged(val);
                    _showFeedback(context, "$label set to $val");
                  }
                },
                items: options.map((opt) {
                  return DropdownMenuItem<String>(
                    value: opt,
                    child: Text(opt),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSalaryCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final currencies = ["INR (₹)", "USD (\$)", "EUR (€)", "GBP (£)"];
    final salaryTypes = ["Monthly", "Annual"];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              _buildDropdownSelector(
                context,
                "Currency",
                provider.defaultSalaryCurrency,
                currencies,
                (val) => provider.updateJobPreferenceDropdowns(currency: val),
              ),
              _buildDropdownSelector(
                context,
                "Salary Type",
                provider.defaultSalaryType,
                salaryTypes,
                (val) => provider.updateJobPreferenceDropdowns(salaryType: val),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Compensation Range",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showEditSalaryDialog(context, provider),
                icon: const Icon(AppIcons.edit_outlined, size: 16),
                label: const Text("Edit Salary Range"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  AppIcons.account_balance_wallet_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider.defaultSalaryCurrency} ${provider.defaultMinSalary}  –  ${provider.defaultMaxSalary}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Default ${provider.defaultSalaryType.toLowerCase()} compensation bracket applied to new jobs.",
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
        ],
      ),
    );
  }

  Widget _buildDefaultSkillsCard(
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
                "Configured Skill Tags (${provider.defaultSkills.length})",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _showAddDialog(
                  context,
                  "Add Default Skill",
                  "Enter skill name (e.g. Kotlin, Docker, AWS)...",
                  (val) => provider.addDefaultSkill(val),
                ),
                icon: const Icon(AppIcons.add_rounded, size: 18),
                label: const Text("Add Skill"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (provider.defaultSkills.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "No default skills added. Click 'Add Skill' to configure.",
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.defaultSkills.map((skill) {
                return Chip(
                  label: Text(
                    skill,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  avatar: const Icon(AppIcons.code_rounded, size: 16),
                  onDeleted: () {
                    provider.removeDefaultSkill(skill);
                    _showFeedback(context, "Removed $skill from default skills");
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildPreferredLocationsCard(
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
                "Target Hiring Locations (${provider.defaultPreferredLocations.length})",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _showAddDialog(
                  context,
                  "Add Preferred Location",
                  "Enter city or region (e.g. Chennai, Gurgaon, Remote)...",
                  (val) => provider.addDefaultLocation(val),
                ),
                icon: const Icon(AppIcons.add_location_alt_rounded, size: 18),
                label: const Text("Add Location"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (provider.defaultPreferredLocations.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "No preferred locations added. Click 'Add Location' to configure.",
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.defaultPreferredLocations.map((loc) {
                return Chip(
                  label: Text(
                    loc,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  avatar: const Icon(AppIcons.location_city_rounded, size: 16),
                  onDeleted: () {
                    provider.removeDefaultLocation(loc);
                    _showFeedback(
                        context, "Removed $loc from preferred locations");
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildHiringWorkflowSettingsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final settings = [
      _WorkflowSettingItem(
        key: 'autoClose',
        title: "Auto Close Job on Expiry",
        description: "Automatically unpublish requisition when target hiring deadline is reached.",
        val: provider.autoCloseJob,
      ),
      _WorkflowSettingItem(
        key: 'autoArchive',
        title: "Auto Archive Filled Jobs",
        description: "Move requisition to archive immediately when all required seats are hired.",
        val: provider.autoArchiveFilledJobs,
      ),
      _WorkflowSettingItem(
        key: 'duplicateDetect',
        title: "Candidate Duplicate Detection",
        description: "Flag candidate profiles matching existing email or phone numbers across pipelines.",
        val: provider.candidateDuplicateDetection,
      ),
      _WorkflowSettingItem(
        key: 'reqResume',
        title: "Require Resume / CV Attachment",
        description: "Make resume document upload mandatory for all incoming applications.",
        val: provider.requireResume,
      ),
      _WorkflowSettingItem(
        key: 'reqCover',
        title: "Require Cover Letter",
        description: "Require candidate to submit a customized cover letter or introduction.",
        val: provider.requireCoverLetter,
      ),
      _WorkflowSettingItem(
        key: 'quickApply',
        title: "Enable Quick Apply Gate",
        description: "Allow candidates to apply in 1 click using their saved JobNest talent profile.",
        val: provider.enableQuickApply,
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settings.length,
        separatorBuilder: (ctx, index) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.15),
        ),
        itemBuilder: (context, index) {
          final item = settings[index];
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
                Switch.adaptive(
                  value: item.val,
                  onChanged: (newVal) {
                    provider.toggleHiringSetting(item.key, newVal);
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

  Widget _buildInterviewDefaultsCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final modes = ["Online", "Offline", "Hybrid"];
    final durations = ["15 Minutes", "30 Minutes", "45 Minutes", "60 Minutes"];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Default Interview Mode",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: modes.map((mode) {
              final isSel = provider.defaultInterviewMode == mode;
              return ChoiceChip(
                label: Text(mode),
                selected: isSel,
                onSelected: (val) {
                  if (val) {
                    provider.updateJobPreferenceDropdowns(interviewMode: mode);
                    _showFeedback(context, "Default interview mode set to $mode");
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 20),
          Text(
            "Default Interview Duration",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: durations.map((dur) {
              final isSel = provider.defaultInterviewDuration == dur;
              return ChoiceChip(
                label: Text(dur),
                selected: isSel,
                onSelected: (val) {
                  if (val) {
                    provider.updateJobPreferenceDropdowns(interviewDuration: dur);
                    _showFeedback(
                        context, "Default interview duration set to $dur");
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildJobVisibilityCard(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final visibilities = [
      _VisibilityOption(
        title: "Public",
        subtitle:
            "Visible on JobNest career portal, search engines, and partner job boards.",
        icon: AppIcons.public_rounded,
      ),
      _VisibilityOption(
        title: "Private",
        subtitle:
            "Unlisted. Accessible only via direct recruiter invitation or private application link.",
        icon: AppIcons.lock_outline_rounded,
      ),
      _VisibilityOption(
        title: "Internal",
        subtitle:
            "Restricted to verified company employees and internal mobility talent network.",
        icon: AppIcons.business_rounded,
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: visibilities.map((opt) {
        final isSel = provider.defaultJobVisibility == opt.title;
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 450),
          child: InkWell(
            onTap: () {
              provider.updateJobPreferenceDropdowns(jobVisibility: opt.title);
              _showFeedback(context, "Default job visibility set to ${opt.title}");
            },
            borderRadius: BorderRadius.circular(12),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSel
                      ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  border: isSel
                      ? Border.all(color: theme.colorScheme.primary, width: 2)
                      : null,
                ),
                child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSel
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      opt.icon,
                      color: isSel
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              opt.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSel ? theme.colorScheme.primary : null,
                              ),
                            ),
                            if (isSel) ...[
                              const SizedBox(width: 8),
                              Icon(
                                AppIcons.check_circle_rounded,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          opt.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveResetActions(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Text(
            "Save these configuration rules as your enterprise hiring template.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  provider.resetJobPreferencesToDefault();
                  _showFeedback(
                    context,
                    "Job preferences reset to factory defaults (Dummy action)",
                  );
                },
                icon: const Icon(AppIcons.restore_rounded, size: 18),
                label: const Text("Reset to Default"),
              ),
              FilledButton.icon(
                onPressed: () {
                  _showFeedback(
                    context,
                    "Job preferences saved successfully (Dummy action)",
                  );
                },
                icon: const Icon(AppIcons.check_circle_outline_rounded, size: 18),
                label: const Text(
                  "Save Preferences",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
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

  void _showAddDialog(
    BuildContext context,
    String title,
    String hint,
    Function(String) onAdd,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 400,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (val) {
              if (val.trim().isNotEmpty) {
                onAdd(val);
                Navigator.pop(ctx);
                _showFeedback(context, "Added '${val.trim()}'");
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onAdd(controller.text);
                Navigator.pop(ctx);
                _showFeedback(context, "Added '${controller.text.trim()}'");
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showEditSalaryDialog(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final minCtrl = TextEditingController(text: provider.defaultMinSalary);
    final maxCtrl = TextEditingController(text: provider.defaultMaxSalary);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Edit Default Salary Range"),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Minimum Salary (${provider.defaultSalaryCurrency})",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: maxCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Maximum Salary (${provider.defaultSalaryCurrency})",
                  border: const OutlineInputBorder(),
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
              provider.updateDefaultSalaryRange(
                minCtrl.text.trim().isEmpty ? "0" : minCtrl.text.trim(),
                maxCtrl.text.trim().isEmpty ? "0" : maxCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              _showFeedback(context, "Salary range updated successfully");
            },
            child: const Text("Update Range"),
          ),
        ],
      ),
    );
  }
}

class _WorkflowSettingItem {
  final String key;
  final String title;
  final String description;
  final bool val;

  _WorkflowSettingItem({
    required this.key,
    required this.title,
    required this.description,
    required this.val,
  });
}

class _VisibilityOption {
  final String title;
  final String subtitle;
  final IconData icon;

  _VisibilityOption({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
