import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/core.dart';

const int appOtpFieldsLength = 4;

const Color _fieldFill = Color(0xFFF7F8FA);
const Color _placeholderColor = Color(0xFF8B9BB2);
const Color _errorBorderColor = Color(0xFFDD302A);
const BorderRadius _borderRadius = BorderRadius.all(Radius.circular(16));

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
    const double fieldWidth = 50;
    const double fieldHeight = 40;
    final filledTextStyle = TextStyles.bold18.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600);
    final errorTextStyle = Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(fontSize: 14);

    PinTheme pinTheme({Color? borderColor}) {
      return PinTheme(
        width: fieldWidth,
        height: fieldHeight,
        textStyle: filledTextStyle,
        decoration: BoxDecoration(
          color: _fieldFill,
          borderRadius: _borderRadius,
          border: borderColor == null ? null : Border.all(color: borderColor),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        length: appOtpFieldsLength,
        readOnly: readOnly,
        separatorBuilder: (index) => SizedBox(width: index == 1 ? 24 : 12),
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        cursor: Container(
          width: 1.5,
          height: 16,
          decoration: BoxDecoration(color: AppColors.primary500, borderRadius: BorderRadius.circular(1)),
        ),
        preFilledWidget: Text('-', style: TextStyles.regular14.copyWith(color: _placeholderColor, height: 1.5)),
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        defaultPinTheme: pinTheme(),
        submittedPinTheme: pinTheme(),
        followingPinTheme: pinTheme(),
        focusedPinTheme: pinTheme(borderColor: AppColors.primary500),
        errorPinTheme: pinTheme(borderColor: _errorBorderColor),
        disabledPinTheme: pinTheme(),
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
