import 'package:flutter/widgets.dart';

import '../../../../../core/core.dart';

enum OrderStatusEnum {
  neww,
  inProgress,
  readyForDelivery,
  onTheWay,
  delivered,
  cancelled;

  String get title {
    switch (this) {
      case OrderStatusEnum.neww:
        return appLocalizer.orderStatusNew;
      case OrderStatusEnum.inProgress:
        return appLocalizer.orderStatusInPreparation;
      case OrderStatusEnum.readyForDelivery:
        return appLocalizer.orderStatusReadyForDelivery;
      case OrderStatusEnum.onTheWay:
        return appLocalizer.orderStatusOnTheWay;
      case OrderStatusEnum.delivered:
        return appLocalizer.orderStatusDelivered;
      case OrderStatusEnum.cancelled:
        return appLocalizer.orderStatusCancelled;
    }
  }

  String get value {
    switch (this) {
      case OrderStatusEnum.neww:
        return 'new';
      case OrderStatusEnum.inProgress:
        return 'in_progress';
      case OrderStatusEnum.readyForDelivery:
        return 'ready_for_delivery';
      case OrderStatusEnum.onTheWay:
        return 'on_the_way';
      case OrderStatusEnum.delivered:
        return 'delivered';
      case OrderStatusEnum.cancelled:
        return 'cancelled';
    }
  }

  static OrderStatusEnum fromJson(String value) {
    switch (value.toLowerCase().trim()) {
      case 'new':
      case 'neww':
        return OrderStatusEnum.neww;
      case 'in_progress':
      case 'inprogress':
      case 'preparing':
        return OrderStatusEnum.inProgress;
      case 'ready_for_delivery':
      case 'ready':
      case 'arrived':
        return OrderStatusEnum.readyForDelivery;
      case 'on_the_way':
      case 'ontheway':
        return OrderStatusEnum.onTheWay;
      case 'delivered':
      case 'completed':
      case 'finished':
        return OrderStatusEnum.delivered;
      case 'cancelled':
      case 'canceled':
        return OrderStatusEnum.cancelled;
      default:
        return OrderStatusEnum.neww;
    }
  }

  Color get bgColor {
    switch (this) {
      case OrderStatusEnum.neww:
        return const Color(0xFFEFF6FF);
      case OrderStatusEnum.inProgress:
        return const Color(0xFFFFFBEB);
      case OrderStatusEnum.readyForDelivery:
        return const Color(0xFFF5F3FF);
      case OrderStatusEnum.onTheWay:
        return const Color(0xFFECFEFF);
      case OrderStatusEnum.delivered:
        return AppColors.success50;
      case OrderStatusEnum.cancelled:
        return AppColors.red50;
    }
  }

  Color get titlColor {
    switch (this) {
      case OrderStatusEnum.neww:
        return const Color(0xFF2563EB);
      case OrderStatusEnum.inProgress:
        return const Color(0xFFD97706);
      case OrderStatusEnum.readyForDelivery:
        return const Color(0xFF7C3AED);
      case OrderStatusEnum.onTheWay:
        return const Color(0xFF0891B2);
      case OrderStatusEnum.delivered:
        return AppColors.success500;
      case OrderStatusEnum.cancelled:
        return AppColors.red500;
    }
  }
}
