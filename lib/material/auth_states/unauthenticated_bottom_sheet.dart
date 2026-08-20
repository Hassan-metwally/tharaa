import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../buttons/app_button.dart';
import '../media/svg_icon.dart';
import '../overlay/show_modal_bottom_sheet.dart';

class UnAuthenticatedBottomSheet extends StatelessWidget {
  const UnAuthenticatedBottomSheet._();

  static const String routeName = "UnAuthenticatedBottomSheet";

  static Future<void> show() async {
    final context = appNavigatorKey.currentContext;
    final currentRouteName = AppRouter.getCurrentRoute;

    if (currentRouteName == routeName || context == null || context.mounted == false) {
      return;
    }

    await showAppModalBottomSheet(context: context, isDismissible: false, child: const UnAuthenticatedBottomSheet._());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSvgIcon(path: "assets/icons/user-login-ic.svg"),
          Text(appLocalizer.guestHeaderMessage, style: TextStyles.light16),
          const SizedBox(height: 24),
          AppButton(
            text: appLocalizer.login,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
            },
          ),
        ],
      ),
    );
  }
}
