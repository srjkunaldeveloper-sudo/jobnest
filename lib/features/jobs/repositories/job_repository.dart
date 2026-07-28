import 'dart:async';
import 'package:jobnest/core/models/recruitment_models.dart';

class JobRepository {
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

  static final List<JobModel> _jobsStore = List.from(_defaultJobs);
  static bool _isLoadingState = false;
  static bool _isErrorState = false;

  static List<JobModel> getDummyJobs() => _jobsStore;
  static bool get dummyLoading => _isLoadingState;
  static bool get dummyError => _isErrorState;

  Future<List<JobModel>> loadJobs({bool forceRefresh = false}) async {
    return List.from(_jobsStore);
  }

  Future<void> createJob(JobModel job) async {
    _jobsStore.insert(0, job);
  }

  Future<void> updateJob(JobModel job) async {
    final idx = _jobsStore.indexWhere((j) => j.id == job.id);
    if (idx != -1) {
      _jobsStore[idx] = job;
    }
  }

  Future<void> deleteJob(String id) async {
    _jobsStore.removeWhere((j) => j.id == id);
  }

  Future<void> archiveJob(String id) async {
    final idx = _jobsStore.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobsStore[idx] = _jobsStore[idx].copyWith(status: 'Closed');
    }
  }

  Future<void> duplicateJob(String id) async {
    final idx = _jobsStore.indexWhere((j) => j.id == id);
    if (idx != -1) {
      final orig = _jobsStore[idx];
      final newJob = orig.copyWith(
        id: 'job_copy_${DateTime.now().millisecondsSinceEpoch}',
        title: '${orig.title} (Copy)',
        status: 'Draft',
        applicationsCount: '0',
        postedDate: 'Drafted Just Now',
        isBookmarked: false,
      );
      _jobsStore.insert(0, newJob);
    }
  }

  Future<void> toggleBookmark(String id) async {
    final idx = _jobsStore.indexWhere((j) => j.id == id);
    if (idx != -1) {
      _jobsStore[idx] = _jobsStore[idx].copyWith(isBookmarked: !_jobsStore[idx].isBookmarked);
    }
  }

  Future<void> refresh() async {
    _isLoadingState = true;
    _isErrorState = false;
    await Future.delayed(const Duration(milliseconds: 600));
    if (_jobsStore.isEmpty) {
      _jobsStore.addAll(_defaultJobs);
    }
    _isLoadingState = false;
  }

  Future<void> restoreDefault() async {
    _isLoadingState = false;
    _isErrorState = false;
    _jobsStore.clear();
    _jobsStore.addAll(_defaultJobs);
  }

  Future<void> simulateLoading() async {
    _isLoadingState = true;
    _isErrorState = false;
    Future.delayed(const Duration(seconds: 3), () {
      _isLoadingState = false;
    });
  }

  Future<void> simulateError() async {
    _isLoadingState = false;
    _isErrorState = true;
  }

  Future<void> simulateEmpty() async {
    _isLoadingState = false;
    _isErrorState = false;
    _jobsStore.clear();
  }
}
