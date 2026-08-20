import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../media/svg_icon.dart';

part 'validator_controller.dart';

// ValidatorField that uses the key approach
class ValidatorField<T> extends FormField<T> {
  final ValidatorFieldController<T> controller;
  final Widget Function(BuildContext context, String? errorMessage, bool hasError, T? value) build;

  ValidatorField({required this.controller, required this.build, super.validator, super.onSaved})
    : super(
        key: controller.fieldKey,
        initialValue: controller.value,
        builder: (FormFieldState<T> field) {
          return AnimatedSize(
            duration: Durations.medium3,
            alignment: AlignmentDirectional.centerStart,
            child: build(field.context, field.errorText, field.hasError, field.value),
          );
        },
      );
}

class DefaultInputFieldDesign extends StatelessWidget {
  const DefaultInputFieldDesign({
    super.key,
    required this.title,
    required this.hint,
    required this.hasError,
    required this.errorMessage,
    required this.onTap,
    this.value,
    this.prefixIconPath,
    this.prefixIcColor,
    this.titleStyle,
    this.suffixIconPath,
    this.hintStyle,
    this.inputStyle,
    this.heroTag,
    this.suffixIcon,
    this.hasRequiredSymbol = false,
  });

  final String title;
  final bool hasRequiredSymbol;
  final String hint;
  final bool hasError;
  final String errorMessage;
  final VoidCallback onTap;
  final String? value;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Color? prefixIcColor;
  final Widget? suffixIcon;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final defaultInputDecoration = Theme.of(context).inputDecorationTheme;
    final lableStyle = titleStyle ?? defaultInputDecoration.labelStyle ?? TextStyles.regular16;
    final hintStyle = this.hintStyle ?? defaultInputDecoration.hintStyle;
    final inputStyle = this.inputStyle ?? TextStyles.light12.copyWith(color: AppColors.textColor);
    final defaultBorderColor = defaultInputDecoration.border?.borderSide.color ?? AppColors.enabledBorderColor;
    final errorBorderColor = defaultInputDecoration.focusedErrorBorder?.borderSide.color ?? AppColors.red700;
    final borderColor = hasError ? errorBorderColor : defaultBorderColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AnimatedSize(
        clipBehavior: Clip.antiAlias,
        duration: Durations.medium4,
        reverseDuration: Durations.medium4,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: lableStyle,
                    children: [
                      if (hasRequiredSymbol)
                        TextSpan(
                          text: "\t*",
                          style: lableStyle.copyWith(color: AppColors.error),
                        ),
                    ],
                  ),
                ),
              ),
            Builder(
              builder: (context) {
                final Widget child = GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTap,
                  child: AnimatedContainer(
                    clipBehavior: Clip.antiAlias,
                    width: double.infinity,
                    duration: Durations.medium4,
                    constraints: Theme.of(context).inputDecorationTheme.constraints,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                    ),
                    padding: Theme.of(context).inputDecorationTheme.contentPadding,
                    child: Row(
                      children: [
                        if (prefixIconPath != null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: AppSvgIcon(path: prefixIconPath ?? '', size: 20, color: prefixIcColor),
                          ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            child: value?.isNotEmpty == true
                                ? Text(value ?? '', maxLines: 1, style: inputStyle)
                                : Text(hint, maxLines: 1, style: hintStyle),
                          ),
                        ),
                        const SizedBox(width: 4),
                        ?suffixIcon,
                        if (suffixIconPath?.isNotEmpty == true)
                          AppSvgIcon(
                            path: suffixIconPath ?? '',
                            // color: AppColors.text,
                          ),
                        if (suffixIconPath?.isNotEmpty == false && suffixIcon == null)
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                            // color: AppColors.text,
                          ),
                      ],
                    ),
                  ),
                );
                if (heroTag != null) {
                  return Hero(
                    tag: heroTag!,
                    child: Material(color: Colors.transparent, child: child),
                  );
                } else {
                  return child;
                }
              },
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, top: 4),
                child: Text(errorMessage, style: Theme.of(context).inputDecorationTheme.errorStyle),
              ),
          ],
        ),
      ),
    );
  }
}
