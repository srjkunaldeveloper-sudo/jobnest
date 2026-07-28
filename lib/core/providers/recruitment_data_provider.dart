import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/jobs/repositories/job_repository.dart';
import 'package:jobnest/features/candidates/repositories/candidate_repository.dart';

class RecruitmentDataProvider extends ChangeNotifier {
  final JobRepository _jobRepository = JobRepository();
  final CandidateRepository _candidateRepository = CandidateRepository(); // TEMPORARY COMPATIBILITY

  bool get isJobsLoading => JobRepository.dummyLoading;
  bool get isJobsError => JobRepository.dummyError;

  bool get isCandidatesLoading => CandidateRepository.dummyLoading;
  bool get isCandidatesError => CandidateRepository.dummyError;

  // Candidates list delegated to CandidateRepository for temporary backward compatibility
  List<CandidateModel> get candidates => CandidateRepository.getDummyCandidates();

  final List<CompanyModel> _companies = [];
  final List<InterviewModel> _interviews = [];
  final List<String> _recentSearches = [];
  final List<String> _trendingSearches = [];

  RecruitmentDataProvider() {
    restoreDefault(notify: false);
  }

  // _defaultJobs migrated to JobRepository

  static const List<CompanyModel> _defaultCompanies = [
    CompanyModel(
      id: 'comp_1',
      name: 'TechCorp India',
      industry: 'Information Technology',
      location: 'Delhi, India',
      openPositions: 14,
      description: 'Leading enterprise software solutions provider specializing in cloud infrastructure and scalable backend services.',
    ),
    CompanyModel(
      id: 'comp_2',
      name: 'Innovate AI',
      industry: 'Artificial Intelligence',
      location: 'Bangalore, India',
      openPositions: 8,
      description: 'Pioneering AI research lab building next-generation deep learning models and predictive analytics platforms.',
    ),
    CompanyModel(
      id: 'comp_3',
      name: 'Creative Studio',
      industry: 'Design & Media',
      location: 'Mumbai, India',
      openPositions: 5,
      description: 'Award-winning digital design agency crafting exceptional user experiences and brand identities globally.',
    ),
    CompanyModel(
      id: 'comp_4',
      name: 'NextGen Solutions',
      industry: 'Fintech',
      location: 'Pune, India',
      openPositions: 11,
      description: 'Fast-growing financial technology company empowering modern digital banking and payment workflows.',
    ),
    CompanyModel(
      id: 'comp_5',
      name: 'Tech Innovators Pvt Ltd',
      industry: 'Software Engineering',
      location: 'Delhi, India',
      openPositions: 18,
      description: 'Innovative product studio focused on mobile apps, web platforms, and enterprise recruitment suites.',
    ),
  ];

  static const List<InterviewModel> _defaultInterviews = [
    InterviewModel(
      id: 'int_1',
      candidateName: 'Rahul Sharma',
      role: 'Senior Flutter Developer',
      time: '10:00 AM',
      company: 'Tech Innovators',
      isToday: true,
    ),
    InterviewModel(
      id: 'int_2',
      candidateName: 'Priya Singh',
      role: 'Python Backend Engineer',
      time: '2:30 PM',
      company: 'Innovate AI',
      isToday: true,
    ),
    InterviewModel(
      id: 'int_3',
      candidateName: 'Amit Patel',
      role: 'UI/UX Designer',
      time: '4:00 PM',
      company: 'Creative Studio',
      isToday: true,
    ),
  ];

  static const List<String> _defaultRecentSearches = [
    'Senior Flutter Developer',
    'Product Designer',
    'NodeJS Backend',
  ];

  static const List<String> _defaultTrendingSearches = [
    'Remote Python Jobs',
    'Flutter Developer',
    'UI/UX Lead',
    'Bangalore Candidates',
    'TechCorp India',
    'AI Engineers',
  ];

  // Getters for lists
  List<JobModel> get jobs => List.unmodifiable(JobRepository.getDummyJobs());
  List<CompanyModel> get companies => List.unmodifiable(_companies);
  List<InterviewModel> get interviews => List.unmodifiable(_interviews);
  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  List<String> get trendingSearches => List.unmodifiable(_trendingSearches);

  // Synchronized counts for Today's Focus
  int get todayInterviewsCount => _interviews.where((i) => i.isToday).length;
  int get newCandidatesCount => candidates.where((c) => c.isNew).length;
  int get urgentJobsCount => jobs.where((j) => j.isUrgent).length;

  // Legacy compatibility methods (simulateEmpty / restoreDefault) for non-dashboard domains
  void simulateEmpty() {
    _jobRepository.simulateEmpty();
    _candidateRepository.simulateEmpty().then((_) => notifyListeners());
    _interviews.clear();
    notifyListeners();
  }

  void restoreDefault({bool notify = true}) {
    _jobRepository.restoreDefault();
    _candidateRepository.restoreDefault().then((_) {
      if (notify) notifyListeners();
    });
    
    _companies.clear();
    _companies.addAll(_defaultCompanies);
    
    _interviews.clear();
    _interviews.addAll(_defaultInterviews);
    
    _recentSearches.clear();
    _recentSearches.addAll(_defaultRecentSearches);
    
    _trendingSearches.clear();
    _trendingSearches.addAll(_defaultTrendingSearches);
  }

  // Actions for Recent Searches (Maximum 5)
  void addRecentSearch(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;
    
    _recentSearches.removeWhere((item) => item.toLowerCase() == cleanQuery.toLowerCase());
    _recentSearches.insert(0, cleanQuery);
    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }
    notifyListeners();
  }

  void deleteRecentSearch(String query) {
    _recentSearches.removeWhere((item) => item.toLowerCase() == query.trim().toLowerCase());
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  // Actions for Data Synchronization
  void addJob(JobModel job) {
    _jobRepository.createJob(job);
    notifyListeners();
  }

  void deleteJob(String id) {
    _jobRepository.deleteJob(id);
    notifyListeners();
  }

  void addCandidate(CandidateModel candidate) {
    _candidateRepository.createCandidate(candidate).then((_) => notifyListeners());
  }

  void deleteCandidate(String id) {
    _candidateRepository.deleteCandidate(id).then((_) => notifyListeners());
  }

  void addInterview(InterviewModel interview) {
    _interviews.insert(0, interview);
    notifyListeners();
  }

  void deleteInterview(String id) {
    _interviews.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  // ===== JOBS MODULE ATS METHODS (PHASE 8.2) =====
  Future<void> refreshJobs() async {
    await _jobRepository.refresh();
    notifyListeners();
  }

  void simulateJobsLoading() {
    _jobRepository.simulateLoading();
    notifyListeners();
  }

  void simulateJobsError() {
    _jobRepository.simulateError();
    notifyListeners();
  }

  void simulateJobsEmpty() {
    _jobRepository.simulateEmpty();
    notifyListeners();
  }

  void restoreJobsDefault({bool notify = true}) {
    _jobRepository.restoreDefault();
    if (notify) notifyListeners();
  }

  void toggleBookmarkJob(String id) {
    _jobRepository.toggleBookmark(id);
    notifyListeners();
  }

  void updateJobStatus(String id, String newStatus) {
    final idx = jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobRepository.updateJob(jobs[idx].copyWith(status: newStatus));
      notifyListeners();
    }
  }

  void duplicateJob(String id) {
    _jobRepository.duplicateJob(id);
    notifyListeners();
  }

  // ===== CANDIDATES MODULE ATS METHODS (PHASE 8.3) =====
  Future<void> refreshCandidates() async {
    await _candidateRepository.refresh();
    notifyListeners();
  }

  void simulateCandidatesLoading() {
    _candidateRepository.simulateLoading().then((_) => notifyListeners());
  }

  void simulateCandidatesError() {
    _candidateRepository.simulateError().then((_) => notifyListeners());
  }

  void simulateCandidatesEmpty() {
    _candidateRepository.simulateEmpty().then((_) => notifyListeners());
  }

  void restoreCandidatesDefault({bool notify = true}) {
    _candidateRepository.restoreDefault().then((_) {
      if (notify) notifyListeners();
    });
  }

  void toggleBookmarkCandidate(String id) {
    _candidateRepository.toggleBookmark(id).then((_) => notifyListeners());
  }

  void updateCandidateStage(String id, String newStage) {
    _candidateRepository.updateCandidateStage(id, newStage).then((_) => notifyListeners());
  }

  void bulkUpdateCandidateStage(List<String> ids, String newStage) {
    _candidateRepository.bulkUpdateCandidateStage(ids, newStage).then((_) => notifyListeners());
  }

  void bulkDeleteCandidates(List<String> ids) {
    _candidateRepository.bulkDeleteCandidates(ids).then((_) => notifyListeners());
  }
}
