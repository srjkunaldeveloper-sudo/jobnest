import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/constants/app_icons.dart';
import 'package:jobnest/features/jobs/create_job/provider/create_job_provider.dart';
import 'package:jobnest/features/jobs/create_job/widgets/progress_stepper.dart';
import 'package:jobnest/features/jobs/create_job/widgets/wizard_footer.dart';
import 'package:jobnest/features/jobs/create_job/steps/step1_basics.dart';
import 'package:jobnest/features/jobs/create_job/steps/step2_location.dart';
import 'package:jobnest/features/jobs/create_job/steps/step3_details.dart';
import 'package:jobnest/features/jobs/create_job/steps/step4_compensation.dart';
import 'package:jobnest/features/jobs/create_job/steps/step5_application.dart';
import 'package:jobnest/features/jobs/create_job/steps/step6_settings.dart';
import 'package:jobnest/features/jobs/create_job/steps/step7_preview.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class CreateJobScreen extends StatelessWidget {
  const CreateJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateJobProvider(),
      child: const _CreateJobScreenContent(),
    );
  }
}

class _CreateJobScreenContent extends StatelessWidget {
  const _CreateJobScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<CreateJobProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.close_rounded),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: Text(
          "Create New Job",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              // Placeholder: Generate with AI - UI only
            },
            icon: const Icon(AppIcons.auto_awesome_rounded, color: Colors.deepPurpleAccent, size: 18),
            label: const Text(
              "Generate with AI",
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          ProgressStepper(
            currentStep: provider.currentStep,
            totalSteps: provider.totalSteps,
          ),
          if (provider.bannerMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        provider.bannerMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        provider.clearBannerMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: provider.currentStep == 0
                ? const Step1Basics()
                : provider.currentStep == 1
                    ? const Step2Location()
                    : provider.currentStep == 2
                        ? const Step3Details()
                        : provider.currentStep == 3
                            ? const Step4Compensation()
                            : provider.currentStep == 4
                                ? const Step5Application()
                                : provider.currentStep == 5
                                    ? const Step6Settings()
                                    : provider.currentStep == 6
                                        ? const Step7Preview()
                                        : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          AppIcons.work_outline_rounded,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Step ${provider.currentStep + 1} Form Placeholder",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This section is under development.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: WizardFooter(
        currentStep: provider.currentStep,
        totalSteps: provider.totalSteps,
        onPrevious: () {
          provider.previousStep();
        },
        onNext: () {
          provider.nextStep();
        },
      ),
    );
  }
}
