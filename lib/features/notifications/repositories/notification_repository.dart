import 'dart:async';
import 'package:jobnest/features/notifications/models/notification_item.dart';

class NotificationRepository {
  Future<List<NotificationItem>> loadNotifications({bool forceRefresh = false}) async {
    return List.from(NotificationItem.getDummyNotifications());
  }

  Future<void> saveNotification(NotificationItem item) async {}

  Future<void> deleteNotification(String id) async {}

  Future<void> markRead(String id, {bool read = true}) async {}

  Future<void> markAllRead() async {}

  Future<void> clearAll() async {}
}
