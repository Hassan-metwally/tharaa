import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';

class AppFailWidget extends StatelessWidget {
  const AppFailWidget({super.key, this.onRetry, this.textStyle = TextStyles.light16, this.isMini = false});

  const AppFailWidget.mini({Key? key, VoidCallback? onRetry})
    : this(key: key, onRetry: onRetry, isMini: true, textStyle: TextStyles.light14);

  final void Function()? onRetry;
  final TextStyle textStyle;
  final bool isMini;

  static const String routeName = "AppFailWidgetOverlay";

  static Future<void> overlay(VoidCallback onRetry) async {
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
      routeSettings: const RouteSettings(name: routeName),
      barrierLabel: routeName,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: PopScope(
              canPop: false,
              child: Container(
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: MediaQuery.of(context).size.width * 0.75,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: AppColors.canvasBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [AppColors.boxShadow],
                ),
                child: AppFailWidget(
                  onRetry: () {
                    Navigator.pop(context);
                    onRetry();
                  },
                ),
              ),
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
    if (isMini) {
      return Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onRetry,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(appLocalizer.failToLoad, textAlign: TextAlign.center, style: textStyle),
              ),
              const SizedBox(width: 4),
              Icon(Icons.refresh_rounded, size: (textStyle.fontSize ?? 0) * 1.4),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // AppSvgIcon(path: "AppIllustrations.errorIllustration"),
            const SizedBox(height: 12),
            Text(appLocalizer.anErrorOccurredWhileLoading, style: TextStyles.regular16),
            Text(appLocalizer.tryAnotherTime, style: TextStyles.light14.copyWith(color: AppColors.primary600)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(70, 44),
                side: BorderSide(color: AppColors.primary),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Text(appLocalizer.retry, style: TextStyles.regular14.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      );
    }
  }
}
