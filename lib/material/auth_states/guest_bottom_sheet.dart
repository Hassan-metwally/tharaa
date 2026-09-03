import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../buttons/app_button.dart';
import '../overlay/show_modal_bottom_sheet.dart';

const String _routeName = "GuestDialog";
const Color _kSheetScrim = Color(0x4D000000);
const Color _kSecondaryButtonFill = Color(0xFFF7F8FA);
const Color _kSecondaryButtonText = Color(0xFF647691);
const double _kSheetRadius = 20;

class GuestBottomSheet extends StatelessWidget {
  const GuestBottomSheet({super.key, this.isFullReview = false});

  final bool isFullReview;

  static Future<void> show(BuildContext context) async {
    final currentRouteName = AppRouter.getCurrentRoute;
    if (_routeName == currentRouteName) return;
    return await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      backgroundColor: Colors.transparent,
      barrierColor: _kSheetScrim,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_kSheetRadius))),
      child: const GuestBottomSheet(isFullReview: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.p16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(_kSheetRadius)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _GuestHeader(),
          const SizedBox(height: Dimensions.p32),
          _GuestActions(isFullReview: isFullReview),
        ],
      ),
    );
  }
}

class _GuestHeader extends StatelessWidget {
  const _GuestHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          appLocalizer.guestHeaderMessage,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold18.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: Dimensions.p4),
        Text(
          appLocalizer.guestSubHeaderMessage,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.4),
        ),
      ],
    );
  }
}

class _GuestActions extends StatelessWidget {
  const _GuestActions({required this.isFullReview});

  final bool isFullReview;

  @override
  Widget build(BuildContext context) {
    final TextStyle buttonTextStyle = TextStyles.semiBold18.copyWith(height: 1, fontWeight: FontWeight.w600);

    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: appLocalizer.login,
            buttonColor: AppColors.primary,
            textStyle: buttonTextStyle.copyWith(color: Colors.white),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
            },
          ),
        ),
        if (isFullReview) ...[
          const SizedBox(width: Dimensions.p12),
          Expanded(
            child: AppButton(
              text: appLocalizer.goBack,
              buttonColor: _kSecondaryButtonFill,
              textStyle: buttonTextStyle.copyWith(color: _kSecondaryButtonText),
              onPressed: Navigator.of(context).pop,
            ),
          ),
        ],
      ],
    );
  }
}
