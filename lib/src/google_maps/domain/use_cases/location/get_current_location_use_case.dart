import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../../entities/address_entity.dart';
import '../enable_gps_and_handle_premistion.dart';
import '../google_maps_api/get_location_address_use_case.dart';
import 'update_user_location_use_case.dart';

@LazySingleton()
class GetCurrentLocationUseCase {
  final Location _locationObj = Location.instance;
  final EnableGpsAndHandlePermissionUseCase _enableGpsAndHandlePermissionUseCase;
  final GetMapLocationAddressUseCase _parseLatLngUseCase;
  final UpdateUserLocationUseCase _updateLocationUseCase;

  GetCurrentLocationUseCase(this._enableGpsAndHandlePermissionUseCase, this._parseLatLngUseCase, this._updateLocationUseCase);

  Future<MapAddressEntity?> call() async {
    try {
      MapAddressEntity? address;

      /// First Check if location premession if ok and GPS is enabled
      ///
      final bool isGPSEnabled = await _enableGpsAndHandlePermissionUseCase();
      if (!isGPSEnabled) {
        return address;
      }

      /// Get the current location

      final locationResult = await _locationObj.getLocation();

      final double? latitude = locationResult.latitude;
      final double? longitude = locationResult.longitude;
      if (latitude == null || longitude == null) {
        return address;
      }

      /// After get LatLng decode it to get address
      final geocodeResult = await _parseLatLngUseCase(GetMapLocationAddressParams(lat: latitude, long: longitude));
      geocodeResult.fold(
        (l) {
          return null;
        },
        (right) {
          address = right;
        },
      );
      if (address != null) {
        final updateLocationResult = await _updateLocationUseCase(UpdateUserAddressParams.fromEntity(address!));
        updateLocationResult.fold(
          (_) {
            return null;
          },
          (r) {
            return address;
          },
        );
      }
      return address;
    } catch (e) {
      log("GetCurrentLocationUseCase Failed", error: e, name: "Get CurrentUser Location");
      return null;
    }
  }
}
