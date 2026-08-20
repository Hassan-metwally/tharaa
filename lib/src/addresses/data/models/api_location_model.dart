import '../../../common/data/models/api_city_model.dart';
import '../../domain/entities/location_entity.dart';

class ApiLocationModel {
  final int? id;
  final String? building;
  final String? district;
  final String? lat;
  final String? lng;
  final String? address;
  final ApiCityModel? city;

  ApiLocationModel({
    required this.id,
    required this.building,
    required this.district,
    required this.lat,
    required this.lng,
    required this.address,
    this.city,
  });

  factory ApiLocationModel.fromJson(Map<String, dynamic> json) => ApiLocationModel(
    id: json["id"],
    building: json["building"],
    district: json["district"],
    lat: json["lat"]?.toString(),
    lng: json["lng"]?.toString(),
    address: json["address"],
    city: json["city"] == null ? null : ApiCityModel.fromJson(json["city"]),
  );
}

extension ApiLocationModelExt on ApiLocationModel {
  LocationEntity get map => LocationEntity(
    id: id ?? 0,
    building: building ?? '',
    district: district ?? '',
    lat: double.tryParse(lat ?? '') ?? 0,
    lng: double.tryParse(lng ?? '') ?? 0,
    address: address ?? '',
    city: city?.map,
  );
}
