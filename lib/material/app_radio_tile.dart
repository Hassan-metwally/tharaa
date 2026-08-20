import 'package:flutter/material.dart';

import '../core/core.dart';

class AppRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Widget? child;
  final String? titleText;
  final EdgeInsetsGeometry padding;
  final Color unSelectedColor;
  final Color selectedColor;
  final Color borderColor;
  final AlignmentGeometry alignment;
  final ListTileControlAffinity controlAffinity;

  const AppRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.titleText,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.unSelectedColor = Colors.black,
    this.selectedColor = Colors.black,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderColor = const Color(0xffECEDEE),
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;
    final textStyle = TextStyles.medium12.copyWith(color: selectedColor, height: 1);
    final color = isSelected ? selectedColor : unSelectedColor;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged(value);
      },
      child: Container(
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor),
        ),
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (ListTileControlAffinity.leading == controlAffinity) AppRadioWidget(isSelected: isSelected, activeColor: color),
            if (ListTileControlAffinity.leading == controlAffinity) const SizedBox(width: 10),
            Expanded(
              child: child != null ? child! : Text(titleText ?? "", style: textStyle.copyWith(height: .7, color: color)),
            ),
            if (ListTileControlAffinity.trailing == controlAffinity) const SizedBox(width: 10),
            if (ListTileControlAffinity.trailing == controlAffinity) AppRadioWidget(isSelected: isSelected, activeColor: color),
          ],
        ),
      ),
    );
  }
}

class AppRadioWidget extends StatelessWidget {
  const AppRadioWidget({super.key, required this.isSelected, this.activeColor, this.unActiveColor, this.size = 16});

  final bool isSelected;
  final Color? activeColor;
  final Color? unActiveColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? (activeColor ?? AppColors.primary) : (unActiveColor ?? AppColors.hintColor);
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: isSelected
          ? AnimatedContainer(
              margin: const EdgeInsets.all(1.5),
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            )
          : const SizedBox(),
    );
  }
}
