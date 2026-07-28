import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/repositories/job_repository.dart';

class JobProvider extends ChangeNotifier {
  final JobRepository _repository;
  final List<JobModel> _jobs = List.from(JobRepository.getDummyJobs());
  bool _isLoading = false;
  bool _isError = false;

  JobProvider({JobRepository? repository})
      : _repository = repository ?? JobRepository() {
    loadJobs(notify: false);
  }

  // State Getters
  List<JobModel> get jobs => List.unmodifiable(_jobs);
  bool get isLoading => _isLoading;
  bool get isJobsLoading => _isLoading; // Compatibility alias
  bool get isError => _isError;
  bool get isJobsError => _isError; // Compatibility alias
  int get urgentJobsCount => _jobs.where((j) => j.isUrgent).length;

  // Repository Communication & CRUD
  Future<void> loadJobs({bool notify = true}) async {
    _isLoading = true;
    _isError = false;
    if (notify) notifyListeners();

    try {
      final items = await _repository.loadJobs();
      _jobs.clear();
      _jobs.addAll(items);
      _isLoading = false;
      if (notify) notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isError = true;
      if (notify) notifyListeners();
    }
  }

  Future<void> createJob(JobModel job) async {
    _jobs.insert(0, job);
    notifyListeners();
    await _repository.createJob(job);
  }

  Future<void> addJob(JobModel job) => createJob(job);

  Future<void> updateJob(JobModel updatedJob) async {
    final idx = _jobs.indexWhere((j) => j.id == updatedJob.id);
    if (idx != -1) {
      _jobs[idx] = updatedJob;
      notifyListeners();
      await _repository.updateJob(updatedJob);
    }
  }

  Future<void> deleteJob(String id) async {
    final initialLength = _jobs.length;
    _jobs.removeWhere((j) => j.id == id);
    if (_jobs.length != initialLength) {
      notifyListeners();
      await _repository.deleteJob(id);
    }
  }

  Future<void> archiveJob(String id) async {
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobs[idx] = _jobs[idx].copyWith(status: 'Closed');
      notifyListeners();
      await _repository.archiveJob(id);
    }
  }

  Future<void> duplicateJob(String id) async {
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      final orig = _jobs[idx];
      final newJob = orig.copyWith(
        id: 'job_copy_${DateTime.now().millisecondsSinceEpoch}',
        title: '${orig.title} (Copy)',
        status: 'Draft',
        applicationsCount: '0',
        postedDate: 'Drafted Just Now',
        isBookmarked: false,
      );
      _jobs.insert(0, newJob);
      notifyListeners();
      await _repository.duplicateJob(id);
    }
  }

  Future<void> toggleBookmark(String id) async {
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobs[idx] = _jobs[idx].copyWith(isBookmarked: !_jobs[idx].isBookmarked);
      notifyListeners();
      await _repository.toggleBookmark(id);
    }
  }

  Future<void> toggleBookmarkJob(String id) => toggleBookmark(id);

  void updateJobStatus(String id, String newStatus) {
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobs[idx] = _jobs[idx].copyWith(status: newStatus);
      notifyListeners();
      _repository.updateJob(_jobs[idx]);
    }
  }

  // QA Simulation Methods & Lifecycle
  Future<void> refresh() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    try {
      await _repository.refresh();
      final items = await _repository.loadJobs();
      _jobs.clear();
      _jobs.addAll(items);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isError = true;
      notifyListeners();
    }
  }

  Future<void> refreshJobs() => refresh();

  void simulateLoading() {
    _isLoading = true;
    _isError = false;
    notifyListeners();
    _repository.simulateLoading();

    Future.delayed(const Duration(seconds: 3), () {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  void simulateJobsLoading() => simulateLoading();

  void simulateError() {
    _isLoading = false;
    _isError = true;
    notifyListeners();
    _repository.simulateError();
  }

  void simulateJobsError() => simulateError();

  void simulateEmpty() {
    _isLoading = false;
    _isError = false;
    _jobs.clear();
    notifyListeners();
    _repository.simulateEmpty();
  }

  void simulateJobsEmpty() => simulateEmpty();

  Future<void> restoreDefault({bool notify = true}) async {
    _isLoading = false;
    _isError = false;
    await _repository.restoreDefault();
    final items = await _repository.loadJobs();
    _jobs.clear();
    _jobs.addAll(items);
    if (notify) notifyListeners();
  }

  Future<void> restoreJobsDefault({bool notify = true}) => restoreDefault(notify: notify);
}
