part of '../phone_field.dart';

class IntlPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;
  final Color? borderColor;
  final void Function(IntelPhoneNumberEntity phoneNumber)? onChange;
  final String? errorText;
  final IntelPhoneNumberEntity? initialValue;
  final Function(bool isValid)? isValidateListener;
  final bool readOnly;
  final bool showCountryCode;
  final bool? filled;
  final String? label;
  final TextStyle? labelStyle;

  final String? Function(IntelPhoneNumberEntity? phoneNumber)? validator;
  final bool enabled;

  const IntlPhoneField({
    super.key,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.hint,
    this.suffix,
    this.prefix,
    this.borderColor,
    this.onChange,
    this.errorText,
    this.initialValue,
    this.readOnly = false,
    this.showCountryCode = true,
    this.isValidateListener,
    this.validator,
    this.filled,
    this.enabled = true,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label ?? appLocalizer.phoneNumber, style: labelStyle ?? Theme.of(context).inputDecorationTheme.labelStyle),
            const SizedBox(height: 6),
            Directionality(
              textDirection: AppLanguageCubit.of(context).isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: _IntlPhoneField(
                initialValue: initialValue?.number,
                initialCountryCode: initialValue?.countryISOCode ?? "SA",
                onChanged: onChange,
                enabled: enabled,
                validator: validator,
                autovalidateMode: AutovalidateMode.disabled,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                invalidNumberMessage: appLocalizer.invalidPhoneNumber,
                readOnly: readOnly,
                controller: controller,
                style: TextStyles.regular12.copyWith(color: AppColors.textColor),
                hint: hint ?? appLocalizer.phoneNumberHint,
                isValidateListener: isValidateListener,
                cursorColor: AppColors.primary,
                dropdownIcon: Icon(Icons.arrow_drop_down_rounded, size: 25, color: AppColors.secondary400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
