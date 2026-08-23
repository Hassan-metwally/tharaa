import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/notifiers/resend_timer_notifier.dart';
import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import 'otp_cubit.dart';
import 'widgets/otp_pin_fields_widget.dart';

part 'widgets/dont_recive_code.dart';

const Color _kLightGray = Color(0xFFF7F8FA);
const Color _kDescription = Color(0xFF8B9BB2);
const Color _kDisabledTonal = Color(0xFF9EABBF);
const Color _kTonalFill = Color(0xFFFCF5E9);

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.arguments});

  final OtpScreenArguments arguments;

  static void show(BuildContext context, {required OtpScreenArguments arguments}) async {
    return await showAppModalBottomSheet(
      context: context,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      backgroundColor: Colors.white,
      child: BlocProvider(
        create: (context) => OtpCubit(arguments: arguments),
        child: _OtpPageBody(arguments: arguments, isBottomSheet: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(arguments: arguments),
      child: _OtpPageBody(arguments: arguments, isBottomSheet: false),
    );
  }
}

class _OtpPageBody extends StatefulWidget {
  const _OtpPageBody({required this.arguments, required this.isBottomSheet});

  final OtpScreenArguments arguments;
  final bool isBottomSheet;

  @override
  State<_OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<_OtpPageBody> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _resendOtpNotifier = ResendOtpTimerNotifier()..startTimer();

  @override
  Widget build(BuildContext context) {
    final content = MultiBlocListener(
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
      child: Form(key: _formKey, child: widget.isBottomSheet ? _buildSheetContent() : _buildPageContent(context)),
    );

    if (widget.isBottomSheet) {
      return content;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(backgroundColor: Colors.white, resizeToAvoidBottomInset: true, appBar: AppBar(), body: content),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    final double bottomInset = MediaQuery.paddingOf(context).bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset > 0 ? 8 : 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _OtpHeader(),
                    const SizedBox(height: 32),
                    _buildPinFields(),
                    const SizedBox(height: 16),
                    _buildTimerRow(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _OtpActions(
              isBottomSheet: false,
              otpController: _otpController,
              resendOtpNotifier: _resendOtpNotifier,
              onVerifyPressed: _onVerifyButtonPressed,
              onResendPressed: () => OtpCubit.of(context).resendOtp(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSheetContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _OtpHeader(),
        const SizedBox(height: 32),
        _buildPinFields(),
        const SizedBox(height: 16),
        _buildTimerRow(),
        const SizedBox(height: 24),
        _OtpActions(
          isBottomSheet: true,
          otpController: _otpController,
          resendOtpNotifier: _resendOtpNotifier,
          onVerifyPressed: _onVerifyButtonPressed,
          onResendPressed: () => OtpCubit.of(context).resendOtp(),
        ),
      ],
    );
  }

  Widget _buildPinFields() {
    return BlocBuilder<OtpCubit, OtpState>(
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
    );
  }

  Widget _buildTimerRow() {
    return ValueListenableBuilder(
      valueListenable: _resendOtpNotifier,
      builder: (context, value, child) {
        return _OtpTimerRow(timerValue: value);
      },
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
    _resendOtpNotifier.dispose();
    super.dispose();
  }
}

class _OtpHeader extends StatelessWidget {
  const _OtpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          appLocalizer.otpHeadline,
          textAlign: TextAlign.start,
          style: TextStyles.semiBold22.copyWith(color: AppColors.black900, height: 1.6, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          appLocalizer.otpSubtitle,
          textAlign: TextAlign.start,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.6),
        ),
      ],
    );
  }
}

class _OtpActions extends StatelessWidget {
  const _OtpActions({
    required this.isBottomSheet,
    required this.otpController,
    required this.resendOtpNotifier,
    required this.onVerifyPressed,
    required this.onResendPressed,
  });

  final bool isBottomSheet;
  final TextEditingController otpController;
  final ResendOtpTimerNotifier resendOtpNotifier;
  final VoidCallback onVerifyPressed;
  final VoidCallback onResendPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: otpController,
              builder: (context, value, child) {
                return AppButton(
                  onPressed: onVerifyPressed,
                  text: isBottomSheet ? appLocalizer.verifyCode : appLocalizer.login,
                  isLoading: state.verifyState.isLoading || state.updatePhoneState.isLoading,
                  textStyle: TextStyles.semiBold18.copyWith(color: Colors.white, height: 1, fontWeight: FontWeight.w600),
                );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<OtpCubit, OtpState>(
          buildWhen: (previous, current) => previous.resendState != current.resendState,
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: resendOtpNotifier,
              builder: (context, value, child) {
                return _ResendCodeButton(isEnabled: value.isEnded, isLoading: state.resendState.isLoading, onPressed: onResendPressed);
              },
            );
          },
        ),
      ],
    );
  }
}
