import 'dart:async';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/jobs_repository.dart';
import '../models/job_model.dart';
import 'package:jobnest/shared/api_exception.dart';
import 'mock_jobs_data.dart';

/// A mock implementation of [JobsRepository] for testing and development.
class MockJobsRepository implements JobsRepository {
  // Use in-memory list initialized from the external mock data file
  final List<JobModel> _jobs = List.from(mockJobsData);

  /// Simulates network latency for API calls
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<RepositoryResult<List<JobModel>>> getJobs() async {
    await _simulateDelay();
    return RepositoryResult.success(List.unmodifiable(_jobs));
  }

  @override
  Future<RepositoryResult<JobModel>> getJobById(String id) async {
    await _simulateDelay();
    try {
      final job = _jobs.firstWhere((j) => j.id == id);
      return RepositoryResult.success(job);
    } catch (e) {
      // Return a simulated API exception if not found
      return RepositoryResult.failure('Job not found', exception: ApiException(message: 'Job not found', statusCode: 404));
    }
  }

  @override
  Future<RepositoryResult<JobModel>> createJob(JobModel job) async {
    await _simulateDelay();
    
    // Simulate backend ID generation
    final newId = 'job_${DateTime.now().millisecondsSinceEpoch}';
    final newJob = job.copyWith(id: newId);
    
    _jobs.add(newJob);
    return RepositoryResult.success(newJob);
  }

  @override
  Future<RepositoryResult<JobModel>> updateJob(JobModel job) async {
    await _simulateDelay();
    
    final index = _jobs.indexWhere((j) => j.id == job.id);
    if (index == -1) {
      return RepositoryResult.failure('Job not found for update', exception: ApiException(message: 'Job not found for update', statusCode: 404));
    }
    
    _jobs[index] = job;
    return RepositoryResult.success(job);
  }

  @override
  Future<RepositoryResult<void>> deleteJob(String id) async {
    await _simulateDelay();
    
    final index = _jobs.indexWhere((j) => j.id == id);
    if (index == -1) {
      return RepositoryResult.failure('Job not found for deletion', exception: ApiException(message: 'Job not found for deletion', statusCode: 404));
    }
    
    _jobs.removeAt(index);
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<List<JobModel>>> searchJobs(String query) async {
    await _simulateDelay();
    
    if (query.trim().isEmpty) {
      return RepositoryResult.success(List.unmodifiable(_jobs));
    }

    final lowercaseQuery = query.toLowerCase();
    
    // Case-insensitive search on multiple fields
    final filtered = _jobs.where((job) {
      return job.title.toLowerCase().contains(lowercaseQuery) ||
          job.department.toLowerCase().contains(lowercaseQuery) ||
          job.location.toLowerCase().contains(lowercaseQuery) ||
          job.employmentType.toLowerCase().contains(lowercaseQuery);
    }).toList();
    
    return RepositoryResult.success(filtered);
  }

  @override
  Future<RepositoryResult<List<JobModel>>> filterJobs(JobFilter filter) async {
    await _simulateDelay();
    
    final filtered = _jobs.where((job) {
      bool matches = true;
      
      if (filter.department != null && filter.department!.isNotEmpty) {
        matches = matches && job.department == filter.department;
      }
      
      if (filter.location != null && filter.location!.isNotEmpty) {
        matches = matches && job.location == filter.location;
      }
      
      if (filter.employmentType != null && filter.employmentType!.isNotEmpty) {
        matches = matches && job.employmentType == filter.employmentType;
      }
      
      if (filter.status != null && filter.status!.isNotEmpty) {
        matches = matches && job.status == filter.status;
      }
      
      if (filter.isRemote != null) {
        matches = matches && job.isRemote == filter.isRemote;
      }
      
      return matches;
    }).toList();

    return RepositoryResult.success(filtered);
  }
}
