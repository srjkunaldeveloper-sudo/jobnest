import '../../core/constants/app_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jobnest/features/jobs/widgets/jobs_header.dart';
import 'package:jobnest/features/jobs/widgets/jobs_search_and_filters.dart';
import 'package:jobnest/features/jobs/widgets/jobs_overview.dart';
import 'package:jobnest/features/jobs/widgets/job_list_card.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/create_job_wizard.dart';
import 'package:jobnest/core/widgets/app_shimmer_loading.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/widgets/app_error_state.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/jobs/providers/job_filter_provider.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<JobProvider>();
    final filterProvider = context.watch<JobFilterProvider>();
    final filteredJobs = filterProvider.filteredJobs;
    final bool isLoading = provider.isLoading;

    // ===== BACKEND TODO =====
    // TODO: Jobs API integration.
    // TODO: Pagination.
    // TODO: Server-side filtering.
    // TODO: Real-time job updates.
    // TODO: Bookmark sync.

    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await provider.refreshJobs();
          },
          color: theme.colorScheme.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0, bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const JobsHeader(),
                      const JobsSearchAndFilters(),
                      const JobsOverview(),
                      
                      // Job List Section Header
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                filterProvider.filterCount > 0
                                    ? "Filtered Requisitions (${filteredJobs.length})"
                                    : "All Requisitions (${provider.jobs.length})",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Swipe left to archive",
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 13,
                                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // QA Simulation Toolbar (Hidden in release/demo mode)
                      if (kDebugMode) ...[
                        _buildQaSimulationBar(context, provider, theme),
                        const SizedBox(height: 16),
                      ],

                      // State Handling: Loading, Error, Empty, List
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLoading
                            ? _buildSkeletonLoader()
                            : provider.isJobsError
                                ? _buildErrorState(context, provider, theme)
                                : filteredJobs.isEmpty
                                    ? _buildEmptyState(context, provider, filterProvider, theme, isFilterEmpty: provider.jobs.isNotEmpty)
                                    : _buildJobsList(context, provider, filteredJobs, theme),
                      ),
                      
                      const SizedBox(height: 100), // Padding for FAB
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Semantics(
        label: "Create New Job Requisition",
        button: true,
        child: FloatingActionButton.extended(
          onPressed: () {
            context.read<JobFormProvider>().initializeCreate();
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const CreateJobWizard(),
              ),
            );
          },
          icon: const Icon(AppIcons.add_rounded),
          label: const Text(
            "Create Job",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return const Column(
      key: ValueKey("loading"),
      children: [
        AppSkeletonCard(),
        SizedBox(height: 16),
        AppSkeletonCard(),
        SizedBox(height: 16),
        AppSkeletonCard(),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, JobProvider provider, ThemeData theme) {
    return AppCard(
      key: const ValueKey("error"),
      padding: EdgeInsets.zero,
      child: AppErrorState(
        title: "Requisition Synchronization Failed",
        message: "Unable to connect to the ATS backend server. Please verify network connectivity or retry.",
        primaryButtonText: "Retry Sync",
        onRetry: () => provider.refreshJobs(),
        secondaryButtonText: "Restore Offline Data",
        onSecondaryAction: () => provider.restoreJobsDefault(),
        iconData: AppIcons.cloud_off_rounded,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, JobProvider provider, JobFilterProvider filterProvider, ThemeData theme, {required bool isFilterEmpty}) {
    return AppCard(
      key: const ValueKey("empty"),
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFilterEmpty ? AppIcons.search_off_rounded : AppIcons.work_outline_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isFilterEmpty ? "No Matching Requisitions Found" : "No Job Requisitions Available",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isFilterEmpty
                  ? "We couldn't find any positions matching your current search query or filter criteria. Try clearing filters or searching for broader terms."
                  : "Your ATS pipeline is currently empty. Start attracting top talent by publishing a new job requisition.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            if (isFilterEmpty)
              OutlinedButton.icon(
                onPressed: () => filterProvider.clearFilters(),
                icon: const Icon(AppIcons.filter_alt_off_rounded, size: 18),
                label: const Text("Clear Filters & Search", style: TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(minimumSize: const Size(160, 48)),
              )
            else
              FilledButton.icon(
                onPressed: () {
                  context.read<JobFormProvider>().initializeCreate();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const CreateJobWizard(),
                    ),
                  );
                },
                icon: const Icon(AppIcons.add_rounded, size: 20),
                label: const Text("Create New Job", style: TextStyle(fontWeight: FontWeight.bold)),
                style: FilledButton.styleFrom(minimumSize: const Size(180, 48)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobsList(
    BuildContext context,
    JobProvider provider,
    List<JobModel> jobs,
    ThemeData theme,
  ) {
    return Column(
      key: const ValueKey("list"),
      children: jobs.map((job) {
        return Dismissible(
          key: ValueKey(job.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            provider.deleteJob(job.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Archived '${job.title}'. Synchronized with Home Dashboard."),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () => provider.restoreJobsDefault(),
                ),
              ),
            );
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(AppIcons.archive_outlined, color: theme.colorScheme.onErrorContainer),
                const SizedBox(width: 8),
                Text(
                  "Archive",
                  style: TextStyle(
                    color: theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          child: JobListCard(
            title: job.title,
            company: job.company,
            location: job.location,
            salary: job.salary,
            jobType: job.jobType,
            applicationsCount: job.applicationsCount,
            status: job.status,
            aiMatchScore: job.aiMatchScore,
            job: job,
            onBookmarkTap: () {
              provider.toggleBookmarkJob(job.id);
            },
            onStatusChange: (newStatus) {
              provider.updateJobStatus(job.id, newStatus);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Updated status of '${job.title}' to $newStatus.")),
              );
            },
            onDuplicateTap: () {
              provider.duplicateJob(job.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Duplicated '${job.title}' as Draft.")),
              );
            },
            onDeleteTap: () {
              provider.deleteJob(job.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Deleted '${job.title}'. Dashboard count updated.")),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQaSimulationBar(BuildContext context, JobProvider provider, ThemeData theme) {
    if (!kDebugMode) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(AppIcons.bug_report_rounded, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                "ATS QA Controls:",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQaButton(
                context,
                "Skeleton Load",
                () => provider.simulateJobsLoading(),
              ),
              _buildQaButton(
                context,
                "Simulate Error",
                () => provider.simulateJobsError(),
              ),
              _buildQaButton(
                context,
                "Empty State",
                () => provider.simulateJobsEmpty(),
              ),
              _buildQaButton(
                context,
                "Reset Default",
                () => provider.restoreJobsDefault(),
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQaButton(BuildContext context, String label, VoidCallback onTap, {bool isPrimary = false}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPrimary ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
