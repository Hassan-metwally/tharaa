import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import 'delete_account_cubit.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet._();

  static Future<void> show(BuildContext context) async {
    return await showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      routeSettings: const RouteSettings(name: "DeleteAccountBottomSheet"),
      child: const DeleteAccountBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> subHeaderSeqments = appLocalizer.deleteAccountMessage.split('##');
    final String firstSection = subHeaderSeqments.firstOrNull ?? '';
    String secondSection = '';
    if (subHeaderSeqments.length > 1) {
      secondSection = subHeaderSeqments[1];
    }
    String lastSection = '';
    if (subHeaderSeqments.length > 2) {
      lastSection = subHeaderSeqments[2];
    }
    return Column(
      spacing: 12,
      children: [
        AppSvgIcon(path: ""),
        Text(appLocalizer.deleteAccount, style: TextStyles.regular16),
        Text.rich(
          TextSpan(
            text: firstSection,
            style: TextStyles.light14.copyWith(color: AppColors.black800),
            children: [
              if (secondSection.isNotEmpty)
                TextSpan(
                  text: "\t$secondSection",
                  style: TextStyles.light14.copyWith(color: AppColors.red400),
                ),
              if (lastSection.isNotEmpty) TextSpan(text: '\t$lastSection'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimensions.p16),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: appLocalizer.delete,
                buttonColor: AppColors.error,
                textStyle: TextStyles.regular16.copyWith(color: Colors.white),
                onPressed: () {
                  AppRouter.pop();
                  DeleteAccountWarrningBottomSheet.show(context);
                },
              ),
            ),
            const SizedBox(width: Dimensions.p12),
            Expanded(
              child: AppButton(
                text: appLocalizer.cancel,
                buttonColor: AppColors.black50,
                textStyle: TextStyles.regular16.copyWith(color: AppColors.black800),
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DeleteAccountWarrningBottomSheet extends StatelessWidget {
  const DeleteAccountWarrningBottomSheet._();

  static Future<void> show(BuildContext context) async {
    return await showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      routeSettings: const RouteSettings(name: "DeleteAccountWarrningBottomSheet"),
      child: BlocProvider(create: (context) => DeleteAccountCubit(), child: const DeleteAccountWarrningBottomSheet._()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> subHeaderSeqments = appLocalizer.deleteAccountWarrningMessage.split('##');
    final String firstSection = subHeaderSeqments.firstOrNull ?? '';
    String secondSection = '';
    if (subHeaderSeqments.length > 1) {
      secondSection = subHeaderSeqments[1];
    }
    String lastSection = '';
    if (subHeaderSeqments.length > 2) {
      lastSection = subHeaderSeqments[2];
    }
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
      child: Column(
        spacing: 12,
        children: [
          Text(appLocalizer.deleteAccount, style: TextStyles.regular16),
          Text.rich(
            TextSpan(
              text: firstSection,
              style: TextStyles.light14.copyWith(color: AppColors.black800),
              children: [
                if (secondSection.isNotEmpty)
                  TextSpan(
                    text: "\t$secondSection",
                    style: TextStyles.light14.copyWith(color: AppColors.red400),
                  ),
                if (lastSection.isNotEmpty) TextSpan(text: '\t$lastSection'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Dimensions.p16),
          BlocBuilder<DeleteAccountCubit, Async<void>>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.confirm,
                      buttonColor: AppColors.primary,
                      isLoading: state.isLoading,
                      textStyle: TextStyles.regular16.copyWith(color: Colors.white),
                      onPressed: context.read<DeleteAccountCubit>().deleteAccount,
                    ),
                  ),
                  const SizedBox(width: Dimensions.p12),
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.cancel,
                      buttonColor: AppColors.black50,
                      isEnabled: state.isLoading == false,
                      textStyle: TextStyles.regular16.copyWith(color: AppColors.black800),
                      onPressed: Navigator.of(context).pop,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
