import 'package:flutter/material.dart';

import 'app.dart';
import 'app_configs.dart';

void main() async {
  await initializeAppConfig();
  runApp(
    const App(),
    // DevicePreview(
    //   enabled: false,
    //   builder: (context) => const App(),
    // ),
  );
}
