import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/notifiers/resend_timer_notifier.dart';
import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import 'otp_cubit.dart';
import 'widgets/otp_pin_fields_widget.dart';

part "widgets/dont_recive_code.dart";

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.arguments});

  final OtpScreenArguments arguments;

  static void show(BuildContext context, {required OtpScreenArguments arguments}) async {
    return await showAppModalBottomSheet(
      context: context,
      child: BlocProvider(
        create: (context) => OtpCubit(arguments: arguments),
        child: Column(
          children: [
            Text(appLocalizer.verificationCode, style: TextStyles.regular16),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                text: appLocalizer.otpHeaderMessage,
                children: [
                  TextSpan(
                    text: "\t${arguments.phone}",
                    style: TextStyles.light12.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyles.light12.copyWith(color: AppColors.black600),
            ),
            const SizedBox(height: 28),
            _OtpPageBody(arguments: arguments, minimizeSpacing: true),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(arguments: arguments),
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: Dimensions.pageMargins,
          child: Column(
            children: [
              Text(appLocalizer.verificationCode, style: TextStyles.regular20.copyWith(color: AppColors.primary900)),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: appLocalizer.otpHeaderMessage,
                  children: [
                    TextSpan(
                      text: "\t${appLocalizer.yourPhoneNumber}.",
                      style: TextStyles.light16.copyWith(color: AppColors.secondary),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyles.light16.copyWith(color: AppColors.primary800),
              ),
              const SizedBox(height: 32),
              _OtpPageBody(arguments: arguments, minimizeSpacing: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpPageBody extends StatefulWidget {
  const _OtpPageBody({required this.arguments, required this.minimizeSpacing});

  final OtpScreenArguments arguments;
  final bool minimizeSpacing;

  @override
  State<_OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<_OtpPageBody> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _resendOtpNotifier = ResendOtpTimerNotifier()..startTimer();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpCubit, OtpState>(
          listenWhen: (previous, current) => previous.verifyState != current.verifyState,
          listener: (context, state) {
            if (state.verifyState.isSuccess) {
              _onOtpVerifySuccess();
            }
          },
        ),
        BlocListener<OtpCubit, OtpState>(
          listenWhen: (previous, current) => previous.resendState != current.resendState,
          listener: (context, state) {
            if (state.resendState.isSuccess) {
              _resendOtpNotifier.startTimer();
              AppToasts.success(context, message: appLocalizer.otpSentSuccessfully);
            } else if (state.resendState.isFailure) {
              AppToasts.error(context, message: state.resendState.errorMessage ?? '');
            }
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<OtpCubit, OtpState>(
              buildWhen: (previous, current) => previous.verifyState != current.verifyState,
              builder: (context, state) {
                return OtpPinCodeWidget(
                  controller: _otpController,
                  hasError: state.verifyState.isFailure,
                  readOnly: state.verifyState.isLoading,
                  errorMessage: state.verifyState.errorMessage,
                  validator: (value) {
                    final text = value ?? '';
                    if (text.isEmpty) {
                      return appLocalizer.enterVerificationCode;
                    } else if (text.length < appOtpFieldsLength) {
                      return appLocalizer.verificationCodeLengthValidation;
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            BlocBuilder<OtpCubit, OtpState>(
              buildWhen: (previous, current) => previous.resendState != current.resendState,
              builder: (context, state) {
                return ValueListenableBuilder(
                  valueListenable: _resendOtpNotifier,
                  builder: (context, value, child) {
                    final bool isEnabled = value.isEnded;
                    return _DontReciveCodeWidget(
                      resendNotifier: _resendOtpNotifier,
                      isEnabled: isEnabled,
                      isLoading: state.resendState.isLoading,
                      onResendPressed: () {
                        OtpCubit.of(context).resendOtp();
                      },
                    );
                  },
                );
              },
            ),
            if (widget.minimizeSpacing) const SizedBox(height: 20) else SizedBox(height: MediaQuery.of(context).size.height * .2),
            BlocBuilder<OtpCubit, OtpState>(
              builder: (context, state) {
                return ValueListenableBuilder(
                  valueListenable: _otpController,
                  builder: (context, value, child) {
                    return AppButton(
                      // isEnabled: value.text.length >= appOtpFieldsLength,
                      onPressed: _onVerifyButtonPressed,
                      text: widget.minimizeSpacing ? appLocalizer.verifyCode : appLocalizer.confirm,
                      isLoading: state.verifyState.isLoading || state.updatePhoneState.isLoading,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onVerifyButtonPressed() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      final isVerifyStateSuccess = OtpCubit.of(context).state.verifyState.isSuccess;
      if (widget.arguments.verifyCase == OtpScreenCaseEnum.changePhone && isVerifyStateSuccess) {
        OtpCubit.of(context).updatePhone();
      } else {
        OtpCubit.of(context).verify(_otpController.text);
      }
    }
  }

  void _onOtpVerifySuccess() {
    switch (widget.arguments.verifyCase) {
      case OtpScreenCaseEnum.register:
        AppAuthenticationBloc.of(context).add(const AuthenticatedEvent());
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case OtpScreenCaseEnum.login:
        AppToasts.success(context, message: appLocalizer.verifyCodeSuccessMessage);
        AppAuthenticationBloc.of(context).add(const AuthenticatedEvent());
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case OtpScreenCaseEnum.changePhone:
        AppToasts.success(context, message: appLocalizer.phoneUpdateSuccessMessage);
        AppAuthenticationBloc.of(context).add(const AuthenticatedEvent());
        Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
