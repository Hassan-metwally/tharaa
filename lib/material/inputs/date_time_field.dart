import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../media/svg_icon.dart';
import '../overlay/show_modal_bottom_sheet.dart';
import 'validator_field/validator_field.dart';

typedef PickedDateCallback = void Function(DateTime? dateTime);

class AppDatePickerField extends StatelessWidget {
  const AppDatePickerField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validationMessage,
    this.mode = CupertinoDatePickerMode.date,
    this.minimumDate,
    this.maximumDate,
    this.selectableDayPredicate,
    this.dateFormatter,
    this.hasRequiredSymbol = false,
  });

  final ValidatorFieldController<DateTime?> controller;
  final String label;
  final String? hint;
  final String? validationMessage;
  final CupertinoDatePickerMode mode;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool Function(DateTime date)? selectableDayPredicate;
  final String Function(DateTime? date)? dateFormatter;
  final bool hasRequiredSymbol;

  String _getPresentText(DateTime? value) {
    if (value != null) {
      if (mode == CupertinoDatePickerMode.time) {
        return value.toHHMMa;
      } else {
        if (dateFormatter != null) {
          return dateFormatter!(value);
        }
        return value.DDMMYYYY;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorField<DateTime?>(
      controller: controller,
      validator: (value) {
        if (validationMessage != null && value == null) {
          return validationMessage;
        }
        return null;
      },
      build: (context, errorMessage, hasError, value) {
        return DefaultInputFieldDesign(
          title: label,
          hint: hint ?? appLocalizer.dayMonthYear,
          hasError: hasError,
          errorMessage: errorMessage ?? '',
          hasRequiredSymbol: hasRequiredSymbol,
          suffixIcon: AppSvgIcon(path: "", color: AppColors.primary, size: 16),
          value: value != null ? _getPresentText(value) : '',
          onTap: () async {
            if (mode == CupertinoDatePickerMode.date) {
              DateTime? initialValue = value;
              if (minimumDate != null && initialValue?.isAfter(maximumDate ?? DateTime(2100)) == true) {
                initialValue = maximumDate;
              }
              final DateTime? picked = await AppDateTimePickers.pickDatePicker(
                context,
                onDateTimeChanged: (dateTime) {
                  controller.setValue(dateTime);
                  controller.validate();
                },
                initialDate: initialValue,
                maximumDate: maximumDate,
                minimumDate: minimumDate,
                selectableDayPredicate: selectableDayPredicate,
              );
              if (picked != null) {
                controller.setValue(picked);
                controller.validate();
              }
            } else {
              final DateTime? picked = await AppDateTimePickers.pickTime(
                context,
                onDateTimeChanged: (dateTime) {
                  controller.setValue(dateTime);
                  controller.validate();
                },
                initialDate: value,
              );
              if (picked != null) {
                controller.setValue(picked);
                controller.validate();
              }
            }
          },
        );
      },
    );
  }
}

class AppDateTimePickers extends StatefulWidget {
  const AppDateTimePickers({
    super.key,
    this.initialDate,
    this.onDateTimeChanged,
    this.mode,
    this.validator,
    this.minimumDate,
    this.maximumDate,
  });

  final DateTime? initialDate;
  final CupertinoDatePickerMode? mode;
  final PickedDateCallback? onDateTimeChanged;

  final String? Function(DateTime? dateTime)? validator;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  static Future<DateTime?> pickTime(
    BuildContext context, {
    DateTime? initialDate,
    PickedDateCallback? onDateTimeChanged,
    String? Function(DateTime? dateTime)? validator,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    return await showAppModalBottomSheet<DateTime?>(
      context: context,
      child: AppDateTimePickers(
        validator: validator,
        initialDate: initialDate,
        onDateTimeChanged: onDateTimeChanged,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  static Future<DateTime?> pickDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    PickedDateCallback? onDateTimeChanged,
    DateTime? minimumDate,
    DateTime? maximumDate,
    bool Function(DateTime)? selectableDayPredicate,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final DateTime? selectedDate = await showDatePicker(
      cancelText: appLocalizer.back,
      confirmText: appLocalizer.confirm,
      context: context,
      initialDate: initialDate,
      firstDate: minimumDate ?? DateTime.now().subtract(const Duration(days: 365 * 120)),
      currentDate: initialDate,
      routeSettings: const RouteSettings(name: "DateTimeRouteSetting"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      lastDate: maximumDate ?? DateTime.now(),
      selectableDayPredicate: selectableDayPredicate,
    );
    if (selectedDate != null && onDateTimeChanged != null) {
      onDateTimeChanged(selectedDate);
    }
    return selectedDate;
  }

  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    PickedDateCallback? onDateTimeChanged,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    return await showAppModalBottomSheet<DateTime?>(
      context: context,
      child: AppDateTimePickers(
        initialDate: initialDate,
        onDateTimeChanged: onDateTimeChanged,
        mode: CupertinoDatePickerMode.date,
        minimumDate: minimumDate,
        maximumDate: maximumDate?.add(const Duration(minutes: 30)),
      ),
    );
  }

  @override
  State<AppDateTimePickers> createState() => _AppDateTimePickersState();
}

class _AppDateTimePickersState extends State<AppDateTimePickers> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime?>(
      initialValue: widget.initialDate,
      validator: widget.validator,
      builder: (field) {
        return const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
