import '../../domain/entities/address_entity.dart';
import '../models/api_address_model.dart';

extension PlaceDetailsMapper on ApiMapPlaceDetailsModel {
  MapAddressEntity get map {
    return MapAddressEntity(address: formattedAddress ?? '', lat: geometry?.location?.lat ?? 0, lng: geometry?.location?.lng ?? 0);
  }
}
