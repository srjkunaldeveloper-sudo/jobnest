import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/candidates/repositories/candidate_repository.dart';

class CandidateProvider extends ChangeNotifier {
  final CandidateRepository _repository = CandidateRepository();
  List<CandidateModel> _candidates = [];
  bool _isLoading = false;
  bool _isError = false;

  CandidateProvider() {
    _loadInitialCandidates();
  }

  List<CandidateModel> get candidates => List.unmodifiable(_candidates);
  CandidateModel? candidateById(String? id) {
    if (id == null || id.isEmpty) {
      return null;
    }

    for (final candidate in _candidates) {
      if (candidate.id == id) {
        return candidate;
      }
    }

    return null;
  }

  bool get isLoading => _isLoading || CandidateRepository.dummyLoading;
  bool get isError => _isError || CandidateRepository.dummyError;

  Future<void> _loadInitialCandidates() async {
    _isLoading = true;
    notifyListeners();
    try {
      _candidates = await _repository.loadCandidates();
      _isError = false;
    } catch (e) {
      _isError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCandidates() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();
    await _repository.refresh();
    _candidates = await _repository.loadCandidates();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCandidate(CandidateModel candidate) async {
    await _repository.createCandidate(candidate);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> updateCandidate(CandidateModel candidate) async {
    await _repository.updateCandidate(candidate);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> deleteCandidate(String id) async {
    await _repository.deleteCandidate(id);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> toggleBookmarkCandidate(String id) async {
    await _repository.toggleBookmark(id);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> updateCandidateStage(String id, String newStage) async {
    await _repository.updateCandidateStage(id, newStage);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> bulkUpdateCandidateStage(List<String> ids, String newStage) async {
    await _repository.bulkUpdateCandidateStage(ids, newStage);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> bulkDeleteCandidates(List<String> ids) async {
    await _repository.bulkDeleteCandidates(ids);
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> simulateCandidatesLoading() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();
    await _repository.simulateLoading();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> simulateCandidatesError() async {
    await _repository.simulateError();
    _isError = true;
    notifyListeners();
  }

  Future<void> simulateCandidatesEmpty() async {
    await _repository.simulateEmpty();
    _candidates = await _repository.loadCandidates();
    notifyListeners();
  }

  Future<void> restoreCandidatesDefault({bool notify = true}) async {
    await _repository.restoreDefault();
    _candidates = await _repository.loadCandidates();
    if (notify) notifyListeners();
  }
}
