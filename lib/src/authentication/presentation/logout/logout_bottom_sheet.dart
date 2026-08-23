import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import 'logout_cubit.dart';

const Color _kSheetScrim = Color(0x4D000000);
const Color _kIconBackground = Color(0xFFFBEAE9);
const Color _kSecondaryButtonFill = Color(0xFFF7F8FA);
const Color _kSecondaryButtonText = Color(0xFF647691);
const double _kSheetRadius = 20;
const double _kIconBadgeSize = 60;
const double _kLogoutIconSize = 32;

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet._();

  static Future<void> show(BuildContext context) async {
    return await showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      hasTopInductor: false,
      backgroundColor: Colors.transparent,
      barrierColor: _kSheetScrim,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_kSheetRadius))),
      routeSettings: const RouteSettings(name: "LogoutBottomSheet"),
      child: BlocProvider(create: (context) => LogOutCubit(), child: const LogoutBottomSheet._()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutCubit, Async<void>>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state.isFailure) {
          AppToasts.error(context, message: state.errorMessage ?? '');
        }
      },
      child: const _LogoutSheetBody(),
    );
  }
}

class _LogoutSheetBody extends StatelessWidget {
  const _LogoutSheetBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.p16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(_kSheetRadius)),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LogoutHeader(),
          SizedBox(height: Dimensions.p32),
          _LogoutActions(),
        ],
      ),
    );
  }
}

class _LogoutHeader extends StatelessWidget {
  const _LogoutHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _LogoutIconBadge(),
        const SizedBox(height: Dimensions.p12),
        Text(
          appLocalizer.logOut,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold18.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: Dimensions.p4),
        Text(
          appLocalizer.logoutMessage,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.4),
        ),
      ],
    );
  }
}

class _LogoutIconBadge extends StatelessWidget {
  const _LogoutIconBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kIconBadgeSize,
      height: _kIconBadgeSize,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.p6),
      decoration: const BoxDecoration(color: _kIconBackground, shape: BoxShape.circle),
      child: AppSvgIcon(path: AppIcons.logout, size: _kLogoutIconSize),
    );
  }
}

class _LogoutActions extends StatelessWidget {
  const _LogoutActions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogOutCubit, Async<void>>(
      builder: (context, state) {
        final TextStyle buttonTextStyle = TextStyles.semiBold18.copyWith(height: 1, fontWeight: FontWeight.w600);

        return Row(
          children: [
            Expanded(
              child: AppButton(
                isExpanded: false,
                text: appLocalizer.yesLogOut,
                buttonColor: AppColors.red500,
                isLoading: state.isLoading,
                textStyle: buttonTextStyle.copyWith(color: Colors.white),
                onPressed: context.read<LogOutCubit>().logout,
              ),
            ),
            const SizedBox(width: Dimensions.p12),
            Expanded(
              child: AppButton(
                text: appLocalizer.noGoBack,
                buttonColor: _kSecondaryButtonFill,
                isEnabled: state.isLoading == false,
                textStyle: buttonTextStyle.copyWith(color: _kSecondaryButtonText),
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ],
        );
      },
    );
  }
}
