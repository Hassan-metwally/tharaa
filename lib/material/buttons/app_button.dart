import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../spin_kit_loading_widget.dart';

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool isLoading;
  final bool isEnabled;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? loadingColor;

  const AppButton({
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.textColor,
    this.isExpanded = true,
    this.leading,
    this.trailing,
    this.padding,
    this.loadingColor,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isEnabled == false;
    return Bounce(
      child: ElevatedButton(
        statesController: isDisabled ? WidgetStatesController({WidgetState.disabled}) : null,
        onPressed: isDisabled
            ? null
            : isLoading
            ? () {}
            : onPressed,
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          backgroundBuilder: buttonColor != null
              ? (context, states, child) {
                  return Container(
                    decoration: BoxDecoration(color: buttonColor),
                    child: child,
                  );
                }
              : null,
          padding: buttonColor != null ? EdgeInsets.zero : padding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (leading != null) ...[const SizedBox(width: 6), leading!],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: textStyle ?? TextStyles.bold16.copyWith(color: textColor ?? Colors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 6),
              (isLoading) ? SizedBox(height: 10, child: SpinKitLoadingWidget.medium(color: loadingColor ?? Colors.white)) : trailing!,
            ] else ...[
              const SizedBox(width: 6),
              (isLoading)
                  ? SizedBox(height: 10, child: SpinKitLoadingWidget.medium(color: loadingColor ?? Colors.white))
                  : const SizedBox(),
            ],
          ],
        ),
      ),
    );
  }
}
