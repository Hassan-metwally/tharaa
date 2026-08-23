import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import 'app_text_form_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Widget? prefixIcon;
  final String? hint;
  final TextStyle? labelTextStyle;
  final bool isOptional;
  final EdgeInsetsGeometry margin;

  const EmailField({
    super.key,
    required this.controller,
    this.labelText,
    this.prefixIcon,
    this.hint,
    this.labelTextStyle,
    this.isOptional = false,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      inputType: TextInputType.emailAddress,
      validator: (text) => Validator(text).email(isOptional: isOptional),
      label: labelText ?? appLocalizer.emailAddress,
      labelTextStyle: labelTextStyle,
      hint: hint ?? appLocalizer.enterEmailAddress,
      margin: margin,
      inputFormatters: [FilteringTextInputFormatter.deny(" "), AlwaysLowerCaseInputFormatter()],
      prefixIcon: prefixIcon != null ? (_) => prefixIcon! : null,
    );
  }
}
