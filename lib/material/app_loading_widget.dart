import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tharaa/material/spin_kit_loading_widget.dart';

import '../core/core.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.size = 30, this.strokeWidth = 4.0, this.color = Colors.black, this.useAnimatedLoading = false});

  final double size;
  final double strokeWidth;
  final Color color;
  final bool useAnimatedLoading;

  static const String routeName = "AppLoadingOverlay";

  static Future<void> overlay({bool rootNavigator = true, bool useAnimatedLoading = false}) async {
    final currentRouteName = AppRouter.getCurrentRoute;
    final context = appNavigatorKey.currentContext;

    if (currentRouteName == routeName || context == null || context.mounted == false) {
      return;
    }
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: rootNavigator,
      routeSettings: const RouteSettings(name: routeName),
      barrierLabel: routeName,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              height: 70,
              width: 140,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [AppColors.boxShadow],
              ),
              child: useAnimatedLoading ? const LogoLoading() : const DefaultLoading(),
            ),
          ),
        );
      },
    );
  }

  static void removeOverlay({bool rootNavigator = true}) {
    final currentRoute = AppRouter.getCurrentRoute;
    if (currentRoute == routeName) {
      final context = appNavigatorKey.currentContext;
      if (context != null && context.mounted) {
        Navigator.of(context, rootNavigator: rootNavigator).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (useAnimatedLoading) {
      return const LogoLoading();
    } else {
      return DefaultLoading(color: color, size: size, strokeWidth: strokeWidth);
    }
  }
}

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({super.key, this.size = 30, this.strokeWidth = 4, this.color});

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size * 2,
        child: SpinKitLoadingWidget(size: size, color: color),
      ),
    );
  }
}

class LogoLoading extends StatelessWidget {
  const LogoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieBuilder.asset("assets/animations/zehab.json"));
  }
}
