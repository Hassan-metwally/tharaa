import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/di/di.dart';
import 'core/utils/pusher/pusher_handler.dart';
import 'src/notifications/helpers/firebase/firebase_helper.dart';

/// Staging Traefik currently serves its default self-signed cert
/// (`CN=TRAEFIK DEFAULT CERT`) instead of a valid certificate.
class _DevApiHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      return host.endsWith('dev-moltaqa.cloud');
    };
    return client;
  }
}

Future<void> initializeAppConfig() async {
  // Ensure that the Flutter engine is properly initialized.
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = _DevApiHttpOverrides();

  // Lock the app orientation to portrait mode only.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize application dependencies (e.g., services, providers, shared preferences, dio helper...etc).
  await initializeDependencies();

  // Initialize Firebase services.
  await FirebaseHelper.init();

  // Initialize the Pusher.
  await PusherHandler.instance.initialize();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  // Set the system UI mode to manual, displaying all system UI overlays.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  // Apply a dark style to the system UI overlays for better visibility.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  // To increase image cache size
  PaintingBinding.instance.imageCache.maximumSizeBytes = 512 << 20;

  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
