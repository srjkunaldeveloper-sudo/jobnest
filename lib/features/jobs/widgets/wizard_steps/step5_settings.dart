import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';

class Step5Settings extends StatelessWidget {
  const Step5Settings({super.key});

  static bool validateCurrentStep(BuildContext context) {
    return context.read<JobFormProvider>().validateStep(4);
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
            "Hiring Settings",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.h8,
          Text(
            "Configure how candidates apply and how you manage them.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Open Positions *",
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSpacing.h8,
                    TextFormField(
                      controller: form.openingsController,
                      keyboardType: TextInputType.number,
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
                    ),
                  ],
                ),
              ),
              AppSpacing.w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application Deadline",
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSpacing.h8,
                    TextFormField(
                      controller: form.deadlineController,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 30)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                          form.deadlineController.text = "${picked.day} ${months[picked.month - 1]} ${picked.year}";
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_month_rounded),
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
              ),
            ],
          ),
          AppSpacing.h32,

          Text(
            "Advanced Toggles",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h16,
          
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _buildToggleRow(
                  context,
                  title: "Urgent Hiring",
                  subtitle: "Highlights your job with a red badge to attract immediate joiners.",
                  value: form.isUrgent,
                  onChanged: (val) => form.setUrgent(val),
                ),
                const Divider(),
                _buildToggleRow(
                  context,
                  title: "Auto Shortlisting",
                  subtitle: "AI automatically moves candidates matching 80%+ skills to the shortlisted round.",
                  value: form.autoShortlist,
                  onChanged: (val) => form.setAutoShortlist(val),
                ),
                const Divider(),
                _buildToggleRow(
                  context,
                  title: "Fast Hiring Mode",
                  subtitle: "Enables 1-click apply and skips long questionnaires.",
                  value: form.fastHiring,
                  onChanged: (val) => form.setFastHiring(val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildToggleRow(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h4,
                Text(
                  subtitle,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.w16,
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
