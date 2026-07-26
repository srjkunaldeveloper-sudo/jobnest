import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step1_basic_details.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step2_ai_generator.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step3_salary.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step4_requirements.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step5_settings.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/step6_preview.dart';

class CreateJobWizard extends StatefulWidget {
  const CreateJobWizard({super.key});

  @override
  State<CreateJobWizard> createState() => _CreateJobWizardState();
}

class _CreateJobWizardState extends State<CreateJobWizard> {
  int _currentStep = 0;
  final int _totalSteps = 6;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    } else {
      // ===== BACKEND TODO =====
      // TODO: Jobs API integration.
      // TODO: Publish button future me API call karega.
      final provider = context.read<RecruitmentDataProvider>();
      provider.addJob(
        JobModel(
          id: 'job_custom_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Senior Software Engineer',
          company: 'TechCorp India',
          location: 'Remote, India',
          salary: '₹ 18 - 24 LPA',
          jobType: 'Full Time',
          applicationsCount: '0',
          status: 'Open',
          aiMatchScore: 95,
          isUrgent: true,
          postedDate: 'Posted Just Now',
        ),
      );
      Navigator.pop(context); // Close the wizard on finish
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job Published Successfully! Synchronized across Dashboard & Search.')),
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context); // Close if on first step and hits back
    }
  }

  Widget _buildCurrentStepWidget() {
    switch (_currentStep) {
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

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            // ===== UX TODO =====
            // Unsaved Changes Warning (Dummy)
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Create New Job",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // ===== UX TODO =====
              // Auto Save Draft (Dummy)
              final provider = context.read<RecruitmentDataProvider>();
              provider.addJob(
                JobModel(
                  id: 'job_draft_${DateTime.now().millisecondsSinceEpoch}',
                  title: 'Draft Requisition',
                  company: 'TechCorp India',
                  location: 'Remote, India',
                  salary: '₹ 10 - 15 LPA',
                  jobType: 'Remote',
                  applicationsCount: '0',
                  status: 'Draft',
                  aiMatchScore: 80,
                  isUrgent: false,
                  postedDate: 'Drafted Just Now',
                ),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Draft Saved to Job Requisitions.')),
              );
            },
            child: const Text("Save Draft"),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: _buildProgressStepper(theme),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: KeyedSubtree(
              key: ValueKey<int>(_currentStep),
              child: _buildCurrentStepWidget(),
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
                    onPressed: _prevStep,
                    child: Text(_currentStep == 0 ? "Cancel" : "Back"),
                  ),
                  FilledButton(
                    onPressed: _nextStep,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(_currentStep == _totalSteps - 1 ? "Publish Job" : "Next"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStepper(ThemeData theme) {
    return Row(
      children: List.generate(_totalSteps, (index) {
        bool isActive = index <= _currentStep;
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
