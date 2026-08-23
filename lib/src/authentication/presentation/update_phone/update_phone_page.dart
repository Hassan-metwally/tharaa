import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharaa/material/auth_states/logged_user_checker_widget.dart';

import '../../../../core/core.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/phone_field.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/use_case/can_update_phone_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import '../otp/otp_page.dart';
import 'update_phone_cubit.dart';

class UpdatePhonePage extends StatefulWidget {
  const UpdatePhonePage({super.key});

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  final formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  void _onSavePressed() {
    final isValidForm = formKey.currentState?.validate() ?? false;
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) return;
    if (isValidForm) {
      final params = CanUpdatePhoneParams(countryCode: "+966", phone: _phoneController.text.trim());
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
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

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
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(appLocalizer.changePhoneNumber)),
        body: SafeArea(
          top: false,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: LoggedUserCheckerWidget(
                      loggedBuilder: (client) {
                        return PhoneField(
                          controller: _phoneController,
                          margin: EdgeInsets.zero,
                          labelText: appLocalizer.newPhoneNumber,
                          hint: client.mobile,
                          labelStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, bottomInset > 0 ? 8 : 32),
                  child: AppButton(
                    text: appLocalizer.change,
                    onPressed: _onSavePressed,
                    textStyle: TextStyles.semiBold18.copyWith(color: Colors.white, height: 1, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
