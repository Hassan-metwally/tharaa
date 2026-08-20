import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../domain/entity/common_entity.dart';
import '../drop_downs/drop_down.dart';
import 'services_drop_down_cubit.dart';

class ServicesDropDown extends StatelessWidget {
  const ServicesDropDown({super.key, required this.serviceController, this.onChanged, this.hasRequiredSymbol = false, this.label});
  final ValidatorFieldController<CommonEntity?> serviceController;
  final void Function(CommonEntity? value)? onChanged;
  final bool hasRequiredSymbol;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return AppSingleDropDown(
      controller: serviceController,
      itemDisplay: (displayValue) => displayValue?.name,
      onChanged: onChanged,
      title: label ?? appLocalizer.services,
      hint: appLocalizer.chooseService,
      hasRequiredSymbol: hasRequiredSymbol,
      cubit: ServicesDropDownCubit(),
    );
  }
}
