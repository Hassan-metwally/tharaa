import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/app_select_location.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/inputs/avatar_field.dart';
import '../../../../material/inputs/intel_phone/phone_field.dart';
import '../../../../material/inputs/media_field.dart';
import '../../../../material/inputs/name_field.dart';
import '../../../../material/inputs/number_field.dart';
import '../../../../material/inputs/validator_field/validator_field.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../common/domain/entity/city_entity.dart';
import '../../../common/domain/entity/common_entity.dart';
import '../../../common/presentation/drop_downs/banks/banks_drop_down.dart';
import '../../../common/presentation/drop_downs/cities/cities_drop_down.dart';
import '../../../common/presentation/drop_downs/services/services_drop_down.dart';
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
  final avatarController = ValidatorFieldController<AttachmentEntity?>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final commercialRegistrationController = TextEditingController();
  final termsController = ValidatorFieldController<bool>(initialValue: false);
  final cityController = ValidatorFieldController<CityEntity?>();
  final serviceController = ValidatorFieldController<CommonEntity?>();
  final bankController = ValidatorFieldController<CommonEntity?>();
  final ibanController = TextEditingController();
  final ibanCertificateImageController = ValidatorFieldController<AttachmentEntity?>();
  final commercialRegisterImageController = ValidatorFieldController<AttachmentEntity?>();
  final operatingLicenseImageController = ValidatorFieldController<AttachmentEntity?>();
  final operatingLicenseNumberController = TextEditingController();

  String? address;
  double? lat;
  double? lng;
  CityEntity? city;

  void _onRegisterPressed() {
    final isValidForm = formKey.validateAndScrollToFirstError();
    if (isValidForm) {
      if (termsController.value == false) {
        AppToasts.error(context, message: appLocalizer.youMustAgreeTermsAndConditionsFirst);
        return;
      }
      context.read<RegisterCubit>().register(
        RegisterParams(
          avatar: avatarController.value!,
          phone: phoneController.text,
          name: nameController.text,
          city: cityController.value!,
          service: serviceController.value!,
          commercialRegistrationNumber: commercialRegistrationController.text,
          address: address ?? '',
          lat: lat ?? 0.0,
          lng: lng ?? 0.0,
          bank: bankController.value!,
          iban: ibanController.text,
          commercialRegisterImage: commercialRegisterImageController.value!,
          ibanCertificateImage: ibanCertificateImageController.value!,
          operatingLicenseImage: operatingLicenseImageController.value!,
          operatingLicenseNumber: operatingLicenseNumberController.text,
        ),
      );
    }
  }

  void _onRegisterSuccess() {
    OtpPage.show(
      context,
      arguments: OtpScreenArguments(countryCode: "+966", phone: phoneController.text, verifyCase: OtpScreenCaseEnum.register),
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
        return Scaffold(
          appBar: AppBar(backgroundColor: AppColors.backgroundColor),
          body: IgnorePointer(
            ignoring: state.isLoading,
            child: Form(
              key: formKey,
              canPop: state.isLoading == false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(appLocalizer.register, style: TextStyles.regular20.copyWith(color: AppColors.black)),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: appLocalizer.registerWelcomeMessage,
                        children: [
                          TextSpan(
                            text: "\t${appLocalizer.appName}",
                            style: TextStyles.regular16.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyles.light16.copyWith(color: AppColors.black700),
                    ),
                    const SizedBox(height: 20),
                    ProfileAvatarWidget(controller: avatarController),
                    const SizedBox(height: 5),
                    NameField(controller: nameController, lable: appLocalizer.providerName, hint: appLocalizer.enterProviderName),
                    const SizedBox(height: 10),
                    PhoneField(controller: phoneController),
                    CitiesDropDown(
                      cityController: cityController,
                      onChanged: (value) => setState(() {
                        city = value;
                        formKey.currentState?.validate();
                      }),
                    ),
                    const SizedBox(height: 20),
                    AppSelectLocationWidget(
                      shoulsSelectCityFirst: true,
                      lable: appLocalizer.locationOnMap,
                      polygons: cityController.value?.polygons,
                      validator: (text) => Validator(text).selectLocationValidator(isCitySelected: cityController.value != null),
                      hint: appLocalizer.enterAddressLocationOnMap,
                      onSelect: (value) {
                        address = value.address;
                        lat = value.lat;
                        lng = value.lng;
                      },
                    ),
                    const SizedBox(height: 20),
                    ServicesDropDown(serviceController: serviceController),
                    const SizedBox(height: 20),
                    BanksDropDown(bankController: bankController),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: ibanController,
                      label: appLocalizer.ibanNumber,
                      hint: appLocalizer.enterIbanNumber,
                      validator: (text) => Validator(text).ibanValidator,
                      maxLength: 24,
                      hasCounter: true,
                    ),
                    const SizedBox(height: 20),
                    MediaFieldWidget(
                      controller: ibanCertificateImageController,
                      label: appLocalizer.ibanCertificateImage,
                      hint: appLocalizer.uploadIbanCertificateImage,
                      validationMessage: appLocalizer.fieldRequired,
                    ),
                    const SizedBox(height: 20),
                    NumberField(
                      controller: commercialRegistrationController,
                      label: appLocalizer.commercialRegistrationNumber,
                      hint: appLocalizer.enterCommercialRegistrationNumber,
                      validator: (text) => Validator(text).commercialRegistrationValidator,
                      maxLength: 10,
                      intOnly: true,
                    ),
                    const SizedBox(height: 20),
                    MediaFieldWidget(
                      controller: commercialRegisterImageController,
                      label: appLocalizer.commercialRegisterImage,
                      hint: appLocalizer.uploadCommercialRegisterImage,
                      validationMessage: appLocalizer.fieldRequired,
                    ),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: operatingLicenseNumberController,
                      label: appLocalizer.operatingLicenseNumber,
                      hint: appLocalizer.enterOperatingLicenseNumber,
                      validator: (text) => Validator(text).operatingLicenseNumberValidator,
                    ),
                    const SizedBox(height: 20),
                    MediaFieldWidget(
                      controller: operatingLicenseImageController,
                      label: appLocalizer.operatingLicenseImage,
                      hint: appLocalizer.uploadOperatingLicenseImage,
                      validationMessage: appLocalizer.fieldRequired,
                    ),
                    const SizedBox(height: 20),
                    AcceptTermsAndConditionsWidget(controller: termsController),
                    const SizedBox(height: 24),
                    AppButton(text: appLocalizer.register, isLoading: state.isLoading, onPressed: _onRegisterPressed),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text: appLocalizer.alreadyHaveAccount,
                        children: [
                          TextSpan(
                            text: "\t${appLocalizer.login}",
                            recognizer: TapGestureRecognizer()..onTap = Navigator.of(context).pop,
                            style: TextStyles.regular14.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      style: TextStyles.regular14,
                    ),
                  ],
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
    super.dispose();
  }
}
