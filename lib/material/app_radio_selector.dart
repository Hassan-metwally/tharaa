import 'package:flutter/material.dart';

import '../core/core.dart';
import 'inputs/validator_field/validator_field.dart';

class AppRadioBoolSelector extends StatelessWidget {
  final String title;
  final Widget? icon;
  final String trueTitle;
  final String falseTitle;
  final bool? initialValue;
  final String? Function(bool? value)? validator;
  final ValidatorFieldController<bool?> controller;

  const AppRadioBoolSelector({
    super.key,
    this.initialValue,
    required this.title,
    this.icon,
    required this.trueTitle,
    required this.falseTitle,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValidatorField<bool?>(
      controller: controller,
      validator: validator,
      build: (context, errorMessage, hasError, value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon ?? const SizedBox.shrink(),
                const SizedBox(width: 8),
                Text(title, style: TextStyles.regular14.copyWith(color: AppColors.black900)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _RadioTile<bool>(
                    onChanged: (value) {
                      controller.setValue(value ?? false);
                      controller.validate();
                    },
                    groupValue: value,
                    value: false,
                    titleText: trueTitle,
                    hasError: hasError,
                  ),
                ),
                const SizedBox(width: 17),
                Expanded(
                  child: _RadioTile<bool>(
                    key: UniqueKey(),
                    onChanged: (value) {
                      controller.setValue(value ?? false);
                      controller.validate();
                    },
                    groupValue: value,
                    value: true,
                    titleText: falseTitle,
                    hasError: hasError,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            if (errorMessage?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(errorMessage ?? '', style: Theme.of(context).inputDecorationTheme.errorStyle),
              ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _RadioTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String titleText;
  final bool hasError;

  const _RadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.titleText,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: Durations.medium1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasError
                ? AppColors.red600
                : isSelected
                ? AppColors.primary
                : AppColors.black50,
          ),
          color: isSelected ? AppColors.primary50 : AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: 1,
              duration: Durations.short2,
              child: _RadioWidget(isSelected: isSelected),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(titleText, style: TextStyles.medium12.copyWith(color: isSelected ? AppColors.primary : AppColors.black300)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioWidget extends StatelessWidget {
  const _RadioWidget({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.black200, width: 1.5),
      ),
      child: isSelected
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? AppColors.primary : Colors.white),
            )
          : const SizedBox(),
    );
  }
}
