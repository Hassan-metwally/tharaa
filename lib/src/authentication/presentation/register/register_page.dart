import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/name_field.dart';
import '../../../../material/inputs/phone_field.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/use_case/register_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import '../otp/otp_page.dart';
import '../widgets/accept_terms_tile.dart';
import 'register_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final termsController = ValidatorFieldController<bool>(initialValue: false);

  void _onRegisterPressed() {
    final isValidForm = formKey.validateAndScrollToFirstError();
    if (isValidForm) {
      if (termsController.value == false) {
        AppToasts.error(context, message: appLocalizer.youMustAgreeTermsAndConditionsFirst);
        return;
      }
      context.read<RegisterCubit>().register(RegisterParams(countryCode: "+966", phone: phoneController.text, name: nameController.text));
    }
  }

  void _onRegisterSuccess() {
    Navigator.of(context).pushNamed(
      AppRoutes.otp,
      arguments: OtpPage(
        arguments: OtpScreenArguments(countryCode: "+966", phone: phoneController.text, verifyCase: OtpScreenCaseEnum.register),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          _onRegisterSuccess();
        } else if (state.isFailure) {
          AppToasts.error(context, message: state.failure?.message ?? '');
        }
      },
      builder: (context, state) {
        final double bottomInset = MediaQuery.paddingOf(context).bottom;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: IgnorePointer(
              ignoring: state.isLoading,
              child: Form(
                key: formKey,
                canPop: state.isLoading == false,
                child: SafeArea(
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
                                const _RegisterHeader(),
                                const SizedBox(height: 32),
                                NameField(
                                  controller: nameController,
                                  lable: appLocalizer.fullName,
                                  margin: EdgeInsets.zero,
                                  labelTextStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900),
                                  prefix: SizedBox(width: 18, height: 18, child: AppSvgIcon(path: AppIcons.profile, width: 18, height: 18)),
                                ),
                                const SizedBox(height: 16),
                                PhoneField(
                                  controller: phoneController,
                                  margin: EdgeInsets.zero,
                                  labelStyle: TextStyles.semiBold14.copyWith(color: AppColors.black900),
                                ),
                                const SizedBox(height: 16),
                                AcceptTermsAndConditionsWidget(controller: termsController),
                              ],
                            ),
                          ),
                        ),
                        _RegisterActions(isLoading: state.isLoading, onPressed: _onRegisterPressed),
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
    nameController.dispose();
    phoneController.dispose();
    termsController.dispose();
    super.dispose();
  }
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          appLocalizer.registerHeadline,
          textAlign: TextAlign.start,
          style: TextStyles.semiBold22.copyWith(color: AppColors.black900, height: 1.6, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          appLocalizer.registerSubtitle,
          textAlign: TextAlign.start,
          style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.6),
        ),
      ],
    );
  }
}

class _RegisterActions extends StatelessWidget {
  const _RegisterActions({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppButton(
        text: appLocalizer.register,
        isLoading: isLoading,
        onPressed: onPressed,
        textStyle: TextStyles.semiBold18.copyWith(color: Colors.white, height: 1, fontWeight: FontWeight.w600),
      ),
    );
  }
}
