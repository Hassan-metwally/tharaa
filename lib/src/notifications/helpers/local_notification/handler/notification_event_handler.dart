import 'package:flutter/material.dart';

class NotificationEventHandler {
  NotificationEventHandler._();

  static NotificationEventHandler? _instance;
  static NotificationEventHandler get instance => _instance ??= NotificationEventHandler._();

  void onFireBaseNotificationPressed(Map<String, dynamic> data) {
    try {
      // final notificationId = data['notification_id'];
      // final notificationType = data['type'];
      // log("::: ${notificationId != null && notificationType != null} :::",
      //     name: "is correct");
      // if (notificationId != null && notificationType != null) {
      //   final typeEnum = NotificationType.fromJson(notificationType);

      //   log("::: $typeEnum :::", name: "notification type");

      // onPress(
      //   type: typeEnum,
      //   id: notificationId,
      //   isFirebaseNotificationTap: true,
      // );
      // }
    } catch (e) {
      debugPrint("Failed to parse notification data on [NotificationEventHandler] :\n $e");
    }
  }

  static void onPress(
    // {
    // required NotificationType type,
    // required String id,
    // bool isFirebaseNotificationTap = false,
    // }
  ) {
    // if (id.isNotEmpty && type != NotificationType.admin) {
    //   if (isFirebaseNotificationTap) AppRouter.popUntil();
    //   MainPageBottomNavTabsSubscription.pushUpdate(MainPageTabsEnum.orders);
    //   AppRouter.pushNamed(AppRoutes.orderDetails, arguments: int.tryParse(id));
    // } else if (type == NotificationType.admin ||
    //     type == NotificationType.unkown) {
    //   if (isFirebaseNotificationTap) AppRouter.popUntil();
    //   MainPageBottomNavTabsSubscription.pushUpdate(MainPageTabsEnum.home);
    //   AppRouter.pushNamed(AppRoutes.main);
    // }
  }

  void onRecieveNotification(Map<String, dynamic> data) {
    try {} catch (e) {
      debugPrint("Failed to parse notification data on [NotificationEventHandler in onRecieveNotification Function] :\n $e");
    }
  }
}
