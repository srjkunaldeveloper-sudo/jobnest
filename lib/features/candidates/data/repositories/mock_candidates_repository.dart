import 'dart:async';
import '../../../../shared/api_exception.dart';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/candidates_repository.dart';
import '../models/candidate_model.dart';
import 'mock_candidates_data.dart';

/// A mock implementation of [CandidatesRepository] for testing and development.
class MockCandidatesRepository implements CandidatesRepository {
  // Use a private in-memory mutable list initialized from the external mock data file
  final List<CandidateModel> _candidates = List.from(mockCandidatesData);

  /// Simulates network latency for API calls
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<RepositoryResult<List<CandidateModel>>> getCandidates() async {
    await _simulateDelay();
    return RepositoryResult.success(List.unmodifiable(_candidates));
  }

  @override
  Future<RepositoryResult<CandidateModel>> getCandidateById(String id) async {
    await _simulateDelay();
    try {
      final candidate = _candidates.firstWhere((c) => c.id == id);
      return RepositoryResult.success(candidate);
    } catch (e) {
      return RepositoryResult.failure(
        'Candidate not found',
        exception: ApiException(message: 'Candidate not found', statusCode: 404),
      );
    }
  }

  @override
  Future<RepositoryResult<CandidateModel>> createCandidate(CandidateModel candidate) async {
    await _simulateDelay();
    
    // Simulate backend ID generation
    final newId = 'cand_${DateTime.now().millisecondsSinceEpoch}';
    final newCandidate = candidate.copyWith(
      id: newId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _candidates.add(newCandidate);
    return RepositoryResult.success(newCandidate);
  }

  @override
  Future<RepositoryResult<CandidateModel>> updateCandidate(CandidateModel candidate) async {
    await _simulateDelay();
    
    final index = _candidates.indexWhere((c) => c.id == candidate.id);
    if (index == -1) {
      return RepositoryResult.failure(
        'Candidate not found for update',
        exception: ApiException(message: 'Candidate not found for update', statusCode: 404),
      );
    }
    
    final updatedCandidate = candidate.copyWith(updatedAt: DateTime.now());
    _candidates[index] = updatedCandidate;
    
    return RepositoryResult.success(updatedCandidate);
  }

  @override
  Future<RepositoryResult<void>> deleteCandidate(String id) async {
    await _simulateDelay();
    
    final index = _candidates.indexWhere((c) => c.id == id);
    if (index == -1) {
      return RepositoryResult.failure(
        'Candidate not found for deletion',
        exception: ApiException(message: 'Candidate not found for deletion', statusCode: 404),
      );
    }
    
    _candidates.removeAt(index);
    return RepositoryResult.success(null);
  }

  @override
  Future<RepositoryResult<List<CandidateModel>>> searchCandidates(String query) async {
    await _simulateDelay();
    
    if (query.trim().isEmpty) {
      return RepositoryResult.success(List.unmodifiable(_candidates));
    }

    final lowercaseQuery = query.toLowerCase();
    
    // Case-insensitive search on multiple fields
    final filtered = _candidates.where((candidate) {
      return candidate.firstName.toLowerCase().contains(lowercaseQuery) ||
          candidate.lastName.toLowerCase().contains(lowercaseQuery) ||
          candidate.jobTitle.toLowerCase().contains(lowercaseQuery) ||
          candidate.department.toLowerCase().contains(lowercaseQuery) ||
          candidate.skills.any((skill) => skill.toLowerCase().contains(lowercaseQuery));
    }).toList();
    
    return RepositoryResult.success(List.unmodifiable(filtered));
  }

  @override
  Future<RepositoryResult<List<CandidateModel>>> filterCandidates(CandidateFilter filter) async {
    await _simulateDelay();
    
    final filtered = _candidates.where((candidate) {
      bool matches = true;
      
      if (filter.department != null && filter.department!.isNotEmpty) {
        matches = matches && candidate.department == filter.department;
      }
      
      if (filter.status != null && filter.status!.isNotEmpty) {
        matches = matches && candidate.status == filter.status;
      }
      
      if (filter.location != null && filter.location!.isNotEmpty) {
        matches = matches && candidate.location == filter.location;
      }
      
      if (filter.experience != null && filter.experience!.isNotEmpty) {
        matches = matches && candidate.experience == filter.experience;
      }
      
      if (filter.hasResume != null) {
        final candidateHasResume = candidate.resumeUrl != null && candidate.resumeUrl!.isNotEmpty;
        matches = matches && candidateHasResume == filter.hasResume;
      }
      
      return matches;
    }).toList();

    return RepositoryResult.success(List.unmodifiable(filtered));
  }
}
