import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class Step3Salary extends StatelessWidget {
  const Step3Salary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compensation",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Define the salary range and currency for this role.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          // ===== BACKEND TODO =====
          // TODO: Salary Benchmark backend se aayega.
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.insights_rounded, color: Colors.deepPurpleAccent),
                AppSpacing.w16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI Salary Insights",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      AppSpacing.h8,
                      Text(
                        "Based on the role 'Sales Executive' in 'Bangalore, India'.",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      AppSpacing.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInsightItem(context, "Market Average", "₹ 4,00,000 / Yr"),
                          _buildInsightItem(context, "Recommended", "₹ 4,50,000 / Yr", isHighlight: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h32,

          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(context, "Minimum Salary", "e.g. 400000"),
              ),
              AppSpacing.w16,
              Expanded(
                flex: 2,
                child: _buildTextField(context, "Maximum Salary", "e.g. 600000"),
              ),
            ],
          ),
          AppSpacing.h24,

          Row(
            children: [
              Expanded(
                child: _buildDropdown(context, "Currency", ["INR (₹)", "USD (\$)", "EUR (€)"]),
              ),
              AppSpacing.w16,
              Expanded(
                child: _buildDropdown(context, "Salary Type", ["Yearly", "Monthly", "Hourly"]),
              ),
            ],
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildInsightItem(BuildContext context, String label, String value, {bool isHighlight = false}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        AppSpacing.h4,
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isHighlight ? Colors.deepPurpleAccent : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
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
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
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

  Widget _buildDropdown(BuildContext context, String label, List<String> items) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h8,
        DropdownButtonFormField<String>(
          initialValue: items.first,
          decoration: InputDecoration(
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
          onChanged: (val) {},
        ),
      ],
    );
  }
}
