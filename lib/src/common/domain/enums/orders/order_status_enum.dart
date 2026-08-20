import 'package:flutter/widgets.dart';

import '../../../../../core/core.dart';

enum OrderStatusEnum {
  neww,
  inProgress,
  onTheWay,
  arrived,
  cancelled,
  finished;

  String get title {
    switch (this) {
      case OrderStatusEnum.neww:
        return "appLocalizer.neww";
      case OrderStatusEnum.finished:
        return "appLocalizer.finished";
      case OrderStatusEnum.inProgress:
        return "appLocalizer.inPreparation";
      case OrderStatusEnum.cancelled:
        return "appLocalizer.cancelled";
      case OrderStatusEnum.onTheWay:
        return "appLocalizer.onTheWay";
      case OrderStatusEnum.arrived:
        return "appLocalizer.arrived";
    }
  }

  String get value {
    switch (this) {
      case OrderStatusEnum.neww:
        return "new";
      case OrderStatusEnum.finished:
        return "completed";
      case OrderStatusEnum.inProgress:
        return "in_progress";
      case OrderStatusEnum.cancelled:
        return "cancelled";
      case OrderStatusEnum.onTheWay:
        return "on_the_way";
      case OrderStatusEnum.arrived:
        return "arrived";
    }
  }

  static OrderStatusEnum fromJson(String value) {
    switch (value) {
      case "new":
        return OrderStatusEnum.neww;
      case "completed":
        return OrderStatusEnum.finished;
      case "in_progress":
        return OrderStatusEnum.inProgress;
      case "cancelled":
        return OrderStatusEnum.cancelled;
      case "on_the_way":
        return OrderStatusEnum.onTheWay;
      case "arrived":
        return OrderStatusEnum.arrived;
      default:
        return OrderStatusEnum.neww;
    }
  }

  Color get bgColor {
    switch (this) {
      case OrderStatusEnum.neww:
        return AppColors.skyBlueTransparent;
      case OrderStatusEnum.finished:
        return AppColors.success50;
      case OrderStatusEnum.inProgress:
        return AppColors.b14119Transparent;
      case OrderStatusEnum.cancelled:
        return AppColors.primary50;
      case OrderStatusEnum.onTheWay:
        return AppColors.black100;
      case OrderStatusEnum.arrived:
        return AppColors.terquoiseTransparent;
    }
  }

  Color get titlColor {
    switch (this) {
      case OrderStatusEnum.neww:
        return AppColors.skyBlue;
      case OrderStatusEnum.finished:
        return AppColors.success500;
      case OrderStatusEnum.inProgress:
        return AppColors.b14119;
      case OrderStatusEnum.cancelled:
        return AppColors.primary600;
      case OrderStatusEnum.onTheWay:
        return AppColors.black;
      case OrderStatusEnum.arrived:
        return AppColors.terquoise;
    }
  }
}
