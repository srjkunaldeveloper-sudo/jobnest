import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';

class Step4Requirements extends StatelessWidget {
  const Step4Requirements({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

          _buildChipGroup(context, "Experience", ["Fresher", "1-3 Years", "3-5 Years", "5-8 Years", "8+ Years"], [1]),
          AppSpacing.h24,
          
          _buildChipGroup(context, "Education", ["High School", "Bachelor's", "Master's", "PhD", "Any"], [1, 2]),
          AppSpacing.h24,
          
          _buildChipGroup(context, "Notice Period", ["Immediate", "15 Days", "30 Days", "60 Days", "90 Days"], [0, 1]),
          AppSpacing.h24,

          _buildChipGroup(context, "Top Skills", ["Flutter", "Dart", "Firebase", "REST APIs", "UI/UX", "Git", "Figma", "Agile"], [0, 1, 3, 5]),
          AppSpacing.h24,

          _buildChipGroup(context, "Languages", ["English", "Hindi", "Spanish", "French", "German"], [0, 1]),
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

  Widget _buildChipGroup(BuildContext context, String label, List<String> options, List<int> selectedIndices) {
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
          children: options.asMap().entries.map((entry) {
            int idx = entry.key;
            String text = entry.value;
            bool isSelected = selectedIndices.contains(idx);
            
            return FilterChip(
              label: Text(text),
              selected: isSelected,
              onSelected: (val) {},
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
