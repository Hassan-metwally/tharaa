import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum ProviderStatusEnum {
  opened("opened"),
  closed("closed");

  final String? value;
  const ProviderStatusEnum(this.value);

  static ProviderStatusEnum fromString(String value) {
    switch (value) {
      case "opened":
        return opened;
      case "closed":
        return closed;
      default:
        return closed;
    }
  }

  String get title {
    switch (this) {
      case ProviderStatusEnum.opened:
        return appLocalizer.open;
      case ProviderStatusEnum.closed:
        return appLocalizer.closed;
    }
  }

  Color get bgColor {
    switch (this) {
      case ProviderStatusEnum.opened:
        return AppColors.success50;
      case ProviderStatusEnum.closed:
        return AppColors.red50;
    }
  }

  Color get titlColor {
    switch (this) {
      case ProviderStatusEnum.opened:
        return AppColors.success500;
      case ProviderStatusEnum.closed:
        return AppColors.error;
    }
  }
}
