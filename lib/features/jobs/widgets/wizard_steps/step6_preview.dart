import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';

class Step6Preview extends StatelessWidget {
  const Step6Preview({super.key});

  static bool validateCurrentStep(BuildContext context) {
    return context.read<JobFormProvider>().validateStep(5);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final form = context.watch<JobFormProvider>();

    final title = form.jobTitleController.text.trim().isEmpty
        ? "Untitled Requisition"
        : form.jobTitleController.text.trim();
    final company = form.companyController.text.trim().isEmpty
        ? "JobNest Inc."
        : form.companyController.text.trim();
    final location = form.locationController.text.trim().isEmpty
        ? "Remote"
        : form.locationController.text.trim();

    final chipList = <String>[
      ...form.skills,
      if (form.experience.isNotEmpty) form.experience,
      ...form.education,
      ...form.noticePeriod,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review & Publish",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Please review the job details before making it live.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          AppCard(
            padding: const EdgeInsets.all(24),
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
                            title,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          AppSpacing.h4,
                          Text(
                            "$company • $location",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (form.isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, size: 16, color: Colors.redAccent),
                            const SizedBox(width: 4),
                            Text(
                              "Urgent",
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                AppSpacing.h24,
                
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildIconLabel(context, Icons.work_rounded, form.employmentType),
                    _buildIconLabel(context, Icons.laptop_mac_rounded, form.workMode),
                    _buildIconLabel(context, Icons.monetization_on_rounded, form.formattedSalary),
                  ],
                ),
                AppSpacing.h24,
                const Divider(),
                AppSpacing.h24,
                
                Text(
                  "Requirements & Profile",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h12,
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (chipList.isEmpty ? ["General Qualifications"] : chipList)
                      .map((chip) => _buildChip(context, chip))
                      .toList(),
                ),
                AppSpacing.h24,
                
                Text(
                  "Responsibilities",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h8,
                Text(
                  form.responsibilitiesController.text.trim().isEmpty
                      ? "General role responsibilities."
                      : form.responsibilitiesController.text.trim(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (form.requirementsController.text.trim().isNotEmpty) ...[
                  AppSpacing.h24,
                  Text(
                    "Qualifications",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  AppSpacing.h8,
                  Text(
                    form.requirementsController.text.trim(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildIconLabel(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        AppSpacing.w8,
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
