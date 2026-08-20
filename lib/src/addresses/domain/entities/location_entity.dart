import 'package:equatable/equatable.dart';

import '../../../common/domain/entity/city_entity.dart';

class LocationEntity extends Equatable {
  final int id;
  final String district;
  final String building;
  final double lat;
  final double lng;
  final String address;
  final CityEntity? city;

  const LocationEntity({
    required this.id,
    required this.district,
    required this.building,
    required this.lat,
    required this.lng,
    required this.address,
    this.city,
  });

  factory LocationEntity.initial() => const LocationEntity(id: 0, district: '', building: '', lat: 0, lng: 0, address: '');

  @override
  List<Object?> get props => [id, building, district, lat, lng, address, city];
}
