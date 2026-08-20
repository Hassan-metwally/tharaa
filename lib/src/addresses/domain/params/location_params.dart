import 'package:equatable/equatable.dart';

import '../../../google_maps/domain/entities/address_entity.dart';

class LocationParams extends Equatable {
  final String address;
  final double lat;
  final double long;

  const LocationParams({required this.address, required this.lat, required this.long});

  factory LocationParams.initial() => LocationParams(address: '', lat: 0.0, long: 0.0);

  LocationParams copyWith({String? address, double? lat, double? long}) {
    return LocationParams(address: address ?? this.address, lat: lat ?? this.lat, long: long ?? this.long);
  }

  factory LocationParams.fromEntity(MapAddressEntity entity) => LocationParams(address: entity.address, lat: entity.lat, long: entity.lng);

  Map<String, dynamic> toMap() {
    return {'address': address, 'lat': lat, 'long': long};
  }

  @override
  List<Object?> get props => [address, lat, long];
}
