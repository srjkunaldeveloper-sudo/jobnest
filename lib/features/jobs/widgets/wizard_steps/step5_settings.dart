import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class Step5Settings extends StatelessWidget {
  const Step5Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                      "Open Positions",
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSpacing.h8,
                    TextFormField(
                      initialValue: "1",
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
                      readOnly: true,
                      initialValue: "30 Aug 2026",
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
                  value: true,
                ),
                const Divider(),
                _buildToggleRow(
                  context,
                  title: "Auto Shortlisting",
                  subtitle: "AI automatically moves candidates matching 80%+ skills to the shortlsited round.",
                  value: false,
                ),
                const Divider(),
                _buildToggleRow(
                  context,
                  title: "Fast Hiring Mode",
                  subtitle: "Enables 1-click apply and skips long questionnaires.",
                  value: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildToggleRow(BuildContext context, {required String title, required String subtitle, required bool value}) {
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
            onChanged: (val) {},
            activeThumbColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
