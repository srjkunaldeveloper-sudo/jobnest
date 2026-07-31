import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/repositories/jobs_repository.dart' show JobFilter;
import '../providers/jobs_provider.dart';
import '../widgets/job_card.dart';
import '../widgets/jobs_empty.dart';
import '../widgets/jobs_filter_section.dart';
import '../widgets/jobs_loading.dart';
import '../widgets/jobs_search_bar.dart';

/// The main screen for displaying, searching, and filtering jobs.
class JobsScreen extends StatefulWidget {
  final VoidCallback? onCreateJobTap;
  final ValueChanged<String>? onJobTap;
  final ValueChanged<String>? onEditJobTap;
  final ValueChanged<String>? onDeleteJobTap;

  const JobsScreen({
    super.key,
    this.onCreateJobTap,
    this.onJobTap,
    this.onEditJobTap,
    this.onDeleteJobTap,
  });

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobsProvider>().loadJobs();
    });
  }

  void _updateFilter(
    JobsProvider provider, {
    String? department,
    bool updateDepartment = false,
    String? status,
    bool updateStatus = false,
    String? employmentType,
    bool updateEmploymentType = false,
    bool? isRemote,
    bool updateIsRemote = false,
  }) {
    final current = provider.currentFilter ?? const JobFilter();
    provider.applyFilter(JobFilter(
      department: updateDepartment ? department : current.department,
      location: current.location,
      employmentType: updateEmploymentType ? employmentType : current.employmentType,
      status: updateStatus ? status : current.status,
      isRemote: updateIsRemote ? isRemote : current.isRemote,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? AppIcons.filter_list_off : AppIcons.filter_list),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            tooltip: 'Toggle Filters',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onCreateJobTap ?? () {},
        tooltip: 'Create New Job',
        child: const Icon(AppIcons.add),
      ),
      body: Consumer<JobsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Pinned Search and Filter section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JobsSearchBar(
                      onChanged: provider.search,
                      hintText: 'Search jobs by title, department, or location...',
                    ),
                    if (_showFilters) ...[
                      const SizedBox(height: 16),
                      JobsFilterSection(
                        filter: provider.currentFilter ?? const JobFilter(),
                        onDepartmentChanged: (val) =>
                            _updateFilter(provider, department: val, updateDepartment: true),
                        onStatusChanged: (val) =>
                            _updateFilter(provider, status: val, updateStatus: true),
                        onEmploymentChanged: (val) =>
                            _updateFilter(provider, employmentType: val, updateEmploymentType: true),
                        onRemoteChanged: (val) =>
                            _updateFilter(provider, isRemote: val, updateIsRemote: true),
                        onClear: () {
                          provider.clearFilter();
                          setState(() {
                            _showFilters = false;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
              // Scrollable content area wrapped with RefreshIndicator
              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.refresh,
                  child: _buildBodyContent(context, provider),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, JobsProvider provider) {
    if (provider.status == JobsStatus.initial || provider.status == JobsStatus.loading) {
      return const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: JobsLoading(),
      );
    }

    if (provider.status == JobsStatus.error) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: JobsEmpty(
          icon: AppIcons.error_outline,
          title: 'Something went wrong',
          message: provider.errorMessage ?? 'Failed to load jobs.',
          primaryButtonText: 'Retry',
          onPrimaryPressed: provider.loadJobs,
        ),
      );
    }

    if (provider.jobs.isEmpty) {
      final isFiltered = provider.searchQuery.isNotEmpty || provider.currentFilter != null;
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: JobsEmpty(
          icon: AppIcons.work_off_outlined,
          title: 'No Jobs Found',
          message: isFiltered
              ? 'Try adjusting your search or filters.'
              : 'There are currently no active job postings.',
          primaryButtonText: isFiltered ? 'Clear Filters' : 'Create Job',
          onPrimaryPressed: isFiltered ? provider.clearFilter : widget.onCreateJobTap,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80.0),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: provider.jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final job = provider.jobs[index];
        return JobCard(
          job: job,
          onTap: () => widget.onJobTap?.call(job.id),
          onEdit: () => widget.onEditJobTap?.call(job.id),
          onDelete: () => widget.onDeleteJobTap?.call(job.id),
        );
      },
    );
  }
}
