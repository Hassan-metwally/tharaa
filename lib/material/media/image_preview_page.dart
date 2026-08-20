import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'app_image.dart';

class ImagePreviewPage extends StatelessWidget {
  final String path;

  const ImagePreviewPage._({required this.path});

  static const String routeName = '/imagePreviewPage';

  static void open(String path) async {
    final context = appNavigatorKey.currentContext;

    if (context == null || context.mounted == false) {
      return;
    }
    await Navigator.of(context, rootNavigator: true).push(
      FadeTransitionRoute(
        settings: const RouteSettings(name: routeName),
        duration: Duration(milliseconds: 300),
        child: (context) => ImagePreviewPage._(path: path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: InteractiveViewer(
              minScale: 0.25,
              maxScale: 4,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: AppImage(fit: BoxFit.scaleDown, path: path, width: double.infinity, showFailIcon: true),
              ),
            ),
          ),
          PositionedDirectional(
            top: 10,
            start: 20,
            child: SafeArea(
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(color: AppColors.black50.withOpacityPercent(90), shape: BoxShape.circle),
                child: BackButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
