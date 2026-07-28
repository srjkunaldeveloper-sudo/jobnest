import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';

class Step4Requirements extends StatelessWidget {
  const Step4Requirements({super.key});

  static bool validateCurrentStep(BuildContext context) {
    return context.read<JobFormProvider>().validateStep(3);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final form = context.watch<JobFormProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Requirements",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Define the candidate profile for this role.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          _buildSingleSelectChipGroup(
            context,
            "Experience",
            ["Fresher", "1-3 Years", "3-5 Years", "5-8 Years", "8+ Years"],
            form.experience,
            (val) => form.setExperience(val),
          ),
          AppSpacing.h24,
          
          _buildMultiSelectChipGroup(
            context,
            "Education",
            ["High School", "Bachelor's", "Master's", "PhD", "Any"],
            form.education,
            (val) => form.toggleEducation(val),
          ),
          AppSpacing.h24,
          
          _buildMultiSelectChipGroup(
            context,
            "Notice Period",
            ["Immediate", "15 Days", "30 Days", "60 Days", "90 Days"],
            form.noticePeriod,
            (val) => form.toggleNoticePeriod(val),
          ),
          AppSpacing.h24,

          _buildMultiSelectChipGroup(
            context,
            "Top Skills",
            ["Flutter", "Dart", "Firebase", "REST APIs", "UI/UX", "Git", "Figma", "Agile"],
            form.skills,
            (val) => form.toggleSkill(val),
          ),
          AppSpacing.h24,

          _buildMultiSelectChipGroup(
            context,
            "Languages",
            ["English", "Hindi", "Spanish", "French", "German"],
            form.languages,
            (val) => form.toggleLanguage(val),
          ),
          AppSpacing.h24,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Maximum Applicants (Optional)",
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              AppSpacing.h8,
              TextFormField(
                controller: form.maxApplicantsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "e.g. 500",
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSingleSelectChipGroup(
    BuildContext context,
    String label,
    List<String> options,
    String selectedValue,
    ValueChanged<String> onSelected,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h12,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((text) {
            bool isSelected = selectedValue == text;
            return FilterChip(
              label: Text(text),
              selected: isSelected,
              onSelected: (_) => onSelected(text),
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              checkmarkColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMultiSelectChipGroup(
    BuildContext context,
    String label,
    List<String> options,
    List<String> selectedValues,
    ValueChanged<String> onSelected,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h12,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((text) {
            bool isSelected = selectedValues.contains(text);
            return FilterChip(
              label: Text(text),
              selected: isSelected,
              onSelected: (_) => onSelected(text),
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              checkmarkColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
