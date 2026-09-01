import '../../domain/entities/location_entity.dart';

class ApiLocationModel {
  final int? id;
  final String? title;
  final String? description;
  final String? lat;
  final String? lng;
  final String? address;
  final bool isDefault;

  ApiLocationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.address,
    this.isDefault = false,
  });

  factory ApiLocationModel.fromJson(Map<String, dynamic> json) => ApiLocationModel(
    id: json["id"],
    title: (json['name'] ?? json['title'])?.toString(),
    description: (json['details'] ?? json['description'])?.toString(),
    lat: json["lat"]?.toString(),
    lng: json["lng"]?.toString(),
    address: json["address"]?.toString(),
    isDefault: json["is_default"] == true || json["isDefault"] == true,
  );
}

extension ApiLocationModelExt on ApiLocationModel {
  LocationEntity get map => LocationEntity(
    id: id ?? 0,
    title: title ?? '',
    description: description ?? '',
    lat: double.tryParse(lat ?? '') ?? 0,
    lng: double.tryParse(lng ?? '') ?? 0,
    address: address ?? '',
    isDefault: isDefault,
  );
}
