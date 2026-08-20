import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import 'app_text_form_field.dart';

class NameField extends StatelessWidget {
  final String? lable;
  final String? hint;
  final void Function(String name)? onChanged;
  final void Function(String name)? onFieldSubmitted;
  final TextEditingController controller;
  final String? Function(String? text)? validator;
  final bool readOnly;
  final Widget? prefix;
  final bool hasRequiredSymbol;

  const NameField({
    required this.controller,
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.readOnly = false,
    this.prefix,
    this.lable,
    this.hint,
    this.hasRequiredSymbol = false,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: AppTextFormField(
        controller: controller,
        maxLength: 50,
        readOnly: readOnly,
        validator: validator ?? (name) => Validator(name).name(),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        hasRequiredSymbol: hasRequiredSymbol,
        label: lable ?? appLocalizer.name,
        hint: hint ?? appLocalizer.nameHint,
        inputType: TextInputType.name,
        maxLines: 3,
        minLines: 1,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
          CapitalizeFirstInputFormatter(),
          FilteringTextInputFormatter.deny("*"),
          FilteringTextInputFormatter.deny("\t\t"),
          FilteringTextInputFormatter.deny("-"),
          FilteringTextInputFormatter.deny("/"),
          FilteringTextInputFormatter.deny("?"),
          FilteringTextInputFormatter.deny("&"),
          FilteringTextInputFormatter.deny("%"),
          FilteringTextInputFormatter.deny("\$"),
          FilteringTextInputFormatter.deny("@"),
          FilteringTextInputFormatter.deny("!"),
          FilteringTextInputFormatter.deny("+"),
          FilteringTextInputFormatter.deny("|"),
          FilteringTextInputFormatter.deny("<"),
          FilteringTextInputFormatter.deny(">"),
          FilteringTextInputFormatter.deny("{"),
          FilteringTextInputFormatter.deny("}"),
          FilteringTextInputFormatter.deny("["),
          FilteringTextInputFormatter.deny("]"),
          FilteringTextInputFormatter.deny("."),
          FilteringTextInputFormatter.deny("~"),
          FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
        ],
        prefixIcon: prefix != null
            ? (_) {
                return prefix!;
              }
            : null,
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            final text = value.text;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("${text.length}/50", style: TextStyles.light12.copyWith(color: AppColors.black400)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
