import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/enums/orders/order_status_enum.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatusEnum status;
  final EdgeInsets? padding;
  const OrderStatusWidget({super.key, required this.status, this.padding = const EdgeInsets.all(4)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: status.bgColor),
      child: Text(
        status.title,
        style: TextStyles.regular12.copyWith(color: status.titlColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
