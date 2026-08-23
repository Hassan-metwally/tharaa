import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import 'delete_account_cubit.dart';

const Color _kSheetScrim = Color(0x4D000000);
const Color _kIconBackground = Color(0xFFFBEAE9);
const Color _kSecondaryButtonFill = Color(0xFFF7F8FA);
const Color _kSecondaryButtonText = Color(0xFF647691);
const double _kSheetRadius = 20;
const double _kIconBadgeSize = 60;
const double _kDeleteIconSize = 32;

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet._();

  static Future<void> show(BuildContext context) async {
    return await showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      hasTopInductor: false,
      backgroundColor: Colors.transparent,
      barrierColor: _kSheetScrim,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_kSheetRadius))),
      routeSettings: const RouteSettings(name: "DeleteAccountBottomSheet"),
      child: const DeleteAccountBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _DeleteAccountSheetBody(
      message: appLocalizer.deleteAccountMessage,
      primaryText: appLocalizer.yesDeleteAccount,
      onPrimary: () {
        AppRouter.pop();
        DeleteAccountWarrningBottomSheet.show(context);
      },
    );
  }
}

class DeleteAccountWarrningBottomSheet extends StatelessWidget {
  const DeleteAccountWarrningBottomSheet._();

  static Future<void> show(BuildContext context) async {
    return await showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      hasTopInductor: false,
      backgroundColor: Colors.transparent,
      barrierColor: _kSheetScrim,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_kSheetRadius))),
      routeSettings: const RouteSettings(name: "DeleteAccountWarrningBottomSheet"),
      child: BlocProvider(create: (context) => DeleteAccountCubit(), child: const DeleteAccountWarrningBottomSheet._()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, Async<void>>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppToasts.success(context, message: appLocalizer.deleteAccountSuccessMessage);
          AppAuthenticationBloc.of(context).add(const LoggedOutEvent());
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state.isFailure) {
          AppToasts.error(context, message: state.errorMessage ?? '');
        }
      },
      child: BlocBuilder<DeleteAccountCubit, Async<void>>(
        builder: (context, state) {
          return _DeleteAccountSheetBody(
            message: appLocalizer.deleteAccountWarrningMessage,
            primaryText: appLocalizer.confirm,
            isLoading: state.isLoading,
            onPrimary: context.read<DeleteAccountCubit>().deleteAccount,
          );
        },
      ),
    );
  }
}

class _DeleteAccountSheetBody extends StatelessWidget {
  const _DeleteAccountSheetBody({
    required this.message,
    required this.primaryText,
    required this.onPrimary,
    this.isLoading = false,
  });

  final String message;
  final String primaryText;
  final VoidCallback onPrimary;
  final bool isLoading;

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
          _DeleteAccountHeader(message: message),
          const SizedBox(height: Dimensions.p32),
          _DeleteAccountActions(primaryText: primaryText, isLoading: isLoading, onPrimary: onPrimary),
        ],
      ),
    );
  }
}

class _DeleteAccountHeader extends StatelessWidget {
  const _DeleteAccountHeader({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DeleteAccountIconBadge(),
        const SizedBox(height: Dimensions.p12),
        Text(
          appLocalizer.deleteAccount,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold18.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: Dimensions.p4),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.4),
        ),
      ],
    );
  }
}

class _DeleteAccountIconBadge extends StatelessWidget {
  const _DeleteAccountIconBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kIconBadgeSize,
      height: _kIconBadgeSize,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.p6),
      decoration: const BoxDecoration(color: _kIconBackground, shape: BoxShape.circle),
      child: AppSvgIcon(path: AppIcons.logout, size: _kDeleteIconSize),
    );
  }
}

class _DeleteAccountActions extends StatelessWidget {
  const _DeleteAccountActions({required this.primaryText, required this.onPrimary, required this.isLoading});

  final String primaryText;
  final VoidCallback onPrimary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final TextStyle buttonTextStyle = TextStyles.semiBold18.copyWith(height: 1, fontWeight: FontWeight.w600);

    return Row(
      children: [
        Expanded(
          child: AppButton(
            isExpanded: false,
            text: primaryText,
            buttonColor: AppColors.red500,
            isLoading: isLoading,
            textStyle: buttonTextStyle.copyWith(color: Colors.white),
            onPressed: onPrimary,
          ),
        ),
        const SizedBox(width: Dimensions.p12),
        Expanded(
          child: AppButton(
            text: appLocalizer.noGoBack,
            buttonColor: _kSecondaryButtonFill,
            isEnabled: isLoading == false,
            textStyle: buttonTextStyle.copyWith(color: _kSecondaryButtonText),
            onPressed: Navigator.of(context).pop,
          ),
        ),
      ],
    );
  }
}
