import '../../../../core/network/api_client.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../../../core/repositories/repository_result.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../models/dashboard_summary.dart';
import '../../models/quick_action_model.dart';
import '../../models/recent_activity_model.dart';
import '../../models/notification_model.dart';

/// The real API implementation of [DashboardRepository].
class ApiDashboardRepository extends BaseRepository implements DashboardRepository {
  final ApiClient _apiClient;

  ApiDashboardRepository(this._apiClient);

  @override
  Future<RepositoryResult<DashboardSummary>> getDashboardSummary() {
    throw UnimplementedError('API getDashboardSummary is not yet implemented.');
  }

  @override
  Future<RepositoryResult<List<QuickActionModel>>> getQuickActions() {
    throw UnimplementedError('API getQuickActions is not yet implemented.');
  }

  @override
  Future<RepositoryResult<List<RecentActivityModel>>> getRecentActivities() {
    throw UnimplementedError('API getRecentActivities is not yet implemented.');
  }

  @override
  Future<RepositoryResult<List<NotificationModel>>> getNotifications() {
    throw UnimplementedError('API getNotifications is not yet implemented.');
  }
}
