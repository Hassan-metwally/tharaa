import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../domain/enums/orders/order_status_enum.dart';
import '../drop_downs/drop_down.dart';
import 'order_status_drop_down_cubit.dart';

class OrderStatusDropDown extends StatelessWidget {
  const OrderStatusDropDown({super.key, required this.controller, this.onChanged, this.hasRequiredSymbol = false, this.label});
  final ValidatorFieldController<OrderStatusEnum?> controller;
  final void Function(OrderStatusEnum? value)? onChanged;
  final bool hasRequiredSymbol;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return AppSingleDropDown(
      controller: controller,
      itemDisplay: (displayValue) => displayValue?.title,
      onChanged: onChanged,
      title: label ?? appLocalizer.orderStatus,
      hint: "appLocalizer.selectOrderStatus",
      hasRequiredSymbol: hasRequiredSymbol,
      cubit: OrderStatusDropDownCubit(),
    );
  }
}
