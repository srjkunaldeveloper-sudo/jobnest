import 'package:flutter/foundation.dart';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/jobs_repository.dart';
import '../../data/models/job_model.dart';

/// Represents the status of the jobs data fetching.
enum JobsStatus {
  initial,
  loading,
  refreshing,
  loaded,
  error,
}

/// Provider responsible for managing the Jobs state and business logic coordination.
class JobsProvider extends ChangeNotifier {
  final JobsRepository _repository;

  JobsStatus _status = JobsStatus.initial;
  List<JobModel> _jobs = [];
  JobModel? _selectedJob;
  JobFilter? _currentFilter;
  String _searchQuery = '';
  String? _errorMessage;

  JobsProvider(this._repository);

  // --- Getters ---

  JobsStatus get status => _status;
  List<JobModel> get jobs => _jobs;
  JobModel? get selectedJob => _selectedJob;
  JobFilter? get currentFilter => _currentFilter;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;

  // --- Private Helpers ---

  void _setStatus(JobsStatus status, {String? errorMessage}) {
    _status = status;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void _handleFetchResult(RepositoryResult<List<JobModel>> result) {
    if (result.isSuccess) {
      _jobs = result.data ?? [];
      _setStatus(JobsStatus.loaded);
    } else {
      _setStatus(
        JobsStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to load jobs.',
      );
    }
  }

  Future<void> _fetchData() async {
    if (_searchQuery.isNotEmpty) {
      _handleFetchResult(await _repository.searchJobs(_searchQuery));
    } else if (_currentFilter != null) {
      _handleFetchResult(await _repository.filterJobs(_currentFilter!));
    } else {
      _handleFetchResult(await _repository.getJobs());
    }
  }

  // --- Public Methods ---

  /// Initial load of the jobs data.
  Future<void> loadJobs() async {
    if (_status == JobsStatus.loading) return;
    _setStatus(JobsStatus.loading);
    await _fetchData();
  }

  /// Refreshes the jobs data (e.g., via pull-to-refresh).
  Future<void> refresh() async {
    if (_status == JobsStatus.refreshing) return;
    _setStatus(JobsStatus.refreshing);
    await _fetchData();
  }

  /// Executes a search using the provided [query].
  Future<void> search(String query) async {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _setStatus(JobsStatus.loading);
    
    // Clear filter when searching to avoid conflicting state constraints, 
    // or keep it if business rules dictate. Here we assume search takes precedence.
    _currentFilter = null;
    
    _handleFetchResult(await _repository.searchJobs(query));
  }

  /// Applies a [JobFilter] to the jobs list.
  Future<void> applyFilter(JobFilter filter) async {
    _currentFilter = filter;
    _searchQuery = ''; // Reset search query when applying a hard filter
    _setStatus(JobsStatus.loading);
    
    _handleFetchResult(await _repository.filterJobs(filter));
  }

  /// Clears any active filters and reloads all jobs.
  Future<void> clearFilter() async {
    if (_currentFilter == null) return;
    _currentFilter = null;
    await loadJobs();
  }

  /// Selects a specific job (e.g., for viewing details).
  void selectJob(JobModel? job) {
    if (_selectedJob?.id == job?.id) return;
    _selectedJob = job;
    notifyListeners();
  }

  /// Creates a new job and updates the local state upon success.
  Future<bool> createJob(JobModel job) async {
    _setStatus(JobsStatus.loading);
    final result = await _repository.createJob(job);
    
    if (result.isSuccess && result.data != null) {
      _jobs.insert(0, result.data!);
      _setStatus(JobsStatus.loaded);
      return true;
    } else {
      _setStatus(
        JobsStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to create job.',
      );
      return false;
    }
  }

  /// Updates an existing job and synchronizes the local state upon success.
  Future<bool> updateJob(JobModel job) async {
    _setStatus(JobsStatus.loading);
    final result = await _repository.updateJob(job);
    
    if (result.isSuccess && result.data != null) {
      final index = _jobs.indexWhere((j) => j.id == job.id);
      if (index != -1) {
        _jobs[index] = result.data!;
      }
      if (_selectedJob?.id == job.id) {
        _selectedJob = result.data;
      }
      _setStatus(JobsStatus.loaded);
      return true;
    } else {
      _setStatus(
        JobsStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to update job.',
      );
      return false;
    }
  }

  /// Deletes a job by its [id] and removes it from the local state upon success.
  Future<bool> deleteJob(String id) async {
    _setStatus(JobsStatus.loading);
    final result = await _repository.deleteJob(id);
    
    if (result.isSuccess) {
      _jobs.removeWhere((j) => j.id == id);
      if (_selectedJob?.id == id) {
        _selectedJob = null;
      }
      _setStatus(JobsStatus.loaded);
      return true;
    } else {
      _setStatus(
        JobsStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to delete job.',
      );
      return false;
    }
  }
}
