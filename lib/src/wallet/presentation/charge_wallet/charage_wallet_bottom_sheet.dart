import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import '../payment_web_view/payment_webview_page.dart';
import 'charage_wallet_cubit.dart';

class ChargeWalletBottomSheet extends StatefulWidget {
  const ChargeWalletBottomSheet({super.key});

  static Future<bool?> show({required BuildContext context}) async => await showAppModalBottomSheet(
    context: context,
    child: BlocProvider(create: (context) => injector<CharageWalletCubit>(), child: const ChargeWalletBottomSheet()),
  );

  @override
  State<ChargeWalletBottomSheet> createState() => _ChargeWalletBottomSheetState();
}

class _ChargeWalletBottomSheetState extends State<ChargeWalletBottomSheet> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;

  void onSuccess(String url) {
    Navigator.pushNamed(
      context,
      AppRoutes.paymentWebView,
      arguments: PaymentWebViewPage(
        paymentUrl: url,
        onFail: () {
          AppToasts.error(context, message: appLocalizer.paymentFailMessage);
          Navigator.of(context).pop();
        },
        onSuccess: () {
          // UserWalletSubscription.pushUpdate(NoParams());
          AppToasts.success(context, message: appLocalizer.walletChargedSuccess);
          Navigator.of(context).pop();
          // Navigator.of(
          //   context,
          // ).popUntil((route) => (route.settings.name == AppRoutes.clientWalletPage) || route.settings.name == AppRoutes.providerWallet);
          // _CharageWalletSuccessBottomSheet.show(context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void onSubmit(BuildContext context, CharageWalletCubit cubit) {
    formKey.currentState?.save();
    if (!formKey.currentState!.validate()) {
      return;
    }
    final amount = int.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;
    if (amount > 0) {
      cubit.chargeWallet(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharageWalletCubit, CharageWalletState>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppRouter.pop();
          onSuccess(state.data!.invoiceUrl);
        } else if (state.isFailure) {
          AppToasts.error(context, message: state.errorMessage ?? '');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalizer.walletTopUp,
                style: TextStyles.medium18.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "appLocalizer.enterFollowingData",
                style: TextStyles.regular14.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                readOnly: state.isLoading,
                controller: _amountController,
                inputType: const TextInputType.numberWithOptions(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, EnglishNumbersFormatter(), NoContainSpaceFormatter()],
                label: appLocalizer.amountValue,
                validator: (text) => Validator(text).positiveNumberValidator,
              ),
              const SizedBox(height: 32),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.pay,
                      isLoading: state.isLoading,
                      onPressed: () => onSubmit(context, context.read<CharageWalletCubit>()),
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      text: appLocalizer.cancel,
                      textStyle: TextStyles.medium16.copyWith(color: AppColors.black800),
                      buttonColor: AppColors.black100,
                      onPressed: () => AppRouter.pop(result: false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// class _CharageWalletSuccessBottomSheet extends StatelessWidget {
//   const _CharageWalletSuccessBottomSheet._();

//   static void show(BuildContext context) async {
//     return await showAppTopModalSheet(context: context, child: const _CharageWalletSuccessBottomSheet._());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(height: 12),
//         AppSvgIcon(path: ''),
//         const SizedBox(height: 12),
//         Text(appLocalizer.walletChargedSuccess, style: TextStyles.regular14.copyWith(color: AppColors.black)),
//         const SizedBox(height: 24),
//       ],
//     );
//   }
// }
