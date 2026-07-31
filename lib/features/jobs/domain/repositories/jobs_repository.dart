import '../../../../core/repositories/repository_result.dart';
import '../../data/models/job_model.dart';

/// Represents the filter criteria for querying jobs.
class JobFilter {
  final String? department;
  final String? location;
  final String? employmentType;
  final String? status;
  final bool? isRemote;

  const JobFilter({
    this.department,
    this.location,
    this.employmentType,
    this.status,
    this.isRemote,
  });
}

/// Abstract interface for the Jobs Repository.
///
/// Defines the contract for job-related operations, independent of the
/// underlying data source (e.g., API, Mock, Local DB).
abstract class JobsRepository {
  /// Fetches a list of all jobs.
  Future<RepositoryResult<List<JobModel>>> getJobs();

  /// Fetches a specific job by its [id].
  Future<RepositoryResult<JobModel>> getJobById(String id);

  /// Creates a new [job].
  Future<RepositoryResult<JobModel>> createJob(JobModel job);

  /// Updates an existing [job].
  Future<RepositoryResult<JobModel>> updateJob(JobModel job);

  /// Deletes a job by its [id].
  Future<RepositoryResult<void>> deleteJob(String id);

  /// Searches for jobs matching the [query] string.
  Future<RepositoryResult<List<JobModel>>> searchJobs(String query);

  /// Filters jobs based on the provided [filter] criteria.
  Future<RepositoryResult<List<JobModel>>> filterJobs(JobFilter filter);
}
