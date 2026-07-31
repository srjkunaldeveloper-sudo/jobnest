import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart' show Icons;
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../models/dashboard_summary.dart';
import '../../models/quick_action_model.dart';
import '../../models/recent_activity_model.dart';
import '../../models/notification_model.dart';

/// A mock implementation of [DashboardRepository] returning fake ATS data.
class MockDashboardRepository implements DashboardRepository {
  @override
  Future<RepositoryResult<DashboardSummary>> getDashboardSummary() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return RepositoryResult.success(
      const DashboardSummary(
        totalJobs: 42,
        activeJobs: 15,
        totalCandidates: 1250,
        shortlistedCandidates: 84,
        interviewsToday: 6,
        hiredCandidates: 3,
      ),
    );
  }

  @override
  Future<RepositoryResult<List<QuickActionModel>>> getQuickActions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return RepositoryResult.success([
      QuickActionModel(
        id: 'qa_1',
        title: 'Post a Job',
        icon: AppIcons.work_outline,
        route: '/jobs/create',
        enabled: true,
      ),
      QuickActionModel(
        id: 'qa_2',
        title: 'Add Candidate',
        icon: AppIcons.person_add_outlined,
        route: '/candidates/add',
        enabled: true,
      ),
      QuickActionModel(
        id: 'qa_3',
        title: 'Interviews',
        icon: AppIcons.calendar_today_outlined,
        route: '/interviews',
        enabled: true,
      ),
      QuickActionModel(
        id: 'qa_4',
        title: 'Reports',
        icon: AppIcons.bar_chart_outlined,
        route: '/reports',
        enabled: false,
      ),
    ]);
  }

  @override
  Future<RepositoryResult<List<RecentActivityModel>>> getRecentActivities() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return RepositoryResult.success([
      RecentActivityModel(
        id: 'act_1',
        title: 'New Application',
        description: 'Sarah Jenkins applied for Senior UX Designer.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        type: 'application',
      ),
      RecentActivityModel(
        id: 'act_2',
        title: 'Interview Scheduled',
        description: 'Interview with Michael Chen for Lead Engineer.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'interview',
      ),
      RecentActivityModel(
        id: 'act_3',
        title: 'Candidate Shortlisted',
        description: 'Emily Davis was shortlisted for Product Manager.',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        type: 'candidate',
      ),
    ]);
  }

  @override
  Future<RepositoryResult<List<NotificationModel>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return RepositoryResult.success([
      NotificationModel(
        id: 'notif_1',
        title: 'Feedback Required',
        message: 'Please provide feedback for John Doe\'s interview.',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: 'notif_2',
        title: 'New Message',
        message: 'You have a new message from a candidate.',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ]);
  }
}
