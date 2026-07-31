import '../../models/dashboard_summary.dart';
import '../../models/quick_action_model.dart';
import '../../models/recent_activity_model.dart';
import '../../models/notification_model.dart';

/// Represents the status of the dashboard data fetching.
enum DashboardStatus {
  initial,
  loading,
  refreshing,
  loaded,
  error,
}

/// Holds the dashboard state including data and error messages.
class DashboardState {
  final DashboardStatus status;
  final DashboardSummary? summary;
  final List<QuickActionModel> quickActions;
  final List<RecentActivityModel> recentActivities;
  final List<NotificationModel> notifications;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.summary,
    this.quickActions = const [],
    this.recentActivities = const [],
    this.notifications = const [],
    this.errorMessage,
  });

  /// Creates a copy of this state with new values, specifically allowing error clearance.
  DashboardState copyWith({
    DashboardStatus? status,
    DashboardSummary? summary,
    List<QuickActionModel>? quickActions,
    List<RecentActivityModel>? recentActivities,
    List<NotificationModel>? notifications,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DashboardState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      quickActions: quickActions ?? this.quickActions,
      recentActivities: recentActivities ?? this.recentActivities,
      notifications: notifications ?? this.notifications,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
