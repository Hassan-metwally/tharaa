import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../domain/entity/common_entity.dart';
import '../drop_downs/drop_down.dart';
import 'banks_drop_down_cubit.dart';

class BanksDropDown extends StatelessWidget {
  const BanksDropDown({super.key, required this.bankController, this.onChanged});
  final ValidatorFieldController<CommonEntity?> bankController;
  final void Function(CommonEntity? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSingleDropDown(
      controller: bankController,
      itemDisplay: (displayValue) => displayValue?.name,
      onChanged: onChanged,
      title: appLocalizer.bank,
      hint: appLocalizer.selectBank,
      cubit: BanksDropDownCubit(),
    );
  }
}
