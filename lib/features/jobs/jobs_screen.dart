import 'package:flutter/material.dart';

import 'package:jobnest/features/jobs/widgets/jobs_header.dart';
import 'package:jobnest/features/jobs/widgets/jobs_search_and_filters.dart';
import 'package:jobnest/features/jobs/widgets/jobs_overview.dart';
import 'package:jobnest/features/jobs/widgets/job_list_card.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/create_job_wizard.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate API Fetch
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JobsHeader(),
              const JobsSearchAndFilters(),
              const JobsOverview(),
              
              // Job List Header
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "All Jobs",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              
              // ===== BACKEND TODO =====
              // TODO: Future me backend se jobs fetch hongi.
              // TODO: Job list Firestore/API se populate hogi.
              if (_isLoading)
                const Column(
                  children: [
                    AppSkeletonCard(),
                    SizedBox(height: 16),
                    AppSkeletonCard(),
                    SizedBox(height: 16),
                    AppSkeletonCard(),
                  ],
                )
              else
                const Column(
                  children: [
                    JobListCard(
                      title: "Senior Sales Executive",
                      company: "TechCorp India",
                      location: "Delhi, India",
                      salary: "₹ 4 - 6 LPA",
                      jobType: "Full Time",
                      applicationsCount: "246",
                      status: "Active",
                      aiMatchScore: 92,
                    ),
                    JobListCard(
                      title: "Python Developer",
                      company: "Innovate AI",
                      location: "Bangalore, India",
                      salary: "₹ 8 - 10 LPA",
                      jobType: "Remote",
                      applicationsCount: "186",
                      status: "Active",
                      aiMatchScore: 85,
                    ),
                    JobListCard(
                      title: "UI/UX Designer",
                      company: "Creative Studio",
                      location: "Mumbai, India",
                      salary: "₹ 5 - 8 LPA",
                      jobType: "Full Time",
                      applicationsCount: "142",
                      status: "Closed",
                      aiMatchScore: 64,
                    ),
                    JobListCard(
                      title: "HR Executive",
                      company: "TechCorp India",
                      location: "Delhi, India",
                      salary: "₹ 3 - 5 LPA",
                      jobType: "Full Time",
                      applicationsCount: "67",
                      status: "Active",
                      aiMatchScore: 78,
                    ),
                  ],
                ),
              
              const SizedBox(height: 80), // Padding for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const CreateJobWizard(),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          "Create Job",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
    );
  }
}
