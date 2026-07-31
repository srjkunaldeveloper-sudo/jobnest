import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';

class Step2AiGenerator extends StatelessWidget {
  const Step2AiGenerator({super.key});

  static bool validateCurrentStep(BuildContext context) {
    return context.read<JobFormProvider>().validateStep(1);
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
          Row(
            children: [
              const Icon(AppIcons.auto_awesome_rounded, color: Colors.deepPurpleAccent),
              AppSpacing.w8,
              Text(
                "AI Job Description",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          AppSpacing.h8,
          Text(
            "Let our AI generate a professional job description for you.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.h32,

          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prompt",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                AppSpacing.h8,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: form.promptController,
                        decoration: InputDecoration(
                          hintText: "E.g. Senior Flutter Developer with 5 years experience...",
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
                    ),
                    AppSpacing.w16,
                    FilledButton.icon(
                      onPressed: () {
                        // ===== BACKEND TODO =====
                        // TODO: AI JD Generator API yaha connect hogi.
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      ),
                      icon: const Icon(AppIcons.auto_awesome_rounded),
                      label: const Text("Generate"),
                    )
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.h32,

          Text(
            "Generated Description (Editable)",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h16,

          _buildEditableSection(
            context,
            "Responsibilities",
            form.responsibilitiesController,
          ),
          AppSpacing.h20,
          _buildEditableSection(
            context,
            "Skills Required",
            form.skillsTextController,
          ),
          AppSpacing.h20,
          _buildEditableSection(
            context,
            "Qualifications",
            form.requirementsController,
          ),
          AppSpacing.h20,
          _buildEditableSection(
            context,
            "Experience",
            TextEditingController(text: "• 0-1 years of experience in sales or marketing.\n• Fresher with strong aptitude can apply."),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildEditableSection(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
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
          maxLines: 4,
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
    );
  }
}
