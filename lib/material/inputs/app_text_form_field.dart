import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import '../shimmer/gradiant_widget.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxLength;
  final TextStyle? inputTextStyle;
  final Clip? clipBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final String? initialValue;
  final bool readOnly;
  final bool isTextSecured;
  final void Function()? onTap;
  final String? Function(String? text)? validator;
  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;
  final bool hasCounter;
  final String? label;
  final bool hasRequiredSymbol;
  final TextStyle? labelTextStyle;
  final String? hint;
  final TextStyle? hintTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Widget Function(bool isFocused)? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final int? minLines;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final double titlePadding;

  const AppTextFormField({
    super.key,
    this.controller,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.inputType,
    this.maxLength,
    this.inputTextStyle,
    this.clipBehavior = Clip.antiAlias,
    this.inputFormatters,
    this.textDirection,
    this.initialValue,
    this.readOnly = false,
    this.isTextSecured = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.contentPadding,
    this.label,
    this.hasRequiredSymbol = false,
    this.labelTextStyle,
    this.hint,
    this.hintTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.filled,
    this.fillColor,
    this.minLines,
    this.maxLines,
    this.autovalidateMode,
    this.titlePadding = 4,
    this.focusNode,
    this.hasCounter = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isTextSecured = false;
  final _focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    isTextSecured = widget.isTextSecured;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != hasFocus) {
        hasFocus = _focusNode.hasFocus;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = widget.labelTextStyle ?? Theme.of(context).inputDecorationTheme.labelStyle;
    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label?.isNotEmpty == true)
            Padding(
              padding: EdgeInsets.only(bottom: widget.titlePadding),
              child: Padding(
                padding: EdgeInsets.only(bottom: widget.titlePadding),
                child: RichText(
                  text: TextSpan(
                    text: widget.label,
                    style: labelStyle,
                    children: [
                      if (widget.hasRequiredSymbol)
                        TextSpan(
                          text: "\t*",
                          style: labelStyle?.copyWith(color: AppColors.error),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          TextFormField(
            focusNode: widget.focusNode ?? _focusNode,
            cursorErrorColor: AppColors.red700,
            controller: widget.controller,
            keyboardType: widget.inputType,
            maxLength: widget.maxLength,
            style: widget.inputTextStyle ?? TextStyles.regular12,
            // onTapOutside: (_) => FocusScope.of(context).unfocus(),
            cursorColor: AppColors.primary,
            clipBehavior: widget.clipBehavior!,
            inputFormatters: widget.inputFormatters,
            textDirection: widget.textDirection,
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            obscureText: isTextSecured,
            onTap: widget.onTap,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            minLines: widget.minLines ?? 1,
            maxLines: widget.maxLines ?? 1,
            autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: widget.labelTextStyle,
              floatingLabelStyle: widget.labelTextStyle,
              hintText: widget.hint,
              hintMaxLines: widget.maxLines ?? 10,
              errorMaxLines: widget.maxLines ?? 10,
              hintStyle: widget.hintTextStyle,
              hintTextDirection: widget.textDirection,
              counter: const SizedBox.shrink(),
              enabledBorder: widget.enabledBorder,
              focusedBorder: widget.focusedBorder,
              disabledBorder: widget.disabledBorder,
              errorBorder: widget.errorBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
              prefixIcon: _getPrefixWidget,
              prefixIconConstraints: widget.prefixIconConstraints,
              suffixIcon: widget.suffixIcon ?? _obsecureSuffix ?? _counterSuffix,
              filled: widget.filled,
              fillColor: widget.fillColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget? get _obsecureSuffix {
    if (widget.isTextSecured) {
      return InkWell(
        borderRadius: BorderRadius.circular(50),
        child: UnconstrainedBox(
          child: GradiantWidget(
            child: Icon(isTextSecured ? Icons.visibility_off : Icons.visibility, size: 18, weight: 50, opticalSize: 20, grade: -20),
          ),
        ),
        onTap: () {
          setState(() {
            isTextSecured = !isTextSecured;
          });
        },
      );
    }
    return null;
  }

  Widget? get _counterSuffix {
    if (widget.hasCounter && widget.maxLength != null) {
      return ValueListenableBuilder(
        valueListenable: widget.controller ?? TextEditingController(),
        builder: (context, value, child) {
          final text = value.text;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text("${widget.maxLength}/${text.length}", style: TextStyles.light12.copyWith(color: AppColors.black400)),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  Widget? get _getPrefixWidget {
    if (widget.prefixIcon != null) {
      return UnconstrainedBox(
        child: Padding(padding: const EdgeInsetsDirectional.only(start: 8.0), child: widget.prefixIcon!(hasFocus)),
      );
    }
    return null;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
