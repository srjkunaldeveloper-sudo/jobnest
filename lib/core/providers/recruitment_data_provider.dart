import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';

class RecruitmentDataProvider extends ChangeNotifier {
  bool _isDashboardLoading = false;
  bool _isDashboardError = false;

  bool _isJobsLoading = false;
  bool _isJobsError = false;

  bool _isCandidatesLoading = false;
  bool _isCandidatesError = false;

  bool _isNotificationsLoading = false;
  bool _isNotificationsError = false;

  bool get isDashboardLoading => _isDashboardLoading;
  bool get isDashboardError => _isDashboardError;

  bool get isJobsLoading => _isJobsLoading;
  bool get isJobsError => _isJobsError;

  bool get isCandidatesLoading => _isCandidatesLoading;
  bool get isCandidatesError => _isCandidatesError;

  bool get isNotificationsLoading => _isNotificationsLoading;
  bool get isNotificationsError => _isNotificationsError;

  final List<JobModel> _jobs = [];
  final List<CandidateModel> _candidates = [];
  final List<CompanyModel> _companies = [];
  final List<InterviewModel> _interviews = [];
  final List<String> _recentSearches = [];
  final List<String> _trendingSearches = [];
  final List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => List.unmodifiable(_notifications);
  int get unreadNotificationsCount => _notifications.where((n) => !n.isRead).length;

  RecruitmentDataProvider() {
    restoreDefault(notify: false);
  }

  static const List<JobModel> _defaultJobs = [
    JobModel(
      id: 'job_1',
      title: 'Senior Sales Executive',
      company: 'TechCorp India',
      location: 'Delhi, India',
      salary: '₹ 4 - 6 LPA',
      jobType: 'Full Time',
      applicationsCount: '246',
      status: 'Open',
      aiMatchScore: 92,
      isUrgent: true,
      isBookmarked: true,
      postedDate: 'Posted Today',
    ),
    JobModel(
      id: 'job_2',
      title: 'Python Developer',
      company: 'Innovate AI',
      location: 'Bangalore, India',
      salary: '₹ 8 - 10 LPA',
      jobType: 'Remote',
      applicationsCount: '186',
      status: 'Hiring',
      aiMatchScore: 85,
      isUrgent: true,
      isBookmarked: false,
      postedDate: '1 day ago',
    ),
    JobModel(
      id: 'job_3',
      title: 'UI/UX Designer',
      company: 'Creative Studio',
      location: 'Mumbai, India',
      salary: '₹ 5 - 8 LPA',
      jobType: 'Full Time',
      applicationsCount: '142',
      status: 'Paused',
      aiMatchScore: 78,
      isUrgent: false,
      isBookmarked: true,
      postedDate: '3 days ago',
    ),
    JobModel(
      id: 'job_4',
      title: 'Product Manager',
      company: 'NextGen Solutions',
      location: 'Pune, India',
      salary: '₹ 12 - 15 LPA',
      jobType: 'Hybrid',
      applicationsCount: '94',
      status: 'Active',
      aiMatchScore: 88,
      isUrgent: false,
      isBookmarked: false,
      postedDate: '4 days ago',
    ),
    JobModel(
      id: 'job_5',
      title: 'Senior Flutter Developer',
      company: 'Tech Innovators Pvt Ltd',
      location: 'Delhi, India',
      salary: '₹ 15 - 18 LPA',
      jobType: 'Full Time',
      applicationsCount: '310',
      status: 'Closed',
      aiMatchScore: 96,
      isUrgent: false,
      isBookmarked: false,
      postedDate: '1 week ago',
    ),
    JobModel(
      id: 'job_6',
      title: 'NodeJS Architect',
      company: 'CloudScape Systems',
      location: 'Hyderabad, India',
      salary: '₹ 20 - 25 LPA',
      jobType: 'Remote',
      applicationsCount: '65',
      status: 'Draft',
      aiMatchScore: 91,
      isUrgent: false,
      isBookmarked: false,
      postedDate: 'Drafted 2 days ago',
    ),
  ];

  static const List<CandidateModel> _defaultCandidates = [
    CandidateModel(
      id: 'cand_1',
      name: 'Rahul Sharma',
      role: 'Senior Flutter Developer',
      location: 'Delhi, India',
      experience: '5 Years',
      skills: ['Flutter', 'Dart', 'Firebase', 'BLoC'],
      matchPercentage: 94,
      score: 8.5,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 25 - 30 LPA',
      rating: 4.9,
      company: 'Google India',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_2',
      name: 'Priya Singh',
      role: 'Python Backend Engineer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['Python', 'Django', 'PostgreSQL', 'AWS'],
      matchPercentage: 88,
      score: 7.9,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 18 - 22 LPA',
      rating: 4.5,
      company: 'Infosys',
      appliedDate: '3 days ago',
    ),
    CandidateModel(
      id: 'cand_3',
      name: 'Amit Patel',
      role: 'UI/UX Designer',
      location: 'Mumbai, India',
      experience: '3 Years',
      skills: ['Figma', 'Prototyping', 'Wireframing'],
      matchPercentage: 82,
      score: 7.2,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 12 - 15 LPA',
      rating: 4.2,
      company: 'Wipro',
      appliedDate: '1 day ago',
    ),
    CandidateModel(
      id: 'cand_4',
      name: 'Sneha Reddy',
      role: 'Frontend Developer',
      location: 'Remote',
      experience: '2 Years',
      skills: ['React', 'JavaScript', 'HTML/CSS'],
      matchPercentage: 76,
      score: 6.8,
      isNew: true,
      stage: 'Offer',
      expectedSalary: '₹ 15 - 18 LPA',
      rating: 4.7,
      company: 'TCS',
      appliedDate: '5 days ago',
    ),
    CandidateModel(
      id: 'cand_5',
      name: 'Vikram Malhotra',
      role: 'DevOps Engineer',
      location: 'Pune, India',
      experience: '6 Years',
      skills: ['Docker', 'Kubernetes', 'AWS', 'CI/CD'],
      matchPercentage: 91,
      score: 8.8,
      isNew: true,
      stage: 'Hired',
      expectedSalary: '₹ 28 - 35 LPA',
      rating: 4.8,
      company: 'Amazon India',
      appliedDate: '1 week ago',
    ),
    CandidateModel(
      id: 'cand_6',
      name: 'Ananya Iyer',
      role: 'Product Designer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['Figma', 'Design Systems', 'User Research'],
      matchPercentage: 89,
      score: 8.3,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 20 - 25 LPA',
      rating: 4.6,
      company: 'TechCorp India',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_7',
      name: 'Karan Mehta',
      role: 'NodeJS Backend Developer',
      location: 'Hyderabad, India',
      experience: '3 Years',
      skills: ['Node.js', 'Express', 'MongoDB', 'Microservices'],
      matchPercentage: 85,
      score: 7.7,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 14 - 18 LPA',
      rating: 4.3,
      company: 'Flipkart',
      appliedDate: '3 days ago',
    ),
    CandidateModel(
      id: 'cand_8',
      name: 'Divya Nair',
      role: 'Data Scientist',
      location: 'Chennai, India',
      experience: '5 Years',
      skills: ['Python', 'Machine Learning', 'PyTorch', 'SQL'],
      matchPercentage: 92,
      score: 8.6,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 22 - 28 LPA',
      rating: 4.9,
      company: 'Swiggy',
      appliedDate: 'Just now',
    ),
    CandidateModel(
      id: 'cand_9',
      name: 'Rohan Verma',
      role: 'Android Engineer',
      location: 'Delhi, India',
      experience: '4 Years',
      skills: ['Kotlin', 'Android Jetpack', 'Coroutines'],
      matchPercentage: 87,
      score: 7.8,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 16 - 20 LPA',
      rating: 4.4,
      company: 'Paytm',
      appliedDate: '4 days ago',
    ),
    CandidateModel(
      id: 'cand_10',
      name: 'Meera Joshi',
      role: 'QA Automation Lead',
      location: 'Pune, India',
      experience: '6 Years',
      skills: ['Selenium', 'Appium', 'Java', 'CI/CD'],
      matchPercentage: 84,
      score: 7.5,
      isNew: true,
      stage: 'Offer',
      expectedSalary: '₹ 24 - 30 LPA',
      rating: 4.6,
      company: 'Zomato',
      appliedDate: '6 days ago',
    ),
    CandidateModel(
      id: 'cand_11',
      name: 'Siddharth Rao',
      role: 'Full Stack Engineer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['React', 'Node.js', 'GraphQL', 'PostgreSQL'],
      matchPercentage: 90,
      score: 8.4,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 18 - 22 LPA',
      rating: 4.5,
      company: 'Razorpay',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_12',
      name: 'Pooja Desai',
      role: 'Cloud Architect',
      location: 'Mumbai, India',
      experience: '7 Years',
      skills: ['AWS', 'Azure', 'Terraform', 'Kubernetes'],
      matchPercentage: 95,
      score: 9.0,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 30 - 40 LPA',
      rating: 5.0,
      company: 'Microsoft India',
      appliedDate: '1 day ago',
    ),
  ];

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
  List<JobModel> get jobs => List.unmodifiable(_jobs);
  List<CandidateModel> get candidates => List.unmodifiable(_candidates);
  List<CompanyModel> get companies => List.unmodifiable(_companies);
  List<InterviewModel> get interviews => List.unmodifiable(_interviews);
  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  List<String> get trendingSearches => List.unmodifiable(_trendingSearches);

  // Synchronized counts for Today's Focus
  int get todayInterviewsCount => _interviews.where((i) => i.isToday).length;
  int get newCandidatesCount => _candidates.where((c) => c.isNew).length;
  int get urgentJobsCount => _jobs.where((j) => j.isUrgent).length;

  // Dashboard Simulation & Quality Assurance Methods
  Future<void> refreshDashboard() async {
    _isDashboardLoading = true;
    _isDashboardError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    // If data was cleared during empty simulation, restore default dummy data on refresh
    if (_jobs.isEmpty && _candidates.isEmpty && _interviews.isEmpty) {
      restoreDefault(notify: false);
    }

    _isDashboardLoading = false;
    notifyListeners();
  }

  void simulateLoading() {
    _isDashboardLoading = true;
    _isDashboardError = false;
    notifyListeners();

    // Auto-recover after 3 seconds so user isn't locked out during testing
    Future.delayed(const Duration(seconds: 3), () {
      if (_isDashboardLoading) {
        _isDashboardLoading = false;
        notifyListeners();
      }
    });
  }

  void simulateError() {
    _isDashboardLoading = false;
    _isDashboardError = true;
    notifyListeners();
  }

  void simulateEmpty() {
    _isDashboardLoading = false;
    _isDashboardError = false;
    _jobs.clear();
    _candidates.clear();
    _interviews.clear();
    notifyListeners();
  }

  void restoreDefault({bool notify = true}) {
    _isDashboardLoading = false;
    _isDashboardError = false;
    
    _jobs.clear();
    _jobs.addAll(_defaultJobs);
    
    _candidates.clear();
    _candidates.addAll(_defaultCandidates);
    
    _companies.clear();
    _companies.addAll(_defaultCompanies);
    
    _interviews.clear();
    _interviews.addAll(_defaultInterviews);
    
    _recentSearches.clear();
    _recentSearches.addAll(_defaultRecentSearches);
    
    _trendingSearches.clear();
    _trendingSearches.addAll(_defaultTrendingSearches);
    
    _isNotificationsLoading = false;
    _isNotificationsError = false;
    _notifications.clear();
    _notifications.addAll(NotificationItem.getDummyNotifications());

    if (notify) notifyListeners();
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
    _jobs.insert(0, job);
    notifyListeners();
  }

  void deleteJob(String id) {
    _jobs.removeWhere((j) => j.id == id);
    notifyListeners();
  }

  void addCandidate(CandidateModel candidate) {
    _candidates.insert(0, candidate);
    notifyListeners();
  }

  void deleteCandidate(String id) {
    _candidates.removeWhere((c) => c.id == id);
    notifyListeners();
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
  // TODO: Jobs API integration.
  // TODO: Pagination.
  // TODO: Server-side filtering.
  // TODO: Real-time job updates.
  // TODO: Bookmark sync.

  Future<void> refreshJobs() async {
    _isJobsLoading = true;
    _isJobsError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    // If list was cleared during simulation, restore default dummy data
    if (_jobs.isEmpty) {
      _jobs.addAll(_defaultJobs);
    }

    _isJobsLoading = false;
    notifyListeners();
  }

  void simulateJobsLoading() {
    _isJobsLoading = true;
    _isJobsError = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      if (_isJobsLoading) {
        _isJobsLoading = false;
        notifyListeners();
      }
    });
  }

  void simulateJobsError() {
    _isJobsLoading = false;
    _isJobsError = true;
    notifyListeners();
  }

  void simulateJobsEmpty() {
    _isJobsLoading = false;
    _isJobsError = false;
    _jobs.clear();
    notifyListeners();
  }

  void restoreJobsDefault({bool notify = true}) {
    _isJobsLoading = false;
    _isJobsError = false;
    _jobs.clear();
    _jobs.addAll(_defaultJobs);
    if (notify) notifyListeners();
  }

  void toggleBookmarkJob(String id) {
    // TODO: Bookmark sync with backend database.
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobs[idx] = _jobs[idx].copyWith(isBookmarked: !_jobs[idx].isBookmarked);
      notifyListeners();
    }
  }

  void updateJobStatus(String id, String newStatus) {
    // TODO: Real-time job updates with server.
    final idx = _jobs.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobs[idx] = _jobs[idx].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  void duplicateJob(String id) {
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
    }
  }

  // ===== CANDIDATES MODULE ATS METHODS (PHASE 8.3) =====
  // TODO: Candidate API integration.
  // TODO: Resume upload.
  // TODO: Candidate notes sync.
  // TODO: Interview scheduling API.
  // TODO: Candidate stage update API.
  // TODO: Export candidates.

  Future<void> refreshCandidates() async {
    _isCandidatesLoading = true;
    _isCandidatesError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    if (_candidates.isEmpty) {
      _candidates.addAll(_defaultCandidates);
    }

    _isCandidatesLoading = false;
    notifyListeners();
  }

  void simulateCandidatesLoading() {
    _isCandidatesLoading = true;
    _isCandidatesError = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      if (_isCandidatesLoading) {
        _isCandidatesLoading = false;
        notifyListeners();
      }
    });
  }

  void simulateCandidatesError() {
    _isCandidatesLoading = false;
    _isCandidatesError = true;
    notifyListeners();
  }

  void simulateCandidatesEmpty() {
    _isCandidatesLoading = false;
    _isCandidatesError = false;
    _candidates.clear();
    notifyListeners();
  }

  void restoreCandidatesDefault({bool notify = true}) {
    _isCandidatesLoading = false;
    _isCandidatesError = false;
    _candidates.clear();
    _candidates.addAll(_defaultCandidates);
    if (notify) notifyListeners();
  }

  void toggleBookmarkCandidate(String id) {
    // TODO: Candidate notes sync & bookmark persistence.
    final idx = _candidates.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _candidates[idx] = _candidates[idx].copyWith(isBookmarked: !_candidates[idx].isBookmarked);
      notifyListeners();
    }
  }

  void updateCandidateStage(String id, String newStage) {
    // TODO: Candidate stage update API.
    final idx = _candidates.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _candidates[idx] = _candidates[idx].copyWith(stage: newStage);
      notifyListeners();
    }
  }

  void bulkUpdateCandidateStage(List<String> ids, String newStage) {
    // TODO: Candidate stage update API for bulk actions.
    for (final id in ids) {
      final idx = _candidates.indexWhere((c) => c.id == id);
      if (idx != -1) {
        _candidates[idx] = _candidates[idx].copyWith(stage: newStage);
      }
    }
    notifyListeners();
  }

  void bulkDeleteCandidates(List<String> ids) {
    _candidates.removeWhere((c) => ids.contains(c.id));
    notifyListeners();
  }

  // ==========================================
  // NOTIFICATIONS MODULE STATE MANAGEMENT
  // ==========================================
  
  // TODO:
  // Push notifications (FCM).

  // TODO:
  // Real-time notifications.

  // TODO:
  // Notification pagination.

  // TODO:
  // Read status synchronization.

  // TODO:
  // Deep linking.

  void markAllNotificationsAsRead({bool notify = true}) {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    if (notify) notifyListeners();
  }

  void toggleNotificationRead(String id, {bool? read}) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      final targetRead = read ?? !_notifications[idx].isRead;
      _notifications[idx] = _notifications[idx].copyWith(isRead: targetRead);
      notifyListeners();
    }
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void bulkDeleteNotifications(Set<String> ids) {
    _notifications.removeWhere((n) => ids.contains(n.id));
    notifyListeners();
  }

  void bulkMarkReadNotifications(Set<String> ids) {
    for (int i = 0; i < _notifications.length; i++) {
      if (ids.contains(_notifications[i].id)) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
    notifyListeners();
  }

  void clearAllNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  void addNotification(NotificationItem item) {
    _notifications.insert(0, item);
    notifyListeners();
  }

  Future<void> refreshNotifications() async {
    _isNotificationsLoading = true;
    _isNotificationsError = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 600));
    _isNotificationsLoading = false;
    _notifications.clear();
    _notifications.addAll(NotificationItem.getDummyNotifications());
    notifyListeners();
  }

  void restoreNotificationsDefault({bool notify = true}) {
    _isNotificationsLoading = false;
    _isNotificationsError = false;
    _notifications.clear();
    _notifications.addAll(NotificationItem.getDummyNotifications());
    if (notify) notifyListeners();
  }

  void simulateNotificationsLoading() {
    _isNotificationsLoading = true;
    _isNotificationsError = false;
    notifyListeners();
  }

  void simulateNotificationsError() {
    _isNotificationsLoading = false;
    _isNotificationsError = true;
    notifyListeners();
  }

  void simulateNotificationsEmpty() {
    _isNotificationsLoading = false;
    _isNotificationsError = false;
    _notifications.clear();
    notifyListeners();
  }
}
