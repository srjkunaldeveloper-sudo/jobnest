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
import 'package:jobnest/core/providers/recruitment_data_provider.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool _isInitialLoading = true;
  String _searchQuery = "";
  String _selectedFilter = "All";
  String _selectedSort = "Newest";

  @override
  void initState() {
    super.initState();
    // Simulate initial network fetch
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _isInitialLoading = false;
        });
      }
    });
  }

  int _extractSalary(String salaryStr) {
    // Extract first numeric number from salary string like "₹ 15 - 18 LPA"
    final reg = RegExp(r'\d+');
    final match = reg.firstMatch(salaryStr);
    return match != null ? int.tryParse(match.group(0) ?? '0') ?? 0 : 0;
  }

  List<JobModel> _getFilteredAndSortedJobs(List<JobModel> sourceJobs) {
    List<JobModel> list = List.of(sourceJobs);

    // 1. Instant Local Search Filter (Title, Company, Location, JobType, Skills)
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      list = list.where((j) {
        return j.title.toLowerCase().contains(q) ||
               j.company.toLowerCase().contains(q) ||
               j.location.toLowerCase().contains(q) ||
               j.jobType.toLowerCase().contains(q) ||
               j.skills.any((s) => s.toLowerCase().contains(q));
      }).toList();
    }

    // 2. Chip Filtering (Status or JobType)
    if (_selectedFilter != "All") {
      if (_selectedFilter == "Active" || _selectedFilter == "Open") {
        list = list.where((j) => j.status.toLowerCase() == "active" || j.status.toLowerCase() == "open").toList();
      } else if (["Hiring", "Paused", "Closed", "Draft"].contains(_selectedFilter)) {
        list = list.where((j) => j.status.toLowerCase() == _selectedFilter.toLowerCase()).toList();
      } else if (["Remote", "Hybrid", "Full Time", "Part Time", "Internship"].contains(_selectedFilter)) {
        list = list.where((j) => j.jobType.toLowerCase() == _selectedFilter.toLowerCase()).toList();
      }
    }

    // 3. Dummy Sorting
    switch (_selectedSort) {
      case "Newest":
        // Preserve default insert-at-top chronological order
        break;
      case "Oldest":
        list = list.reversed.toList();
        break;
      case "Recently Updated":
        list.sort((a, b) => b.aiMatchScore.compareTo(a.aiMatchScore));
        break;
      case "Highest Salary":
        list.sort((a, b) => _extractSalary(b.salary).compareTo(_extractSalary(a.salary)));
        break;
      case "Lowest Salary":
        list.sort((a, b) => _extractSalary(a.salary).compareTo(_extractSalary(b.salary)));
        break;
      case "Most Applicants":
        list.sort((a, b) {
          final countA = int.tryParse(a.applicationsCount.replaceAll(',', '')) ?? 0;
          final countB = int.tryParse(b.applicationsCount.replaceAll(',', '')) ?? 0;
          return countB.compareTo(countA);
        });
        break;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<RecruitmentDataProvider>();
    final filteredJobs = _getFilteredAndSortedJobs(provider.jobs);
    final bool isLoading = _isInitialLoading || provider.isJobsLoading;

    // ===== BACKEND TODO =====
    // TODO: Jobs API integration.
    // TODO: Pagination.
    // TODO: Server-side filtering.
    // TODO: Real-time job updates.
    // TODO: Bookmark sync.

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const JobsHeader(),
                      JobsSearchAndFilters(
                        searchQuery: _searchQuery,
                        onSearchChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        selectedFilter: _selectedFilter,
                        onFilterChanged: (val) {
                          setState(() {
                            _selectedFilter = val;
                          });
                        },
                        selectedSort: _selectedSort,
                        onSortChanged: (val) {
                          setState(() {
                            _selectedSort = val;
                          });
                        },
                        onClearAll: () {
                          setState(() {
                            _searchQuery = "";
                            _selectedFilter = "All";
                            _selectedSort = "Newest";
                          });
                        },
                      ),
                      const JobsOverview(),
                      
                      // Job List Section Header
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _searchQuery.isNotEmpty || _selectedFilter != "All"
                                  ? "Filtered Requisitions (${filteredJobs.length})"
                                  : "All Requisitions (${provider.jobs.length})",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Text(
                              "Swipe left to archive",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
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
                                    ? _buildEmptyState(context, theme, isFilterEmpty: provider.jobs.isNotEmpty)
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

  Widget _buildErrorState(BuildContext context, RecruitmentDataProvider provider, ThemeData theme) {
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
        iconData: Icons.cloud_off_rounded,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme, {required bool isFilterEmpty}) {
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
                isFilterEmpty ? Icons.search_off_rounded : Icons.work_outline_rounded,
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
                onPressed: () {
                  setState(() {
                    _searchQuery = "";
                    _selectedFilter = "All";
                    _selectedSort = "Newest";
                  });
                },
                icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
                label: const Text("Clear Filters & Search", style: TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(minimumSize: const Size(160, 48)),
              )
            else
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const CreateJobWizard(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_rounded, size: 20),
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
    RecruitmentDataProvider provider,
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
                Icon(Icons.archive_outlined, color: theme.colorScheme.onErrorContainer),
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

  Widget _buildQaSimulationBar(BuildContext context, RecruitmentDataProvider provider, ThemeData theme) {
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
              Icon(Icons.bug_report_rounded, size: 16, color: theme.colorScheme.primary),
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
