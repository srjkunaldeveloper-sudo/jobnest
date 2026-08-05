import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/constants/app_radius.dart';

class Step7Preview extends StatelessWidget {
  const Step7Preview({super.key});

  bool _isMissingRequiredFields(CreateJobProvider provider) {
    return provider.jobTitleController.text.trim().isEmpty ||
        provider.companyController.text.trim().isEmpty ||
        provider.departmentController.text.trim().isEmpty ||
        provider.employmentType.trim().isEmpty ||
        provider.experience.trim().isEmpty ||
        provider.positionsController.text.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();
    final isMissing = _isMissingRequiredFields(provider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: AppCard(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Review Job Requisition",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Review all details before publishing this requisition.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 1: Job Basics
                PreviewSection(
                  title: "Job Basics",
                  child: Column(
                    children: [
                      PreviewRow(label: "Posting Type", value: provider.postingType),
                      const Divider(height: 16),
                      PreviewRow(label: "Job Title", value: provider.jobTitleController.text),
                      const Divider(height: 16),
                      PreviewRow(label: "Company", value: provider.companyController.text),
                      const Divider(height: 16),
                      PreviewRow(label: "Department", value: provider.departmentController.text),
                      const Divider(height: 16),
                      PreviewRow(label: "Employment Type", value: provider.employmentType),
                      const Divider(height: 16),
                      PreviewRow(label: "Experience Level", value: provider.experience),
                      const Divider(height: 16),
                      PreviewRow(label: "Number of Positions", value: provider.positionsController.text),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 2: Location
                PreviewSection(
                  title: "Location",
                  child: Column(
                    children: [
                      PreviewRow(label: "Work Mode", value: provider.workMode),
                      if (provider.locations.isNotEmpty) ...[
                        const Divider(height: 16),
                        PreviewRow(
                          label: "Locations",
                          value: provider.locations.join(", "),
                        ),
                      ],
                      if (provider.workMode != "Remote" && provider.officeAddressController.text.trim().isNotEmpty) ...[
                        const Divider(height: 16),
                        PreviewRow(
                          label: "Office Address",
                          value: provider.officeAddressController.text,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 3: Job Details
                PreviewSection(
                  title: "Job Details",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (provider.descriptionController.text.trim().isNotEmpty) ...[
                        Text(
                          "Job Description",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.descriptionController.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                      ],
                      if (provider.responsibilitiesController.text.trim().isNotEmpty) ...[
                        Text(
                          "Responsibilities",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.responsibilitiesController.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                      ],
                      if (provider.requirementsController.text.trim().isNotEmpty) ...[
                        Text(
                          "Requirements",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.requirementsController.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        "Key Skills",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (provider.skills.isEmpty)
                        Text(
                          "No key skills specified.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: provider.skills.map((skill) {
                            return PreviewChip(label: skill);
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 4: Compensation
                PreviewSection(
                  title: "Compensation & Benefits",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PreviewRow(
                        label: "Salary Display",
                        value: provider.showSalary ? "Show on posting" : "Hidden",
                      ),
                      const Divider(height: 16),
                      PreviewRow(
                        label: "Salary Range",
                        value: "${provider.currency} ${provider.minimumSalaryController.text} - ${provider.maximumSalaryController.text}",
                      ),
                      const Divider(height: 16),
                      PreviewRow(label: "Salary Period", value: provider.salaryPeriod),
                      const Divider(height: 16),
                      Text(
                        "Employee Benefits",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (provider.selectedBenefits.isEmpty)
                        Text(
                          "No benefits selected.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: provider.selectedBenefits.map((benefit) {
                            return PreviewChip(label: benefit);
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 5: Application
                PreviewSection(
                  title: "Application Settings",
                  child: Column(
                    children: [
                      PreviewRow(label: "Application Method", value: provider.applicationMethod),
                      if (provider.applicationMethod == "External Website" && provider.externalUrlController.text.isNotEmpty) ...[
                        const Divider(height: 16),
                        PreviewRow(label: "External URL", value: provider.externalUrlController.text),
                      ] else if (provider.applicationMethod == "Email Application" && provider.applicationEmailController.text.isNotEmpty) ...[
                        const Divider(height: 16),
                        PreviewRow(label: "Recruitment Email", value: provider.applicationEmailController.text),
                      ],
                      const Divider(height: 16),
                      PreviewRow(
                        label: "Deadline Date",
                        value: provider.applicationDeadline != null
                            ? "${provider.applicationDeadline!.day}/${provider.applicationDeadline!.month}/${provider.applicationDeadline!.year}"
                            : "No deadline set",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SECTION 6: Additional Settings
                PreviewSection(
                  title: "Additional Settings",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PreviewRow(
                        label: "Relocation Assistance",
                        value: provider.relocationRequired ? "Required" : "Not Required",
                      ),
                      const Divider(height: 16),
                      PreviewRow(label: "Travel Requirement", value: provider.travelRequirement),
                      const Divider(height: 16),
                      PreviewRow(label: "Hiring Timeline", value: provider.hiringTimeline),
                      const Divider(height: 16),
                      PreviewRow(label: "Job Priority", value: provider.priority),
                      const Divider(height: 16),
                      PreviewRow(label: "Shift Type", value: provider.shiftType),
                      const Divider(height: 16),
                      PreviewRow(
                        label: "Working Hours",
                        value: "${provider.startTime?.format(context) ?? '9:00 AM'} - ${provider.endTime?.format(context) ?? '5:00 PM'}",
                      ),
                      const Divider(height: 16),
                      PreviewRow(label: "Recruiter Name", value: provider.recruiterNameController.text),
                      const Divider(height: 16),
                      PreviewRow(label: "Recruiter Email", value: provider.recruiterEmailController.text),
                      const Divider(height: 16),
                      PreviewRow(label: "Recruiter Phone", value: provider.recruiterPhoneController.text),
                      const Divider(height: 20),
                      Text(
                        "Pre-screening Questions",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      if (provider.screeningQuestions.isEmpty)
                        Text(
                          "No pre-screening questions added.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.screeningQuestions.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final question = provider.screeningQuestions[index];
                            return Card(
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: AppRadius.card,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "${index + 1}. $question",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // SECTION 7: Missing Information / Banner Message Display
                if (provider.bannerMessage != null || isMissing) ...[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                      borderRadius: AppRadius.card,
                      border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: theme.colorScheme.error,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.bannerMessage ?? "Some required information is still missing.",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.error,
                                ),
                              ),
                              Text(
                                "Complete all mandatory fields before publishing.",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // ACTION BUTTONS BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        provider.previousStep();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                      ),
                      child: const Text("Previous Step"),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            provider.validateDraft();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                          ),
                          child: const Text("Save Draft"),
                        ),
                        const SizedBox(width: 12),
                        FilledButton(
                          onPressed: () {
                            provider.validatePublish();
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                          ),
                          child: const Text("Publish Requisition"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PreviewSection extends StatelessWidget {
  final String title;
  final Widget child;

  const PreviewSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class PreviewRow extends StatelessWidget {
  final String label;
  final String value;

  const PreviewRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value.isNotEmpty ? value : "Not specified",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class PreviewChip extends StatelessWidget {
  final String label;

  const PreviewChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Chip(
      label: Text(
        label,
        style: theme.textTheme.bodySmall,
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
    );
  }
}
