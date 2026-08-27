import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double lat;
  final double lng;
  final String address;
  final bool isDefault;

  const LocationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.address,
    this.isDefault = false,
  });

  factory LocationEntity.initial() => const LocationEntity(
    id: 0,
    title: '',
    description: '',
    lat: 0,
    lng: 0,
    address: '',
  );

  @override
  List<Object?> get props => [id, title, description, lat, lng, address, isDefault];
}
