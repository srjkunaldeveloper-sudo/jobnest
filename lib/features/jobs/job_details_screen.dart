import '../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_header.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_overview.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_pipeline.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_analytics.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_ai_insights.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_top_candidates.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/create_job_wizard.dart';

class JobDetailsScreen extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String status;
  final JobModel? job;

  const JobDetailsScreen({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.status,
    this.job,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Job details backend se fetch honge using job ID.
    // TODO: Real-time job updates.

    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: Semantics(
          label: "Back to Job Requisitions",
          button: true,
          child: IconButton(
            icon: const Icon(AppIcons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          ),
        ),
        title: Text(
          "Requisition Details",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsHeader(
                  title: title,
                  company: company,
                  location: location,
                  salary: salary,
                  jobType: jobType,
                  status: status,
                  job: job,
                ),
                const SizedBox(height: 32),
                
                DetailsOverview(job: job),
                const SizedBox(height: 32),
                
                const DetailsPipeline(),
                const SizedBox(height: 32),

                const DetailsAnalytics(),
                const SizedBox(height: 32),

                const DetailsAiInsights(),
                const SizedBox(height: 32),

                const DetailsTopCandidates(),
                
                const SizedBox(height: 100), // Padding for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Semantics(
        label: "Edit Job Requisition",
        button: true,
        child: FloatingActionButton.extended(
          onPressed: () {
            final jobToEdit = job ?? JobModel(
              id: 'job_fallback_${DateTime.now().millisecondsSinceEpoch}',
              title: title,
              company: company,
              location: location,
              salary: salary,
              jobType: jobType,
              applicationsCount: '0',
              status: status,
              aiMatchScore: 90,
            );
            context.read<JobFormProvider>().initializeEdit(jobToEdit);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreateJobWizard(initialJob: jobToEdit)),
            );
          },
          icon: const Icon(AppIcons.edit_rounded),
          label: const Text(
            "Edit Requisition",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
