import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAddressEntity extends Equatable {
  final String? title;
  final String address;
  final double lat;
  final double lng;

  LatLng get coordinates => LatLng(lat, lng);

  const MapAddressEntity({required this.address, required this.lat, required this.lng, this.title});

  LatLng get getAsaLtLng => LatLng(lat, lng);

  String get getFormattedAddresss {
    if (title?.isNotEmpty == true) {
      return title ?? '';
    } else if (address.isNotEmpty) {
      return address;
    }
    return '$lat - $lng';
  }

  @override
  List<Object?> get props => [address, lat, lng, title];

  MapAddressEntity copyWith({String? title}) {
    return MapAddressEntity(title: title ?? this.title, address: address, lat: lat, lng: lng);
  }
}
