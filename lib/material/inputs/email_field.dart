import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import 'app_text_form_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Widget? prefixIcon;

  const EmailField({super.key, required this.controller, this.labelText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      inputType: TextInputType.emailAddress,
      validator: (text) => Validator(text).email(),
      label: labelText ?? appLocalizer.emailAddress,
      hint: appLocalizer.enterEmailAddress,
      inputFormatters: [FilteringTextInputFormatter.deny(" "), AlwaysLowerCaseInputFormatter()],
      prefixIcon: prefixIcon != null ? (_) => prefixIcon! : null,
    );
  }
}
