import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/core.dart';

const int appOtpFieldsLength = 4;
final Color _fieldColor = AppColors.cardColor;
Color _focusedFieldColor = _fieldColor;
final Color _focusBorderColor = AppColors.focusedBorderColor;
final Color _errorBorderColor = AppColors.error;
final Color _borderColor = AppColors.enabledBorderColor;
final BorderRadius _borderRadius = BorderRadius.circular(16);

class OtpPinCodeWidget extends StatelessWidget {
  final bool hasError;
  final String? errorMessage;
  final bool readOnly;
  final TextEditingController controller;
  final void Function(String value)? onChange;
  final void Function(String value)? onCompleted;
  final String? Function(String? value)? validator;

  const OtpPinCodeWidget({
    super.key,
    required this.controller,
    this.hasError = false,
    this.errorMessage,
    this.readOnly = false,
    this.onChange,
    this.validator,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    const double fieldSize = 60;
    const fieldHeight = fieldSize;
    final textStyle = TextStyles.bold24.copyWith(color: AppColors.primary, height: 1);
    final errorTextStyle = Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(fontSize: 14);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        readOnly: readOnly,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        cursor: Container(
          width: 8,
          height: 2.3,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.primary400),
        ),
        preFilledWidget: Container(
          width: 8,
          height: 2.3,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.black),
        ),
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        defaultPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _borderColor),
          ),
        ),
        submittedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _focusedFieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _focusBorderColor),
          ),
        ),
        followingPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _borderColor),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _focusBorderColor),
          ),
        ),
        errorPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _errorBorderColor),
          ),
        ),
        disabledPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _borderRadius,
            border: Border.all(color: _borderColor),
          ),
        ),
        forceErrorState: hasError,
        errorTextStyle: errorTextStyle,
        onChanged: onChange,
        onCompleted: onCompleted,
        validator: validator,
        errorText: errorMessage,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
