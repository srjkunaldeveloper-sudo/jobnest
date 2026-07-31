import '../../../../core/repositories/repository_result.dart';
import '../../models/dashboard_summary.dart';
import '../../models/quick_action_model.dart';
import '../../models/recent_activity_model.dart';
import '../../models/notification_model.dart';

/// Abstract interface for the Dashboard Repository.
abstract class DashboardRepository {
  /// Fetches the high-level summary statistics for the dashboard.
  Future<RepositoryResult<DashboardSummary>> getDashboardSummary();

  /// Fetches the list of quick actions available to the user.
  Future<RepositoryResult<List<QuickActionModel>>> getQuickActions();

  /// Fetches the recent activity timeline.
  Future<RepositoryResult<List<RecentActivityModel>>> getRecentActivities();

  /// Fetches the latest notifications for the user.
  Future<RepositoryResult<List<NotificationModel>>> getNotifications();
}
