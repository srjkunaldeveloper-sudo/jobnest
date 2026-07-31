import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';
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
            style: AppText.h2,
          ),
          AppSpacing.h8,
          Text(
            "Configure how candidates apply and how you manage them.",
            style: AppText.bodyMedium.copyWith(
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
                      style: AppText.h3.copyWith(fontSize: 14),
                    ),
                    AppSpacing.h8,
                    AppTextField(
                      controller: form.openingsController,
                      keyboardType: TextInputType.number,
                      hint: "",
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
                      style: AppText.h3.copyWith(fontSize: 14),
                    ),
                    AppSpacing.h8,
                    AppTextField(
                      controller: form.deadlineController,
                      hint: "",
                      readOnly: true,
                      icon: AppIcons.calendar_month_rounded,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.h32,

          Text(
            "Advanced Toggles",
            style: AppText.h3.copyWith(fontSize: 16),
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
                  style: AppText.h3.copyWith(fontSize: 14),
                ),
                AppSpacing.h4,
                Text(
                  subtitle,
                  style: AppText.label.copyWith(
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
