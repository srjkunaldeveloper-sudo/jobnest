import 'package:flutter/foundation.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_state.dart';

/// Provider responsible for managing the Dashboard state and orchestrating data fetching.
class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository;
  DashboardState _state = const DashboardState();

  DashboardProvider(this._repository);

  /// Exposes the current dashboard state.
  DashboardState get state => _state;

  void _setState(DashboardState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Initial load of the dashboard data.
  Future<void> loadDashboard() async {
    if (_state.status == DashboardStatus.loading) return;
    _setState(_state.copyWith(status: DashboardStatus.loading, clearError: true));
    await _fetchData();
  }

  /// Refreshes the dashboard data (typically via pull-to-refresh).
  Future<void> refreshDashboard() async {
    if (_state.status == DashboardStatus.refreshing) return;
    _setState(_state.copyWith(status: DashboardStatus.refreshing, clearError: true));
    await _fetchData();
  }

  /// Clears any existing error messages.
  void clearError() {
    if (_state.errorMessage != null) {
      _setState(_state.copyWith(clearError: true));
    }
  }

  /// Internal method to fetch all dashboard data concurrently using Future.wait.
  Future<void> _fetchData() async {
    try {
      final summaryFuture = _repository.getDashboardSummary();
      final quickActionsFuture = _repository.getQuickActions();
      final activitiesFuture = _repository.getRecentActivities();
      final notificationsFuture = _repository.getNotifications();

      // Wait for all requests to complete concurrently
      await Future.wait([
        summaryFuture,
        quickActionsFuture,
        activitiesFuture,
        notificationsFuture,
      ]);

      // Await again to get the strongly-typed results securely without re-triggering requests
      final summaryResult = await summaryFuture;
      final quickActionsResult = await quickActionsFuture;
      final activitiesResult = await activitiesFuture;
      final notificationsResult = await notificationsFuture;

      // Check if any of the concurrent calls failed
      if (!summaryResult.isSuccess ||
          !quickActionsResult.isSuccess ||
          !activitiesResult.isSuccess ||
          !notificationsResult.isSuccess) {
        final error = summaryResult.errorMessage ??
            quickActionsResult.errorMessage ??
            activitiesResult.errorMessage ??
            notificationsResult.errorMessage ??
            'Failed to load dashboard data.';

        _setState(_state.copyWith(
          status: DashboardStatus.error,
          errorMessage: error,
        ));
        return;
      }

      // Successful fetch, update state with loaded data
      _setState(_state.copyWith(
        status: DashboardStatus.loaded,
        summary: summaryResult.data,
        quickActions: quickActionsResult.data,
        recentActivities: activitiesResult.data,
        notifications: notificationsResult.data,
        clearError: true,
      ));
    } catch (e) {
      _setState(_state.copyWith(
        status: DashboardStatus.error,
        errorMessage: 'An unexpected error occurred while fetching dashboard data.',
      ));
    }
  }
}
