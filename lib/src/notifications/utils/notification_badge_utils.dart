import 'package:flutter/foundation.dart';

class NotificationBadgeUtils extends ChangeNotifier implements ValueListenable<int?> {
  NotificationBadgeUtils._();

  static NotificationBadgeUtils? _instance;

  static NotificationBadgeUtils get instance => _instance ??= NotificationBadgeUtils._();

  int? _notificationCount;

  int? get notificationCount => _notificationCount;

  bool get hasNotifications => _notificationCount != null && _notificationCount! > 0;

  void setNotificationCount(int? count) {
    _notificationCount = count;
    notifyListeners();
  }

  void increseNotificationCount() {
    _notificationCount = (_notificationCount ?? 0) + 1;
    notifyListeners();
  }

  // void init() {
  //   super.dispose();
  //   _instance = null;
  // }

  // @override
  // void dispose() {
  //   _instance = null;
  //   super.dispose();
  // }

  @override
  int? get value => _notificationCount;
}
