import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../buttons/app_button.dart';
import '../media/svg_icon.dart';
import '../overlay/show_modal_bottom_sheet.dart';

const String _routeName = "GuestDialog";

class GuestBottomSheet extends StatelessWidget {
  const GuestBottomSheet({super.key, this.isFullReview = false});

  final bool isFullReview;

  static Future<void> show(BuildContext context) async {
    final currentRouteName = AppRouter.getCurrentRoute;
    if (_routeName == currentRouteName) return;
    return await showAppModalBottomSheet<void>(context: context, child: const GuestBottomSheet(isFullReview: true));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSvgIcon(path: "", size: 75),
        const SizedBox(height: 12),
        Text(appLocalizer.guestHeaderMessage, style: TextStyles.light16),
        Text(appLocalizer.guestSubHeaderMessage, style: TextStyles.light12.copyWith(color: AppColors.black600)),
        const SizedBox(height: 24),
        Row(
          children: [
            if (isFullReview)
              Expanded(
                flex: 4,
                child: AppButton(
                  text: appLocalizer.cancel,
                  buttonColor: AppColors.primary50,
                  textStyle: TextStyles.regular14.copyWith(color: AppColors.primary700),
                  onPressed: Navigator.of(context).pop,
                ),
              ),
            if (isFullReview) const SizedBox(width: Dimensions.p12),
            Expanded(
              flex: 5,
              child: AppButton(
                text: appLocalizer.login,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
