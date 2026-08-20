import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';
import 'app_text_form_field.dart';

class AboutField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String email)? onChanged;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final String? lable;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final bool hasRequiredSymbol;
  final bool isRequired;

  final String? prefixIcon;
  final int? maxLength;
  const AboutField({
    super.key,
    this.controller,
    this.onChanged,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.suffixIcon,
    this.lable,
    this.hint,
    this.prefixIcon,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.hasRequiredSymbol = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      inputType: TextInputType.text,
      hintTextStyle: hintStyle,
      validator: isRequired ? (text) => Validator(text).defaultValidator : null,
      onChanged: onChanged,
      label: lable,
      hint: hint ?? appLocalizer.writeHere,
      labelTextStyle: labelStyle,
      inputTextStyle: style,
      minLines: minLines ?? 6,
      maxLines: maxLines ?? 10,
      hasRequiredSymbol: hasRequiredSymbol,
      maxLength: maxLength ?? 500,
      prefixIcon: prefixIcon != null
          ? (isFocused) => Align(
              alignment: Alignment.topCenter,
              heightFactor: 3,
              child: AppSvgIcon(path: prefixIcon!),
            )
          : null,
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [?suffixIcon]),
      ),
    );
  }
}
