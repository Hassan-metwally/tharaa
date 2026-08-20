import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'app_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String? text)? validator;
  final bool readOnly;

  const PasswordField({super.key, required this.controller, this.hintText, this.labelText, this.validator, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: AppTextFormField(
        controller: controller,
        inputType: TextInputType.visiblePassword,
        isTextSecured: !readOnly,
        readOnly: readOnly,
        maxLength: 40,
        validator: (text) {
          if (validator != null) {
            return validator!(text);
          }
          return Validator(text).password;
        },
        label: labelText ?? appLocalizer.password,
        hint: hintText ?? appLocalizer.passwordHint,
      ),
    );
  }
}
