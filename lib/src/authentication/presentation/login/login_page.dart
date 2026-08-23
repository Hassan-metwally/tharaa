import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/phone_field.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import '../otp/otp_page.dart';
import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _onLoginPressed() {
    final bool isValidForm = formKey.currentState?.validate() ?? false;
    final phoneNumber = phoneController.text.trim();
    if (phoneNumber.isEmpty) return;
    if (isValidForm) {
      final params = LoginParams(countryCode: "+966", phone: phoneController.text.trim());
      context.read<LoginCubit>().login(params);
    }
  }

  void _onRegisterPressed() {
    Navigator.of(context).pushNamed(AppRoutes.clientRegisterPage);
  }

  void _onLoginSuccess({required UserEntity user}) {
    Navigator.of(context).pushNamed(
      AppRoutes.otp,
      arguments: OtpPage(
        arguments: OtpScreenArguments(countryCode: "+966", phone: phoneController.text, verifyCase: OtpScreenCaseEnum.login),
      ),
    );
  }

  void _onContinueAsGuestTap() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    AppAuthenticationBloc.of(context).add(const GuestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          final userData = state.data!;
          _onLoginSuccess(user: userData);
        } else if (state.isFailure) {
          AppToasts.error(context, message: state.errorMessage ?? '');
        }
      },
      builder: (context, state) {
        final double bottomInset = MediaQuery.paddingOf(context).bottom;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: IgnorePointer(
              ignoring: state.isLoading,
              child: Form(
                key: formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const _LoginLogo(),
                                const SizedBox(height: 20),
                                Text(
                                  appLocalizer.loginHeadline,
                                  textAlign: TextAlign.start,
                                  style: TextStyles.semiBold24.copyWith(color: AppColors.black900, height: 1.3, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  appLocalizer.loginSubtitle,
                                  textAlign: TextAlign.start,
                                  style: TextStyles.medium16.copyWith(color: AppColors.mutedText, height: 1.5, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 32),
                                PhoneField(controller: phoneController, margin: EdgeInsets.zero),
                              ],
                            ),
                          ),
                        ),
                        _LoginActions(
                          isLoading: state.isLoading,
                          onSendCode: _onLoginPressed,
                          onCreateAccount: _onRegisterPressed,
                          onContinueAsGuest: _onContinueAsGuestTap,
                          bottomInset: bottomInset,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}

class _LoginLogo extends StatelessWidget {
  const _LoginLogo();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppImage(path: AppImages.loginLogo, width: 56, height: 44, fit: BoxFit.contain),
    );
  }
}

class _LoginActions extends StatelessWidget {
  const _LoginActions({
    required this.isLoading,
    required this.onSendCode,
    required this.onCreateAccount,
    required this.onContinueAsGuest,
    required this.bottomInset,
  });

  final bool isLoading;
  final VoidCallback onSendCode;
  final VoidCallback onCreateAccount;
  final VoidCallback onContinueAsGuest;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24, bottom: bottomInset > 0 ? 8 : 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton(
            text: appLocalizer.sendVerificationCode,
            onPressed: onSendCode,
            isLoading: isLoading,
            textStyle: TextStyles.semiBold16.copyWith(color: Colors.white, height: 1),
          ),
          const SizedBox(height: 12),
          _CreateAccountButton(onPressed: onCreateAccount),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onContinueAsGuest,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                appLocalizer.continueAsGuest,
                textAlign: TextAlign.center,
                style: TextStyles.medium16.copyWith(color: AppColors.mutedText, height: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const double radius = 16;

    return Material(
      color: AppColors.primary50,
      elevation: 0,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: AppSvgIcon(path: AppIcons.profileAdd, color: AppColors.primary500, width: 20, height: 20),
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizer.createNewAccount,
                style: TextStyles.semiBold16.copyWith(color: AppColors.primary500, height: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
