// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/core.dart';
import '../../../material/buttons/app_button.dart';
import '../../../material/inputs/app_text_form_field.dart';
import '../../../material/toast/app_toast.dart';
import '../domain/entities/address_entity.dart';
import '../domain/use_cases/google_maps_api/get_location_address_use_case.dart';
import 'maps_main_cubit.dart';
import 'maps_main_state.dart';
import 'widgets/main_page_app_bar.dart';

part 'widgets/only_preview_widgets.dart';
part "widgets/selectable_map_widgets.dart";

const CameraPosition _kInitialPosition = CameraPosition(target: LatLng(24.774265, 46.738586), zoom: 11.0);

class MapsMainPage extends StatelessWidget {
  const MapsMainPage({
    super.key,
    this.initialMapAddress,
    this.onlyPreviewAddress = false,
    this.canAddTittleForAddress = false,
    this.polygons,
  });
  final MapAddressEntity? initialMapAddress;
  final bool onlyPreviewAddress;
  final bool canAddTittleForAddress;
  final Set<Polygon>? polygons;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapsMainCubit(),
      child: _MapsMainPageBody(
        onlyPreviewAddress: onlyPreviewAddress,
        initialMapAddress: initialMapAddress,
        canAddTittleForAddress: canAddTittleForAddress,
        polygons: polygons,
      ),
    );
  }
}

class _MapsMainPageBody extends StatefulWidget {
  final MapAddressEntity? initialMapAddress;
  final bool onlyPreviewAddress;
  final bool canAddTittleForAddress;
  final Set<Polygon>? polygons;
  const _MapsMainPageBody({this.initialMapAddress, this.onlyPreviewAddress = false, this.canAddTittleForAddress = false, this.polygons});

  @override
  State<StatefulWidget> createState() => _MapsMainPageBodyState();
}

class _MapsMainPageBodyState extends State<_MapsMainPageBody> {
  late GoogleMapController _mapController;
  bool _isMapCreated = false;
  final Set<Marker> _mapMarkers = {};
  final Uuid _uuidObj = const Uuid();
  bool _ignoreInitialMapAddressCamera = false;

  bool get isOnlyForPreview {
    return widget.onlyPreviewAddress && widget.initialMapAddress != null && _isMapCreated;
  }

  @override
  void initState() {
    _setLocationMarkerIconsImage();
    super.initState();
  }

  Future<void> _goToMyLocation() async {
    // Ensure permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return; // handle appropriately
    }

    // Get current position
    final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    // Add marker
    _onMapTapped(currentLatLng);
    // Move camera
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 16));
  }

  @override
  Widget build(BuildContext context) {
    final appPolygons = _buildStyledPolygons(context);
    return BlocListener<MapsMainCubit, MapsMainState>(
      listenWhen: (previous, current) => previous.locationState != current.locationState,
      listener: (context, state) {
        if (state.locationState.isSuccess) {
          final latlng = state.locationState.data?.getAsaLtLng;
          if (latlng != null) {
            // If polygons are provided, the initial camera animation must focus on them.
            // We still show the marker for `initialMapAddress`, but we avoid overriding
            // the polygons-fit camera animation.
            final shouldAnimateCamera = !_ignoreInitialMapAddressCamera;
            _ignoreInitialMapAddressCamera = false;
            _setCurrentMapLocation(latlng, snippet: state.locationState.data?.address, animateCamera: shouldAnimateCamera);
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: _kInitialPosition,
              myLocationEnabled: true,
              padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.1, left: 10, right: 10, top: 150),
              myLocationButtonEnabled: false,
              markers: {..._mapMarkers},
              zoomControlsEnabled: false,
              onTap: _onMapTapped,
              polygons: appPolygons,
            ),
            if (!isOnlyForPreview)
              Positioned(
                top: 160,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.my_location, color: Colors.blueGrey),
                    onPressed: _goToMyLocation,
                  ),
                ),
              ),
            if (_isMapCreated)
              if (!isOnlyForPreview)
                _SelectableMapWidgets(canAddTittleForAddress: widget.canAddTittleForAddress)
              else
                _OnlyMapAddressPreviewWidget(
                  addressEntity: widget.initialMapAddress!,
                  onAddressTapped: () {
                    _setMapPosition(widget.initialMapAddress!.getAsaLtLng);
                  },
                ),
          ],
        ),
      ),
    );
  }

  Set<Polygon> _buildStyledPolygons(BuildContext context) {
    final polygons = widget.polygons;
    if (polygons == null || polygons.isEmpty) return {};

    final primaryColor = Theme.of(context).colorScheme.primary;
    final strokeColor = primaryColor.withAlpha(220);
    final fillColor = primaryColor.withAlpha(30);

    return polygons.map((polygon) {
      return polygon.copyWith(fillColorParam: fillColor, strokeColorParam: strokeColor, strokeWidthParam: 2, geodesicParam: true);
    }).toSet();
  }

  Timer? _getLocationAddressDebounceTimer;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;

  void _setLocationMarkerIconsImage() async {
    userMarkerIcon = await BitmapDescriptor.asset(ImageConfiguration.empty, "assets/images/person_location.png");
    setState(() {});
  }

  void _getTappedLocationAddress(LatLng tappedPoint) {
    _getLocationAddressDebounceTimer?.cancel();
    _getLocationAddressDebounceTimer = null;
    _getLocationAddressDebounceTimer = Timer.periodic(const Duration(milliseconds: 850), (timer) {
      MapsMainCubit.of(context).getLocationAddress(GetMapLocationAddressParams(lat: tappedPoint.latitude, long: tappedPoint.longitude));
      _getLocationAddressDebounceTimer?.cancel();
      _getLocationAddressDebounceTimer = null;
    });
  }

  void _setCurrentMapLocation(LatLng latLng, {String? snippet, bool animateCamera = true}) {
    if (animateCamera) {
      _setMapPosition(latLng);
    }
    _mapMarkers.clear();
    _mapMarkers.add(
      Marker(
        markerId: MarkerId(_uuidObj.v4()),
        position: latLng,
        // infoWindow: InfoWindow(title: snippet, snippet: snippet),
      ),
    );
    setState(() {});
    // _getTappedLocationAddress(latLng);
  }

  void _setMapPosition(LatLng latLng) async {
    if (_isMapCreated == false) {
      return;
    }
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 14.0)));
  }

  void _onMapTapped(LatLng tappedPoint) {
    if (widget.onlyPreviewAddress) {
      return;
    }
    if (_shouldIgnoreTapOutsidePolygons(tappedPoint)) {
      AppToasts.hint(context, message: appLocalizer.pleaseSelectLocationInsideTheCity);
      return;
    }
    _mapMarkers.clear();
    _mapMarkers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: InfoWindow(title: appLocalizer.addressDetails),
      ),
    );
    setState(() {});
    _getTappedLocationAddress(tappedPoint);
  }

  bool _shouldIgnoreTapOutsidePolygons(LatLng tappedPoint) {
    final polygons = widget.polygons;
    if (polygons == null || polygons.isEmpty) {
      return false;
    }
    return !_isInsideAnyPolygon(tappedPoint, polygons);
  }

  bool _isInsideAnyPolygon(LatLng point, Set<Polygon> polygons) {
    for (final polygon in polygons) {
      if (_isPointInsidePolygon(point, polygon.points)) {
        return true;
      }
    }
    return false;
  }

  bool _isPointInsidePolygon(LatLng point, List<LatLng> polygonPoints) {
    if (polygonPoints.length < 3) return false;
    var isInside = false;
    for (var i = 0, j = polygonPoints.length - 1; i < polygonPoints.length; j = i++) {
      final xi = polygonPoints[i].longitude;
      final yi = polygonPoints[i].latitude;
      final xj = polygonPoints[j].longitude;
      final yj = polygonPoints[j].latitude;
      final intersects =
          ((yi > point.latitude) != (yj > point.latitude)) &&
          (point.longitude < (xj - xi) * (point.latitude - yi) / ((yj - yi) == 0 ? 1e-12 : (yj - yi)) + xi);
      if (intersects) isInside = !isInside;
    }
    return isInside;
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _isMapCreated = true;
    });
    // Log any style errors to the console for debugging.
    if (kDebugMode) {
      _mapController.getStyleError().then((String? error) {
        if (error != null) {
          debugPrint(error);
        }
      });
    }
    _setInitialMapAddress();
  }

  void _setInitialMapAddress() {
    final address = widget.initialMapAddress;

    // When polygons exist, the initial camera movement should prioritize them.
    _ignoreInitialMapAddressCamera = widget.polygons != null && widget.polygons!.isNotEmpty;

    if (address != null) {
      MapsMainCubit.of(context).setLocationAddressData(address);
    }
    if (widget.polygons != null && widget.polygons!.isNotEmpty) {
      _setMapPositionToFitPolygons();
    }
  }

  void _setMapPositionToFitPolygons() {
    if (!_isMapCreated || widget.polygons == null || widget.polygons!.isEmpty) return;
    double minLat = double.infinity, maxLat = double.negativeInfinity;
    double minLng = double.infinity, maxLng = double.negativeInfinity;
    for (final polygon in widget.polygons!) {
      for (final point in polygon.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLng) minLng = point.longitude;
        if (point.longitude > maxLng) maxLng = point.longitude;
      }
    }
    if (minLat.isFinite && maxLat.isFinite && minLng.isFinite && maxLng.isFinite) {
      final bounds = LatLngBounds(southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    _getLocationAddressDebounceTimer?.cancel();
    _getLocationAddressDebounceTimer = null;
    super.dispose();
  }
}
