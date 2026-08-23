import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tharaa/material/inputs/app_text_form_field.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String email)? onChanged;
  final bool isOptional;
  final TextStyle? labelStyle;
  final String? hint;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool hasRequiredSymbol;
  final String? helperText;
  final bool showHelperText;
  final bool showPhoneIcon;
  final EdgeInsetsGeometry margin;

  const PhoneField({
    super.key,
    required this.controller,
    this.onChanged,
    this.isOptional = false,
    this.labelStyle,
    this.hint,
    this.labelText,
    this.style,
    this.hintStyle,
    this.suffixIcon,
    this.readOnly = false,
    this.hasRequiredSymbol = false,
    this.helperText,
    this.showHelperText = true,
    this.showPhoneIcon = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = AppLanguageCubit.of(context).isArabic;
    final Widget countryCode = suffixIcon ?? const _CountryCodeAffix();
    final Widget? phoneIcon = showPhoneIcon ? const _PhoneHintIcon() : null;

    return IgnorePointer(
      ignoring: readOnly,
      child: AppTextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        inputType: TextInputType.phone,
        readOnly: readOnly,
        label: labelText ?? appLocalizer.phoneNumber,
        helperText: showHelperText ? (helperText ?? appLocalizer.phoneNumberHelperText) : null,
        hasRequiredSymbol: hasRequiredSymbol && !isOptional,
        hintTextStyle: hintStyle,
        validator: (text) => Validator(text).phone,
        onChanged: onChanged,
        hint: hint ?? appLocalizer.phoneNumberExampleHint,
        labelTextStyle: labelStyle,
        inputTextStyle: style,
        textDirection: TextDirection.ltr,
        margin: margin,
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        prefixIcon: isArabic
            ? (phoneIcon != null ? (_) => phoneIcon : null)
            : (_) => countryCode,
        suffixIcon: isArabic ? countryCode : phoneIcon,
      ),
    );
  }
}

class _PhoneHintIcon extends StatelessWidget {
  const _PhoneHintIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 20,
        height: 20,
        child: Center(
          child: AppSvgIcon(path: AppIcons.mobile, width: 12, height: 15, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class _CountryCodeAffix extends StatelessWidget {
  const _CountryCodeAffix();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _SaudiFlag(),
            const SizedBox(width: 6),
            Text("+966", style: TextStyles.regular14.copyWith(color: AppColors.black500, height: 1.2)),
            const SizedBox(width: 8),
            Container(width: 1, height: 22, color: AppColors.black200),
          ],
        ),
      ),
    );
  }
}

class _SaudiFlag extends StatelessWidget {
  const _SaudiFlag();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 22,
        height: 22,
        child: ColoredBox(
          color: const Color(0xFF006C35),
          child: Center(
            child: Text("🇸🇦", style: TextStyles.regular16.copyWith(height: 1, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
