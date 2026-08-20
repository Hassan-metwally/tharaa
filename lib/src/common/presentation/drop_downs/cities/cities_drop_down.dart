import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../material/inputs/validator_field/validator_field.dart';
import '../../../domain/entity/city_entity.dart';
import '../drop_downs/drop_down.dart';
import 'cities_drop_down_cubit.dart';

class CitiesDropDown extends StatelessWidget {
  const CitiesDropDown({super.key, required this.cityController, this.onChanged});
  final ValidatorFieldController<CityEntity?> cityController;
  final void Function(CityEntity? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSingleDropDown(
      controller: cityController,
      itemDisplay: (displayValue) => displayValue?.name,
      onChanged: onChanged,
      title: appLocalizer.city,
      hint: appLocalizer.selectCity,
      cubit: CitiesDropDownCubit(),
    );
  }
}
