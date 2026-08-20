import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/core.dart';
import '../src/google_maps/domain/entities/address_entity.dart';
import '../src/google_maps/presentation/maps_main_page.dart';
import 'inputs/app_text_form_field.dart';
import 'media/svg_icon.dart';

class AppSelectLocationWidget extends StatefulWidget {
  final MapAddressEntity? mapLocation;
  final String? Function(String?)? validator;
  final void Function(MapAddressEntity value) onSelect;
  final String? lable;
  final String? hint;
  final bool hasRequiredSymbol;
  final Set<Polygon>? polygons;
  final bool shoulsSelectCityFirst;
  const AppSelectLocationWidget({
    super.key,
    this.mapLocation,
    required this.onSelect,
    this.validator,
    this.lable,
    this.hint,
    this.hasRequiredSymbol = false,
    this.polygons,
    this.shoulsSelectCityFirst = false,
  });

  @override
  State<AppSelectLocationWidget> createState() => _AppSelectLocationWidgetState();
}

class _AppSelectLocationWidgetState extends State<AppSelectLocationWidget> {
  MapAddressEntity? mapLocation;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    mapLocation = widget.mapLocation;
    if (mapLocation != null) {
      controller.text = mapLocation!.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      readOnly: true, // Disables the cursor
      controller: controller,
      validator: widget.validator ?? (text) => Validator(text).defaultValidator,
      // isRequired: true,
      inputType: TextInputType.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      hasRequiredSymbol: widget.hasRequiredSymbol,
      label: widget.lable ?? appLocalizer.locationOnMap,
      hint: widget.hint,
      suffixIcon: UnconstrainedBox(child: AppSvgIcon(path: "")),
      filled: true,
      onTap: () {
        if (widget.shoulsSelectCityFirst && widget.polygons == null) {
          return;
        }
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => MapsMainPage(initialMapAddress: widget.mapLocation, polygons: widget.polygons),
              ),
            )
            .then((value) {
              if (value != null) {
                widget.onSelect(value);
                setState(() {
                  mapLocation = value;
                  controller.text = value.address;
                });
              }
            });
      },
    );
  }
}
