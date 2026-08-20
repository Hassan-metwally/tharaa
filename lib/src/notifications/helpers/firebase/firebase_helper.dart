// ignore_for_file: unused_element

import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../firebase_options.dart';
import '../local_notification/handler/notification_event_handler.dart';
import '../local_notification/local_notification_helper.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static late FirebaseApp _firebaseApp;
  static late FirebaseMessaging _firebaseMessaging;

  /// To Initialize Firebase
  static Future<void> init() async {
    await _initializeFirebaseApp();
    await _initCloudMessaging();
    await LocalNotificationService.instance.initialize();
    getDeviceFcmToken();
  }

  static FirebaseApp get getFireBaseApp {
    return _firebaseApp;
  }

  static Future<void> _initializeFirebaseApp() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  /// To Initialize Firebase FCM
  static Future<void> _initCloudMessaging() async {
    _firebaseMessaging = FirebaseMessaging.instance;
    final settings = await _requestNotificationPermissions();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _enableForegroundNotifications();
    } else if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      _requestNotificationPermissions();
    }
  }

  static Future<void> _enableForegroundNotifications() async {
    //iOS setup
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    //android setup
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<NotificationSettings> _getNotificationSettings() async {
    return await FirebaseMessaging.instance.getNotificationSettings();
  }

  /// To Request Notification Permissions (For IOS)
  static Future<NotificationSettings> _requestNotificationPermissions() async {
    return await FirebaseMessaging.instance.requestPermission();
  }

  /// To Set On Notification Listener
  static void setUpNotificationListener() {
    /// This method will call when the app is in kill state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('Firebase Messaging Notification ::: Get Initial Message ::: \t [Data] ==> ${message.data}');
        _onNotificationPress(message.data);
        NotificationEventHandler.instance.onRecieveNotification(message.data);
      }
    });

    /// This method will call when the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        debugPrint('Firebase Messaging Notification ::: Received On Message Opened App ::: \t [Data] ==> ${message.data}');
        _onNotificationPress(message.data);
        NotificationEventHandler.instance.onRecieveNotification(message.data);
      }
    });

    /// This method will call when the app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null) {
        debugPrint('Firebase Messaging Notification ::: Received On onMessage ::: \t [Data] ==> ${message.data}');
        if (Platform.isAndroid) {
          debugPrint('Firebase Messaging Notification ::: showNotification ::: \t [Data] ==> ${message.data}');
          await LocalNotificationService.instance.showNotification(message);
          NotificationEventHandler.instance.onRecieveNotification(message.data);
        }
      }
    });
  }

  static void _onNotificationPress(Map<String, dynamic> data) {
    NotificationEventHandler.instance.onFireBaseNotificationPressed(data);
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e) {
      log("Fcm Notification", time: DateTime.now(), error: "::: FirebaseMessaging Subscribe To Topic Error ::: \n${e.toString()}");
    }
  }

  static Future<void> unSubscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } catch (e) {
      log("FirebaseMessaging Subscribe To Topic Error : $e");
    }
  }

  static Future<String?> getDeviceFcmToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      log(token.toString(), name: "FCM TOKEN");
      return token;
    } catch (e) {
      debugPrint("[FAILED GET FCM TOKEN] ::: ERROR => $e");
      return null;
    }
  }

  static Future<void> deleteDeviceFcmToken() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      debugPrint("[FAILED DELETE FCM TOKEN] ::: ERROR => $e");
    }
  }
}

@pragma('vm:entry-point')
Future<void> userFirebaseOnMessagingBackground(RemoteMessage message) async {
  log("Get Client Notification On Background [Data] ::: ${message.data}", name: "Get FCM Notification In Background");
  await FirebaseHelper._initializeFirebaseApp();
}

/*
understand send json to FCM
https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages

https://github.com/firebase/quickstart-android/issues/1007
 */
