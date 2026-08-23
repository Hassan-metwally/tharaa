part of '../contact_us_page.dart';

class _ContactUsSendMessageTab extends StatelessWidget {
  const _ContactUsSendMessageTab({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.messageContentController,
    required this.messageTypeController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageContentController;
  final ValidatorFieldController<ContactUsMessageType?> messageTypeController;

  static TextStyle get _labelStyle => TextStyles.semiBold14.copyWith(color: AppColors.black900);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameField(
            controller: nameController,
            lable: appLocalizer.fullName,
            margin: EdgeInsets.zero,
            labelTextStyle: _labelStyle,
            showPrefixIcon: false,
          ),
          const SizedBox(height: Dimensions.p16),
          PhoneField(
            controller: phoneController,
            margin: EdgeInsets.zero,
            labelStyle: _labelStyle,
            showHelperText: false,
            showPhoneIcon: false,
          ),
          const SizedBox(height: Dimensions.p16),
          EmailField(
            controller: emailController,
            margin: EdgeInsets.zero,
            hint: appLocalizer.emailExampleHint,
            labelTextStyle: _labelStyle,
          ),
          const SizedBox(height: Dimensions.p8),
          AppSingleDropDown(
            controller: messageTypeController,
            itemDisplay: (displayValue) => displayValue?.title,
            title: appLocalizer.messageType,
            hint: appLocalizer.selectMessageType,
            items: ContactUsMessageType.values,
            titleStyle: _labelStyle,
          ),
          const SizedBox(height: Dimensions.p8),
          AppTextFormField(
            controller: messageContentController,
            minLines: 4,
            maxLines: 6,
            margin: EdgeInsets.zero,
            label: appLocalizer.messageText,
            hint: appLocalizer.writeYourMessage,
            labelTextStyle: _labelStyle,
            validator: (text) {
              return Validator(text).defaultValidator;
            },
          ),
          const SizedBox(height: Dimensions.p16),
        ],
      ),
    );
  }
}
