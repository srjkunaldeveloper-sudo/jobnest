import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';

class Step1BasicDetails extends StatelessWidget {
  const Step1BasicDetails({super.key});

  static bool validateCurrentStep(BuildContext context) {
    return context.read<JobFormProvider>().validateStep(0);
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
            "Basic Job Details",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Start by providing the fundamental details of the position.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          _buildTextField(
            context,
            "Job Title *",
            Icons.title_rounded,
            "e.g. Senior Frontend Developer",
            controller: form.jobTitleController,
          ),
          AppSpacing.h20,

          // ===== BACKEND TODO =====
          // TODO: Backend se company details auto-fill hongi.
          _buildTextField(
            context,
            "Company Name *",
            Icons.business_rounded,
            "e.g. TechCorp India",
            controller: form.companyController,
          ),
          AppSpacing.h20,

          _buildTextField(
            context,
            "Location *",
            Icons.location_on_rounded,
            "e.g. Bangalore, India",
            controller: form.locationController,
          ),
          AppSpacing.h32,

          Text(
            "Work Settings",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h16,

          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  context,
                  "Job Type *",
                  Icons.work_rounded,
                  ["Full Time", "Part Time", "Contract", "Internship"],
                  value: form.employmentType,
                  onChanged: (val) {
                    if (val != null) form.setEmploymentType(val);
                  },
                ),
              ),
              AppSpacing.w16,
              Expanded(
                child: _buildDropdown(
                  context,
                  "Work Mode *",
                  Icons.laptop_mac_rounded,
                  ["Office", "Remote", "Hybrid"],
                  value: form.workMode,
                  onChanged: (val) {
                    if (val != null) form.setWorkMode(val);
                  },
                ),
              ),
            ],
          ),
          AppSpacing.h20,

          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  context,
                  "Working Days",
                  Icons.calendar_month_rounded,
                  ["5 Days", "6 Days", "Flexible"],
                  value: form.workingDays,
                  onChanged: (val) {
                    if (val != null) form.setWorkingDays(val);
                  },
                ),
              ),
              AppSpacing.w16,
              Expanded(
                child: _buildDropdown(
                  context,
                  "Working Hours",
                  Icons.access_time_rounded,
                  ["Standard (9-5)", "Flexible", "Shift Based"],
                  value: form.workingHours,
                  onChanged: (val) {
                    if (val != null) form.setWorkingHours(val);
                  },
                ),
              ),
            ],
          ),
          AppSpacing.h32,

          Text(
            "Perks & Benefits",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h16,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              "Health Insurance",
              "Paid Time Off",
              "Stock Options",
              "Gym Membership",
              "Free Meals",
              "Learning Budget",
            ].map((benefit) {
              final isSelected = form.benefits.contains(benefit);
              return _buildFilterChip(
                context,
                benefit,
                isSelected,
                (_) => form.toggleBenefit(benefit),
              );
            }).toList(),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    IconData icon,
    String hint, {
    TextEditingController? controller,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h8,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
            hintText: hint,
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
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    String label,
    IconData icon,
    List<String> items, {
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    // Ensure value is present in items
    final activeValue = items.contains(value) ? value : items.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h8,
        DropdownButtonFormField<String>(
          initialValue: activeValue,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
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
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    ValueChanged<bool> onSelected,
  ) {
    final theme = Theme.of(context);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
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
  }
}
