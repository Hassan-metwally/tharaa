import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/core.dart';
import '../src/google_maps/domain/entities/address_entity.dart';
import '../src/google_maps/presentation/maps_main_page.dart';
import 'media/svg_icon.dart';

const Color _kCardFill = Color(0xFFF7F8FA);
const double _kMapHeight = 124;
const double _kMarkerHaloSize = 40;
const double _kMarkerDotSize = 16;
const LatLng _kDefaultMapTarget = LatLng(24.774265, 46.738586);

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
  GoogleMapController? _mapController;
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    mapLocation = widget.mapLocation;
    if (mapLocation != null) {
      controller.text = mapLocation!.address;
    }
  }

  void _onTap() {
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
            _fieldKey.currentState?.didChange(value.address);
            final LatLng target = LatLng(value.lat, value.lng);
            _mapController?.animateCamera(CameraUpdate.newLatLng(target));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).inputDecorationTheme;
    final String addressText = controller.text;
    final bool hasAddress = addressText.isNotEmpty;

    return FormField<String>(
      key: _fieldKey,
      initialValue: controller.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator ?? (text) => Validator(text).defaultValidator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _onTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  _LocationMapPreview(
                    lat: mapLocation?.lat,
                    lng: mapLocation?.lng,
                    onMapCreated: (controller) => _mapController = controller,
                  ),
                  const SizedBox(height: Dimensions.p4),
                  _SelectedLocationCard(
                    label: widget.lable ?? appLocalizer.locationOnMap,
                    hasRequiredSymbol: widget.hasRequiredSymbol,
                    address: hasAddress ? addressText : (widget.hint ?? ''),
                    isHint: !hasAddress,
                  ),
                ],
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.p8),
                child: Text(field.errorText!, style: theme.errorStyle),
              ),
          ],
        );
      },
    );
  }
}

class _LocationMapPreview extends StatelessWidget {
  const _LocationMapPreview({required this.lat, required this.lng, required this.onMapCreated});

  final double? lat;
  final double? lng;
  final void Function(GoogleMapController controller) onMapCreated;

  LatLng get _target {
    if (lat == null || lng == null || (lat == 0 && lng == 0)) return _kDefaultMapTarget;
    return LatLng(lat!, lng!);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.r16),
      child: SizedBox(
        width: double.infinity,
        height: _kMapHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: _target, zoom: 11),
                  onMapCreated: onMapCreated,
                  liteModeEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                ),
              ),
            ),
            const _MapLocationMarker(),
          ],
        ),
      ),
    );
  }
}

class _MapLocationMarker extends StatelessWidget {
  const _MapLocationMarker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kMarkerHaloSize,
      height: _kMarkerHaloSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: _kMarkerHaloSize,
            height: _kMarkerHaloSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacityPercent(30)),
          ),
          Container(
            width: _kMarkerDotSize,
            height: _kMarkerDotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.white, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedLocationCard extends StatelessWidget {
  const _SelectedLocationCard({required this.label, required this.hasRequiredSymbol, required this.address, required this.isHint});

  final String label;
  final bool hasRequiredSymbol;
  final String address;
  final bool isHint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p12),
      decoration: BoxDecoration(color: _kCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
      child: Row(
        children: [
          AppSvgIcon(path: AppIcons.location, width: Dimensions.ic24, height: Dimensions.ic24),
          const SizedBox(width: Dimensions.p6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.rich(
                  TextSpan(
                    text: label,
                    style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                    children: [
                      if (hasRequiredSymbol)
                        TextSpan(
                          text: '\t*',
                          style: TextStyles.regular12.copyWith(color: AppColors.error, height: 1),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.p8),
                Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isHint
                      ? TextStyles.regular12.copyWith(color: AppColors.oldPriceColor, height: 1)
                      : TextStyles.medium12.copyWith(color: AppColors.black900, height: 1),
                ),
              ],
            ),
          ),
          const SizedBox(width: Dimensions.p6),
          Text(
            appLocalizer.change,
            style: TextStyles.semiBold12.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
