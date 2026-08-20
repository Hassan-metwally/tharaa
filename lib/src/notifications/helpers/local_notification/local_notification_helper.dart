import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'handler/notification_event_handler.dart';
import 'handler/show_notification_handler.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService? _instance;

  static LocalNotificationService get instance => _instance ??= LocalNotificationService._();

  static final _localNotificationService = FlutterLocalNotificationsPlugin();

  final ShowNotificationHandler _showLocalNotificationHandler = ShowNotificationHandler(_localNotificationService);

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // final notificationAppLaunchDetails =
    //     await _localNotificationService.getNotificationAppLaunchDetails();

    // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //   _onDidReceiveLocalNotification(
    //       notificationAppLaunchDetails?.notificationResponse);
    // }

    _requestPermissions();
  }

  Future<bool> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      return await _localNotificationService
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return false;
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final bool isAndroidNotificationEnabled = await _isAndroidPermissionGranted();
      if (isAndroidNotificationEnabled) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation = _localNotificationService
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        await androidImplementation?.requestNotificationsPermission();
      }
    } else if (Platform.isIOS) {
      await _localNotificationService.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void cancelAllNotifications() => _localNotificationService.cancelAll();

  void cancelNotification(int id) => _localNotificationService.cancel(id);

  Future<void> showNotification(RemoteMessage message) async {
    await _showLocalNotificationHandler.handleForegroundNotification(message);
  }

  void _onDidReceiveLocalNotification(NotificationResponse? notificationResponse) {
    final Map<String, dynamic>? data = json.decode(notificationResponse?.payload ?? "");
    if (data != null) {
      onNotificationPress(data);
    }
  }

  void onNotificationPress(Map<String, dynamic> data) {
    NotificationEventHandler.instance.onFireBaseNotificationPressed(data);
  }
}

/// [notificationTapBackground] USED TO DETECT ACTIONS TAPS OR INPUTS OR CHOICE
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with'
    ' payload: ${notificationResponse.payload}',
  );
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}
