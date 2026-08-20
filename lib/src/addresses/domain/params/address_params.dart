import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../entities/location_entity.dart';

class AddressParams extends Equatable {
  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController building;
  final TextEditingController district;
  final double lat;
  final double lng;
  final String address;

  const AddressParams({
    this.id,
    required this.formKey,
    required this.building,
    required this.district,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory AddressParams.initial() => AddressParams(
    formKey: GlobalKey<FormState>(),
    building: TextEditingController(),
    district: TextEditingController(),
    lat: 0.0,
    lng: 0.0,
    address: '',
  );

  AddressParams copyWith({
    int? id,
    GlobalKey<FormState>? formKey,
    TextEditingController? building,
    TextEditingController? district,
    double? lat,
    double? lng,
    String? address,
  }) {
    return AddressParams(
      id: id ?? this.id,
      formKey: formKey ?? this.formKey,
      building: building ?? this.building,
      district: district ?? this.district,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
    );
  }

  factory AddressParams.fromEntity(LocationEntity entity) => AddressParams(
    id: entity.id,
    formKey: GlobalKey<FormState>(),
    building: TextEditingController(text: entity.building),
    district: TextEditingController(text: entity.district),
    lat: entity.lat,
    lng: entity.lng,
    address: entity.address,
  );

  Map<String, dynamic> toMap() {
    return {
      'building': building.text,
      'district': district.text,
      'lat': lat,
      'lng': lng,
      'address': address,
      if (id != null) '_method': 'PUT',
    };
  }

  @override
  List<Object?> get props => [building, lat, lng, address, district, id];
}
