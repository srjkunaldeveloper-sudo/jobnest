import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step1_basic_details.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step2_ai_generator.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step3_salary.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step4_requirements.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step5_settings.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step6_preview.dart';

class CreateJobWizard extends StatelessWidget {
  final JobModel? initialJob;
  const CreateJobWizard({super.key, this.initialJob});

  Widget _buildCurrentStepWidget(int currentStep) {
    switch (currentStep) {
      case 0:
        return const Step1BasicDetails();
      case 1:
        return const Step2AiGenerator();
      case 2:
        return const Step3Salary();
      case 3:
        return const Step4Requirements();
      case 4:
        return const Step5Settings();
      case 5:
        return const Step6Preview();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formProvider = context.watch<JobFormProvider>();

    if (!formProvider.isInitialized ||
        (initialJob != null &&
            (!formProvider.isEditMode ||
                formProvider.editingJobId != initialJob!.id))) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          final provider = context.read<JobFormProvider>();
          if (initialJob != null) {
            if (!provider.isEditMode || provider.editingJobId != initialJob!.id) {
              provider.initializeEdit(initialJob!);
            }
          } else if (!provider.isInitialized || provider.isEditMode) {
            provider.initializeCreate();
          }
        }
      });
    }

    final currentStep = formProvider.currentStep;
    final totalSteps = formProvider.totalSteps;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          formProvider.isEditMode ? "Edit Job Requisition" : "Create New Job",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              formProvider.setStatus('Draft');
              final job = formProvider.buildJobModel();
              if (formProvider.isEditMode) {
                context.read<JobProvider>().updateJob(job);
              } else {
                context.read<JobProvider>().createJob(job);
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    formProvider.isEditMode
                        ? 'Draft Changes Saved to Job Requisitions.'
                        : 'Draft Saved to Job Requisitions.',
                  ),
                ),
              );
            },
            child: const Text("Save Draft"),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: _buildProgressStepper(theme, currentStep, totalSteps),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: KeyedSubtree(
              key: ValueKey<int>(currentStep),
              child: _buildCurrentStepWidget(currentStep),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (currentStep == 0) {
                        Navigator.pop(context);
                      } else {
                        formProvider.previousStep();
                      }
                    },
                    child: Text(currentStep == 0 ? "Cancel" : "Back"),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (currentStep < totalSteps - 1) {
                        if (formProvider.validateCurrentStep()) {
                          formProvider.nextStep();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete required fields (*).')),
                          );
                        }
                      } else {
                        if (formProvider.validateEntireForm()) {
                          final job = formProvider.buildJobModel();
                          if (formProvider.isEditMode) {
                            context.read<JobProvider>().updateJob(job);
                          } else {
                            context.read<JobProvider>().createJob(job);
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                formProvider.isEditMode
                                    ? 'Job Updated Successfully! Synchronized across Dashboard & Search.'
                                    : 'Job Published Successfully! Synchronized across Dashboard & Search.',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please verify all steps and complete required fields (*).')),
                          );
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      currentStep == totalSteps - 1
                          ? (formProvider.isEditMode ? "Save Changes" : "Publish Job")
                          : "Next",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStepper(ThemeData theme, int currentStep, int totalSteps) {
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isActive = index <= currentStep;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isActive ? theme.colorScheme.primary : theme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
