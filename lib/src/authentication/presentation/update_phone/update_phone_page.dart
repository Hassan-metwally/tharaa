import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/intel_phone/phone_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/use_case/can_update_phone_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import '../otp/otp_page.dart';
import 'update_phone_cubit.dart';

class UpdatePhonePage extends StatefulWidget {
  final String? phone;

  const UpdatePhonePage({super.key, this.phone});

  static Future<void> show(BuildContext context, {String? phone}) async {
    return await showAppModalBottomSheet(
      context: context,
      child: BlocProvider(
        create: (context) => UpdatePhoneCubit(),
        child: UpdatePhonePage(phone: phone),
      ),
    );
  }

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  final formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  void onSave() {
    final isValidForm = formKey.currentState?.validate() ?? false;
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) return;
    if (isValidForm) {
      final params = CanUpdatePhoneParams(phone: _phoneController.text.trim());
      context.read<UpdatePhoneCubit>().canUpdate(params);
    }
  }

  void _onSuccess() {
    OtpPage.show(
      context,
      arguments: OtpScreenArguments(countryCode: "+966", phone: _phoneController.text, verifyCase: OtpScreenCaseEnum.changePhone),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> subHeaderSeqments = appLocalizer.enterYourPhoneNumber.split('##');
    final String firstSection = subHeaderSeqments.firstOrNull ?? '';
    String secondSection = '';
    if (subHeaderSeqments.length > 1) {
      secondSection = subHeaderSeqments[1];
    }
    return BlocListener<UpdatePhoneCubit, Async<void>>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppLoadingWidget.removeOverlay();
          _onSuccess();
        } else if (state.isFailure) {
          AppLoadingWidget.removeOverlay();
          AppToasts.error(context, message: state.errorMessage ?? '');
        } else if (state.isLoading) {
          AppLoadingWidget.overlay();
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            AppSvgIcon(path: ""),
            Text(appLocalizer.phoneNumber, style: TextStyles.regular16),
            Text.rich(
              TextSpan(
                text: firstSection,
                style: TextStyles.regular14.copyWith(color: AppColors.black800),
                children: [
                  if (secondSection.isNotEmpty)
                    TextSpan(
                      text: "\t$secondSection",
                      style: TextStyles.regular14.copyWith(color: AppColors.primary),
                    ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            PhoneField(controller: _phoneController, hint: widget.phone),

            AppButton(text: appLocalizer.sendVerificationCode, onPressed: onSave),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
