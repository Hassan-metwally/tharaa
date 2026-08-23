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
  final String? helperText;
  const AppTextFormField({
    this.helperText,
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
    this.titlePadding = 8,
    this.focusNode,
    this.hasCounter = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool isTextSecured;
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    isTextSecured = widget.isTextSecured;
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    hasFocus = _focusNode.hasFocus;
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (hasFocus == _focusNode.hasFocus) return;
    setState(() => hasFocus = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).inputDecorationTheme;
    final labelStyle = widget.labelTextStyle ?? theme.labelStyle;
    final inputStyle = widget.inputTextStyle ?? TextStyles.regular14.copyWith(color: AppColors.textColor, height: 1.4);
    final isMultiline = (widget.maxLines ?? 1) > 1 || (widget.minLines ?? 1) > 1;

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
          TextFormField(
            focusNode: _focusNode,
            cursorErrorColor: AppColors.red700,
            controller: widget.controller,
            keyboardType: widget.inputType,
            maxLength: widget.maxLength,
            style: inputStyle,
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
            textAlignVertical: isMultiline ? TextAlignVertical.top : TextAlignVertical.center,
            autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              helperText: widget.helperText,
              helperStyle: theme.helperStyle,
              contentPadding: widget.contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hint,
              hintMaxLines: widget.maxLines ?? 1,
              errorMaxLines: theme.errorMaxLines ?? 10,
              hintStyle: widget.hintTextStyle,
              hintTextDirection: widget.textDirection,
              counter: const SizedBox.shrink(),
              enabledBorder: widget.enabledBorder,
              focusedBorder: widget.focusedBorder,
              disabledBorder: widget.disabledBorder,
              errorBorder: widget.errorBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
              prefixIcon: _prefixIcon,
              prefixIconConstraints: widget.prefixIconConstraints,
              suffixIcon: widget.suffixIcon != null ? UnconstrainedBox(child: widget.suffixIcon!) : _obsecureSuffix ?? _counterSuffix,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GradiantWidget(
              child: Icon(isTextSecured ? Icons.visibility_off : Icons.visibility, size: 20, weight: 50, opticalSize: 20, grade: -20),
            ),
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
    final controller = widget.controller;
    if (widget.hasCounter && widget.maxLength != null && controller != null) {
      return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          return UnconstrainedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "${value.text.length}/${widget.maxLength}",
                style: TextStyles.regular12.copyWith(color: AppColors.black400),
              ),
            ),
          );
        },
      );
    }
    return null;
  }

  Widget? get _prefixIcon {
    if (widget.prefixIcon == null) return null;
    return UnconstrainedBox(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 4),
        child: widget.prefixIcon!(hasFocus),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
