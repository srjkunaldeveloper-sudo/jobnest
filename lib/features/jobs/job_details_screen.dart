import 'package:flutter/material.dart';

import 'package:jobnest/features/jobs/widgets/job_details/details_header.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_overview.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_pipeline.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_analytics.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_ai_insights.dart';
import 'package:jobnest/features/jobs/widgets/job_details/details_top_candidates.dart';

class JobDetailsScreen extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String status;

  const JobDetailsScreen({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Job details backend se fetch honge using job ID.

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
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
                ),
                const SizedBox(height: 32),
                
                const DetailsOverview(),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.edit_rounded),
        label: const Text(
          "Edit Job",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
    );
  }
}
