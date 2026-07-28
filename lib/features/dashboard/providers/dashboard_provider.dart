import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';
import 'package:jobnest/core/providers/recruitment_data_provider.dart';
import 'package:jobnest/features/dashboard/models/models.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';

class DashboardProvider extends ChangeNotifier {
  JobProvider? _jobProvider;
  RecruitmentDataProvider? _recruitmentProvider;

  bool _isLoading = false;
  bool _isError = false;

  final List<DailyTaskItem> _dailyTasks = List.from(DailyTaskItem.getDefaultTasks());
  final List<ActivityTimelineItem> _activityTimeline = List.from(ActivityTimelineItem.getDefaultItems());
  bool _isAnalyticsWeekly = true;
  final HiringProbabilityModel _hiringProbability = HiringProbabilityModel.getDefault();
  final AiAssistantStateModel _aiAssistantState = AiAssistantStateModel.getDefault();
  final List<DashboardQuickAction> _quickActions = List.from(DashboardQuickAction.getDefaultActions());

  void updateDependencies(JobProvider jobProvider, RecruitmentDataProvider recruitmentProvider) {
    _jobProvider = jobProvider;
    _recruitmentProvider = recruitmentProvider;
  }

  // Lifecycle state
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  // Compatibility aliases
  bool get isDashboardLoading => _isLoading;
  bool get isDashboardError => _isError;

  // Aggregated domain collections (delegating to underlying providers without duplicating state)
  List<JobModel> get jobs => _jobProvider?.jobs ?? [];
  List<CandidateModel> get candidates => _recruitmentProvider?.candidates ?? [];
  List<InterviewModel> get interviews => _recruitmentProvider?.interviews ?? [];

  // Dashboard presentation state (Daily Tasks & Activity Timeline)
  List<DailyTaskItem> get dailyTasks => List.unmodifiable(_dailyTasks);
  List<ActivityTimelineItem> get activityTimeline => List.unmodifiable(_activityTimeline);

  // Sprint 4 presentation models
  bool get isAnalyticsWeekly => _isAnalyticsWeekly;
  AnalyticsFunnelModel get analyticsFunnel =>
      _isAnalyticsWeekly ? AnalyticsFunnelModel.getWeeklyDefault() : AnalyticsFunnelModel.getMonthlyDefault();
  HiringProbabilityModel get hiringProbability => _hiringProbability;
  AiAssistantStateModel get aiAssistantState => _aiAssistantState;
  List<DashboardQuickAction> get quickActions => List.unmodifiable(_quickActions);

  // Search chips delegation
  List<String> get trendingSearches => _recruitmentProvider?.trendingSearches ?? [];
  List<String> get recentSearches => _recruitmentProvider?.recentSearches ?? [];

  // Daily Tasks computed statistics for widget rendering
  int get completedTasksCount => _dailyTasks.where((t) => t.isCompleted).length;
  int get totalTasksCount => _dailyTasks.length;
  double get tasksProgress => totalTasksCount > 0 ? completedTasksCount / totalTasksCount : 0.0;

  // Smart Notifications delegation (proxying RecruitmentDataProvider without duplicating state)
  List<NotificationItem> get recentNotifications =>
      (_recruitmentProvider?.notifications ?? []).take(4).toList();

  void toggleTaskCompletion(String taskId) {
    final idx = _dailyTasks.indexWhere((t) => t.id == taskId || t.title == taskId);
    if (idx != -1) {
      _dailyTasks[idx] = _dailyTasks[idx].copyWith(isCompleted: !_dailyTasks[idx].isCompleted);
      notifyListeners();
    }
  }

  void toggleAnalyticsPeriod(bool isWeekly) {
    if (_isAnalyticsWeekly != isWeekly) {
      _isAnalyticsWeekly = isWeekly;
      notifyListeners();
    }
  }

  void submitAiPrompt(String prompt) {
    // State ownership and placeholder for future AI backend integration
    notifyListeners();
  }

  void triggerQuickAction(DashboardAction action) {
    switch (action) {
      case DashboardAction.createJob:
        break;
      case DashboardAction.viewCandidates:
        break;
      case DashboardAction.scheduleInterview:
        break;
      case DashboardAction.messages:
        break;
      case DashboardAction.analytics:
        break;
      case DashboardAction.settings:
        break;
    }
    notifyListeners();
  }

  // Read-only KPI getters (computed and aggregated from underlying domain collections)
  int get jobsCount => jobs.length;

  int get activeJobsCount => jobs.where((j) {
        final s = j.status.toLowerCase();
        return s == 'active' || s == 'open' || s == 'hiring';
      }).length;

  int get urgentJobsCount => jobs.where((j) => j.isUrgent).length;

  int get candidatesCount => candidates.length;

  int get newCandidatesCount => candidates.where((c) => c.isNew).length;

  int get interviewsCount => interviews.length;

  int get todayInterviewsCount => interviews.where((i) => i.isToday).length;

  int get shortlistedCount => (candidatesCount * 0.35).round();

  int get selectedCount => (candidatesCount * 0.12).round();

  // Lifecycle Simulation & Recovery Methods
  Future<void> refreshDashboard() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    final jobsEmpty = _jobProvider?.jobs.isEmpty ?? true;
    final candidatesEmpty = _recruitmentProvider?.candidates.isEmpty ?? true;
    final interviewsEmpty = _recruitmentProvider?.interviews.isEmpty ?? true;

    if (jobsEmpty && candidatesEmpty && interviewsEmpty) {
      await restoreDefault();
    } else {
      _isLoading = false;
      _isError = false;
      notifyListeners();
    }
  }

  void simulateLoading() {
    _isLoading = true;
    _isError = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  void simulateError() {
    _isLoading = false;
    _isError = true;
    notifyListeners();
  }

  void simulateEmpty() {
    _isLoading = false;
    _isError = false;
    _dailyTasks.clear();
    _activityTimeline.clear();
    notifyListeners();
    _jobProvider?.simulateJobsEmpty();
    _recruitmentProvider?.simulateEmpty();
    _recruitmentProvider?.simulateNotificationsEmpty();
  }

  Future<void> restoreDefault() async {
    _isLoading = false;
    _isError = false;
    _dailyTasks.clear();
    _dailyTasks.addAll(DailyTaskItem.getDefaultTasks());
    _activityTimeline.clear();
    _activityTimeline.addAll(ActivityTimelineItem.getDefaultItems());
    notifyListeners();
    await _jobProvider?.restoreJobsDefault(notify: true);
    _recruitmentProvider?.restoreDefault();
    _recruitmentProvider?.restoreNotificationsDefault();
  }
}

