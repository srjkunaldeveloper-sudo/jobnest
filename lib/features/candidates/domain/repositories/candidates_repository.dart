import '../../../../core/repositories/repository_result.dart';
import '../../data/models/candidate_model.dart';

/// Represents the filter criteria for querying candidates.
class CandidateFilter {
  final String? department;
  final String? status;
  final String? location;
  final String? experience;
  final bool? hasResume;

  const CandidateFilter({
    this.department,
    this.status,
    this.location,
    this.experience,
    this.hasResume,
  });

  /// Creates a copy of this filter with the given fields replaced by new values.
  CandidateFilter copyWith({
    String? department,
    String? status,
    String? location,
    String? experience,
    bool? hasResume,
    bool clearDepartment = false,
    bool clearStatus = false,
    bool clearLocation = false,
    bool clearExperience = false,
    bool clearHasResume = false,
  }) {
    return CandidateFilter(
      department: clearDepartment ? null : (department ?? this.department),
      status: clearStatus ? null : (status ?? this.status),
      location: clearLocation ? null : (location ?? this.location),
      experience: clearExperience ? null : (experience ?? this.experience),
      hasResume: clearHasResume ? null : (hasResume ?? this.hasResume),
    );
  }
}

/// Abstract interface for the Candidates Repository.
///
/// Defines the contract for candidate-related operations, independent of the
/// underlying data source (e.g., API, Mock, Local DB).
abstract class CandidatesRepository {
  /// Fetches a list of all candidates.
  Future<RepositoryResult<List<CandidateModel>>> getCandidates();

  /// Fetches a specific candidate by their [id].
  Future<RepositoryResult<CandidateModel>> getCandidateById(String id);

  /// Creates a new [candidate].
  Future<RepositoryResult<CandidateModel>> createCandidate(CandidateModel candidate);

  /// Updates an existing [candidate].
  Future<RepositoryResult<CandidateModel>> updateCandidate(CandidateModel candidate);

  /// Deletes a candidate by their [id].
  Future<RepositoryResult<void>> deleteCandidate(String id);

  /// Searches for candidates matching the [query] string.
  Future<RepositoryResult<List<CandidateModel>>> searchCandidates(String query);

  /// Filters candidates based on the provided [filter] criteria.
  Future<RepositoryResult<List<CandidateModel>>> filterCandidates(CandidateFilter filter);
}
