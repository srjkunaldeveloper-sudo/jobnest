import 'package:flutter/foundation.dart';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/candidates_repository.dart';
import '../../data/models/candidate_model.dart';

/// Represents the status of the candidates data fetching.
enum CandidatesStatus {
  initial,
  loading,
  refreshing,
  loaded,
  error,
}

/// Provider responsible for managing the Candidates state and business logic coordination.
class CandidatesProvider extends ChangeNotifier {
  final CandidatesRepository _repository;

  CandidatesStatus _status = CandidatesStatus.initial;
  List<CandidateModel> _candidates = [];
  CandidateModel? _selectedCandidate;
  CandidateFilter? _currentFilter;
  String _searchQuery = '';
  String? _errorMessage;

  CandidatesProvider(this._repository);

  // --- Getters ---

  CandidatesStatus get status => _status;
  List<CandidateModel> get candidates => _candidates;
  CandidateModel? get selectedCandidate => _selectedCandidate;
  CandidateFilter? get currentFilter => _currentFilter;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;

  // --- Private Helpers ---

  void _setStatus(CandidatesStatus status, {String? errorMessage}) {
    _status = status;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void _handleFetchResult(RepositoryResult<List<CandidateModel>> result) {
    if (result.isSuccess) {
      _candidates = result.data ?? [];
      _setStatus(CandidatesStatus.loaded);
    } else {
      _setStatus(
        CandidatesStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to load candidates.',
      );
    }
  }

  Future<void> _fetchData() async {
    if (_searchQuery.isNotEmpty) {
      _handleFetchResult(await _repository.searchCandidates(_searchQuery));
    } else if (_currentFilter != null) {
      _handleFetchResult(await _repository.filterCandidates(_currentFilter!));
    } else {
      _handleFetchResult(await _repository.getCandidates());
    }
  }

  // --- Public Methods ---

  /// Initial load of the candidates data.
  Future<void> loadCandidates() async {
    if (_status == CandidatesStatus.loading) return;
    _setStatus(CandidatesStatus.loading);
    await _fetchData();
  }

  /// Refreshes the candidates data (e.g., via pull-to-refresh).
  Future<void> refresh() async {
    if (_status == CandidatesStatus.refreshing) return;
    _setStatus(CandidatesStatus.refreshing);
    await _fetchData();
  }

  /// Executes a search using the provided [query].
  Future<void> search(String query) async {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _setStatus(CandidatesStatus.loading);
    
    // Clear filter when searching to avoid conflicting state constraints
    _currentFilter = null;
    
    _handleFetchResult(await _repository.searchCandidates(query));
  }

  /// Applies a [CandidateFilter] to the candidates list.
  Future<void> applyFilter(CandidateFilter filter) async {
    _currentFilter = filter;
    _searchQuery = ''; // Reset search query when applying a hard filter
    _setStatus(CandidatesStatus.loading);
    
    _handleFetchResult(await _repository.filterCandidates(filter));
  }

  /// Clears any active filters and reloads all candidates.
  Future<void> clearFilter() async {
    if (_currentFilter == null) return;
    _currentFilter = null;
    await loadCandidates();
  }

  /// Selects a specific candidate (e.g., for viewing details).
  void selectCandidate(CandidateModel? candidate) {
    if (_selectedCandidate?.id == candidate?.id) return;
    _selectedCandidate = candidate;
    notifyListeners();
  }

  /// Creates a new candidate and updates the local state upon success.
  Future<bool> createCandidate(CandidateModel candidate) async {
    _setStatus(CandidatesStatus.loading);
    final result = await _repository.createCandidate(candidate);
    
    if (result.isSuccess && result.data != null) {
      _candidates.insert(0, result.data!);
      _setStatus(CandidatesStatus.loaded);
      return true;
    } else {
      _setStatus(
        CandidatesStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to create candidate.',
      );
      return false;
    }
  }

  /// Updates an existing candidate and synchronizes the local state upon success.
  Future<bool> updateCandidate(CandidateModel candidate) async {
    _setStatus(CandidatesStatus.loading);
    final result = await _repository.updateCandidate(candidate);
    
    if (result.isSuccess && result.data != null) {
      final index = _candidates.indexWhere((c) => c.id == candidate.id);
      if (index != -1) {
        _candidates[index] = result.data!;
      }
      if (_selectedCandidate?.id == candidate.id) {
        _selectedCandidate = result.data;
      }
      _setStatus(CandidatesStatus.loaded);
      return true;
    } else {
      _setStatus(
        CandidatesStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to update candidate.',
      );
      return false;
    }
  }

  /// Deletes a candidate by their [id] and removes them from the local state upon success.
  Future<bool> deleteCandidate(String id) async {
    _setStatus(CandidatesStatus.loading);
    final result = await _repository.deleteCandidate(id);
    
    if (result.isSuccess) {
      _candidates.removeWhere((c) => c.id == id);
      if (_selectedCandidate?.id == id) {
        _selectedCandidate = null;
      }
      _setStatus(CandidatesStatus.loaded);
      return true;
    } else {
      _setStatus(
        CandidatesStatus.error,
        errorMessage: result.errorMessage ?? 'Failed to delete candidate.',
      );
      return false;
    }
  }
}
