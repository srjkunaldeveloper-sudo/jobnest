import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobnest/features/notifications/models/notification_item.dart';
import 'package:jobnest/features/notifications/repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repository;
  final List<NotificationItem> _notifications = List.from(NotificationItem.getDummyNotifications());
  bool _isLoading = false;
  bool _isError = false;

  NotificationProvider({NotificationRepository? repository})
      : _repository = repository ?? NotificationRepository() {
    loadNotifications(notify: false);
  }

  List<NotificationItem> get notifications => List.unmodifiable(_notifications);
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  int get unreadNotificationsCount => _notifications.where((n) => !n.isRead).length;

  Future<void> loadNotifications({bool notify = true}) async {
    _isLoading = true;
    _isError = false;
    if (notify) notifyListeners();

    try {
      final items = await _repository.loadNotifications();
      _notifications.clear();
      _notifications.addAll(items);
      _isLoading = false;
      if (notify) notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isError = true;
      if (notify) notifyListeners();
    }
  }

  Future<void> refreshNotifications() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    try {
      final items = await _repository.loadNotifications();
      _notifications.clear();
      _notifications.addAll(items);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isError = true;
      notifyListeners();
    }
  }

  Future<void> addNotification(NotificationItem item) async {
    _notifications.insert(0, item);
    notifyListeners();
    await _repository.saveNotification(item);
  }

  Future<void> deleteNotification(String id) async {
    final initialLength = _notifications.length;
    _notifications.removeWhere((n) => n.id == id);
    if (_notifications.length != initialLength) {
      notifyListeners();
      await _repository.deleteNotification(id);
    }
  }

  Future<void> clearAllNotifications() async {
    if (_notifications.isNotEmpty) {
      _notifications.clear();
      notifyListeners();
      await _repository.clearAll();
    }
  }

  Future<void> markAllNotificationsAsRead({bool notify = true}) async {
    bool hasUnread = false;
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
        hasUnread = true;
      }
    }
    if (hasUnread) {
      if (notify) notifyListeners();
      await _repository.markAllRead();
    }
  }

  Future<void> toggleNotificationRead(String id, {bool? read}) async {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      final targetRead = read ?? !_notifications[idx].isRead;
      if (_notifications[idx].isRead != targetRead) {
        _notifications[idx] = _notifications[idx].copyWith(isRead: targetRead);
        notifyListeners();
        await _repository.markRead(id, read: targetRead);
      }
    }
  }

  Future<void> bulkDeleteNotifications(Set<String> ids) async {
    if (ids.isEmpty || _notifications.isEmpty) return;
    final initialLength = _notifications.length;
    _notifications.removeWhere((n) => ids.contains(n.id));
    if (_notifications.length != initialLength) {
      notifyListeners();
      for (final id in ids) {
        await _repository.deleteNotification(id);
      }
    }
  }

  Future<void> bulkMarkReadNotifications(Set<String> ids) async {
    if (ids.isEmpty || _notifications.isEmpty) return;
    bool hasChanged = false;
    for (int i = 0; i < _notifications.length; i++) {
      if (ids.contains(_notifications[i].id) && !_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
        hasChanged = true;
      }
    }
    if (hasChanged) {
      notifyListeners();
      for (final id in ids) {
        await _repository.markRead(id, read: true);
      }
    }
  }

  Future<void> restoreNotificationsDefault({bool notify = true}) async {
    _isLoading = false;
    _isError = false;
    final items = await _repository.loadNotifications();
    _notifications.clear();
    _notifications.addAll(items);
    if (notify) notifyListeners();
  }

  void simulateNotificationsLoading() {
    if (!_isLoading || _isError) {
      _isLoading = true;
      _isError = false;
      notifyListeners();
    }
  }

  void simulateNotificationsError() {
    if (!_isError || _isLoading) {
      _isLoading = false;
      _isError = true;
      notifyListeners();
    }
  }

  Future<void> simulateNotificationsEmpty() async {
    final stateChanged = _isLoading || _isError || _notifications.isNotEmpty;
    _isLoading = false;
    _isError = false;
    if (_notifications.isNotEmpty) {
      _notifications.clear();
    }
    if (stateChanged) {
      notifyListeners();
      await _repository.clearAll();
    }
  }
}
