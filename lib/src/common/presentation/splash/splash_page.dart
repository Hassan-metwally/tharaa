import 'package:flutter/material.dart';

import '../../../../core/config/values/assets.gen.dart';
import '../../../../material/media/app_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AppImage(path: Assets.images.splashScreen, fit: BoxFit.fill),
    );
  }
}
