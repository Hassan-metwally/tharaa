import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';
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
  final int maxLength;
  final EdgeInsetsGeometry margin;
  final TextStyle? labelTextStyle;
  final bool showPrefixIcon;

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
    this.maxLength = 100,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.labelTextStyle,
    this.showPrefixIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: AppTextFormField(
        controller: controller,
        maxLength: maxLength,
        hasCounter: true,
        readOnly: readOnly,
        validator: validator ?? (name) => Validator(name).name(),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        hasRequiredSymbol: hasRequiredSymbol,
        label: lable ?? appLocalizer.name,
        labelTextStyle: labelTextStyle,
        hint: hint ?? appLocalizer.nameHint,
        margin: margin,
        inputType: TextInputType.name,
        maxLines: 1,
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
        prefixIcon: showPrefixIcon ? (_) => prefix ?? AppSvgIcon(path: AppIcons.userOutline, size: 20, color: AppColors.black400) : null,
      ),
    );
  }
}
