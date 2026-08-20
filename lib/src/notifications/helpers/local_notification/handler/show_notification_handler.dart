import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../utils/notification_badge_utils.dart';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

class ShowNotificationHandler {
  final FlutterLocalNotificationsPlugin localNotificationService;

  ShowNotificationHandler(this.localNotificationService);

  /// function [handleForegroundNotification] to appear notification
  Future<void> handleForegroundNotification(RemoteMessage message) async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    }

    /// Handle [message.notification] Firebase Pushed Notification Show
    final notification = message.notification;
    if (notification != null) {
      await _showPublicNotification(
        id: message.hashCode,
        title: notification.title ?? "Title",
        body: notification.body ?? "body",
        payload: json.encode(message.data),
      );
      return;
    } else {
      final data = message.data;
      await _showPublicNotification(
        id: message.hashCode,
        title: data['title'] ?? "Default Title",
        body: data['body'] ?? 'Default Body',
        payload: json.encode(data),
      );
    }
  }

  Future<void> _showPublicNotification({required int id, required String title, required String body, required String payload}) async {
    NotificationBadgeUtils.instance.increseNotificationCount();
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'high_importance_channel',
      channelDescription: 'description',
      icon: "@mipmap/ic_launcher",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableLights: true,
      // sound: _rawNotificationSound,
    );

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
      // sound: 'sound/call_ring.mp3'
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    await localNotificationService.show(id, title, body, notificationDetails, payload: payload);
  }
}
