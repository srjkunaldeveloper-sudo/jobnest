import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/core/theme/app_input_decoration.dart';

class Step4Compensation extends StatelessWidget {
  const Step4Compensation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();
    final isDesktop = MediaQuery.of(context).size.width > 600;

    final List<String> benefitsOptions = [
      "Provident Fund (PF)",
      "ESI",
      "Health Insurance",
      "Food Allowance",
      "Cab Facility",
      "Work From Home",
      "Flexible Hours",
      "Annual Bonus",
      "Paid Leaves",
      "Learning Budget",
      "Relocation Assistance",
    ];

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
                  "Compensation & Benefits",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  "Specify the salary range and employee benefits offered for this role.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 20),

                // SALARY RANGE SECTION
                Text(
                  "Salary Range",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Min & Max Salary Inputs
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Minimum Salary",
                          controller: provider.minimumSalaryController,
                          hintText: "e.g. 4,00,000",
                          keyboardType: TextInputType.number,
                          errorText: provider.errors['minimumSalary'],
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildTextField(
                          context,
                          label: "Maximum Salary",
                          controller: provider.maximumSalaryController,
                          hintText: "e.g. 6,00,000",
                          keyboardType: TextInputType.number,
                          errorText: provider.errors['maximumSalary'],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildTextField(
                    context,
                    label: "Minimum Salary",
                    controller: provider.minimumSalaryController,
                    hintText: "e.g. 4,00,000",
                    keyboardType: TextInputType.number,
                    errorText: provider.errors['minimumSalary'],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    label: "Maximum Salary",
                    controller: provider.maximumSalaryController,
                    hintText: "e.g. 6,00,000",
                    keyboardType: TextInputType.number,
                    errorText: provider.errors['maximumSalary'],
                  ),
                ],
                const SizedBox(height: 16),

                // Currency & Salary Period Dropdowns
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          context,
                          label: "Currency",
                          value: provider.currency,
                          items: ["INR (₹)", "USD (\$)", "EUR (€)"],
                          onChanged: (val) {
                            if (val != null) provider.setCurrency(val);
                          },
                        ),
                      ),
                      AppSpacing.w16,
                      Expanded(
                        child: _buildDropdown(
                          context,
                          label: "Salary Period",
                          value: provider.salaryPeriod,
                          items: ["Per Month", "Per Annum"],
                          onChanged: (val) {
                            if (val != null) provider.setSalaryPeriod(val);
                          },
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildDropdown(
                    context,
                    label: "Currency",
                    value: provider.currency,
                    items: ["INR (₹)", "USD (\$)", "EUR (€)"],
                    onChanged: (val) {
                      if (val != null) provider.setCurrency(val);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    context,
                    label: "Salary Period",
                    value: provider.salaryPeriod,
                    items: ["Per Month", "Per Annum"],
                    onChanged: (val) {
                      if (val != null) provider.setSalaryPeriod(val);
                    },
                  ),
                ],
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),

                // Show Salary Toggle
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Show salary on job posting",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Candidates will be able to see the salary range.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: provider.showSalary,
                      onChanged: (val) {
                        provider.setShowSalary(val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // BENEFITS SELECTION SECTION
                Text(
                  "Benefits",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Select the key employee benefits offered for this position.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: benefitsOptions.map((benefit) {
                    final isSelected = provider.selectedBenefits.contains(benefit);
                    return FilterChip(
                      avatar: isSelected 
                          ? const Icon(Icons.check, size: 16, color: Colors.white) 
                          : const Icon(Icons.add, size: 16),
                      label: Text(benefit),
                      selected: isSelected,
                      selectedColor: theme.colorScheme.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      ),
                      onSelected: (_) {
                        provider.toggleBenefit(benefit);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // BANNER INFO ROW
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Offering clear compensation and benefits improves candidate engagement and application quality.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
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

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: theme.textTheme.bodyMedium,
          decoration: AppInputDecoration.style(
            context,
            hintText: hintText,
            errorText: errorText,
          ).copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    final activeValue = items.contains(value) ? value : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: activeValue,
          style: theme.textTheme.bodyMedium,
          decoration: AppInputDecoration.style(
            context,
          ).copyWith(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
