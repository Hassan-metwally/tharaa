import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import 'app_text_form_field.dart';

class NumberField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? Function(String? text)? validator;
  final TextEditingController controller;
  final void Function(String number)? onChanged;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool hasCounter;
  final bool? intOnly;
  final int? maxLength;

  const NumberField({
    super.key,
    required this.controller,
    this.onChanged,
    this.labelStyle,
    this.style,
    this.hintStyle,
    required this.label,
    this.hint,
    this.validator,
    this.hasCounter = true,
    this.intOnly = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      inputType: TextInputType.number,
      hintTextStyle: hintStyle,
      validator: validator ?? (text) => Validator(text).defaultValidator,
      onChanged: onChanged,
      label: label,
      hint: hint,
      labelTextStyle: labelStyle,
      inputTextStyle: style,
      maxLines: 1,
      maxLength: maxLength,
      inputFormatters: intOnly == true
          ? [
              FilteringTextInputFormatter.deny("."),
              FilteringTextInputFormatter.deny("~"),
              FilteringTextInputFormatter.deny("\t"),
              FilteringTextInputFormatter.deny("-"),
              FilteringTextInputFormatter.deny(","),
              FilteringTextInputFormatter.deny(" "),
            ]
          : [
              FilteringTextInputFormatter.deny("~"),
              FilteringTextInputFormatter.deny("\t"),
              FilteringTextInputFormatter.deny("-"),
              FilteringTextInputFormatter.deny(","),
              FilteringTextInputFormatter.deny(" "),
            ],
      suffixIcon: hasCounter != false && maxLength != null
          ? ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                final text = value.text;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("$maxLength/${text.length}", style: TextStyles.light12.copyWith(color: AppColors.black400)),
                    ),
                  ],
                );
              },
            )
          : null,
    );
  }
}
