import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/address_entity.dart';
import '../entities/place_suggestion_entity.dart';
import '../use_cases/google_maps_api/get_location_address_use_case.dart';
import '../use_cases/location/update_user_location_use_case.dart';

abstract class MapsRepository {
  Future<Either<Failure, List<MapPlaceSuggestionsEntity>>> getSearchSuggestions(String text);
  Future<Either<Failure, MapAddressEntity>> getLocationAddress(GetMapLocationAddressParams params);
  Future<Either<Failure, MapAddressEntity>> getPlaceDetails(String placeID);
  DomainServiceType<void> updateUserLocation(UpdateUserAddressParams params);
}
