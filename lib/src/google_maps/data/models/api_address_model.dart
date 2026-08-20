class ApiPlaceDetailsResponse {
  final ApiMapPlaceDetailsModel? placeDetails;
  final String? status;
  final bool isSuccess;

  ApiPlaceDetailsResponse({required this.placeDetails, required this.status, required this.isSuccess});

  factory ApiPlaceDetailsResponse.fromJson(Map<String, dynamic> json) => ApiPlaceDetailsResponse(
    placeDetails: json["result"] == null ? null : ApiMapPlaceDetailsModel.fromJson(json["result"]),
    status: json["status"],
    isSuccess: (json["status"]).toString().toUpperCase() == ("OK").toLowerCase(),
  );
}

class ApiMapPlaceDetailsModel {
  final List<ApiGoogleMapsAddressComponent>? addressComponents;
  String? formattedAddress;
  ApiPlaceGeometryModel? geometry;
  String? placeId;

  ApiMapPlaceDetailsModel({this.formattedAddress, this.addressComponents, this.geometry, this.placeId});

  factory ApiMapPlaceDetailsModel.fromJson(Map<String, dynamic> json) => ApiMapPlaceDetailsModel(
    addressComponents: json["address_components"] == null
        ? []
        : List<ApiGoogleMapsAddressComponent>.from(json["address_components"]!.map((x) => ApiGoogleMapsAddressComponent.fromJson(x))),
    formattedAddress: json["formatted_address"],
    geometry: json["geometry"] == null ? null : ApiPlaceGeometryModel.fromJson(json["geometry"]),
    placeId: json["place_id"],
  );
}

class ApiPlaceGeometryModel {
  ApiPlaceLocationModel? location;

  ApiPlaceGeometryModel({this.location});

  factory ApiPlaceGeometryModel.fromJson(Map<String, dynamic> json) =>
      ApiPlaceGeometryModel(location: json["location"] == null ? null : ApiPlaceLocationModel.fromJson(json["location"]));
}

class ApiPlaceLocationModel {
  double? lat;
  double? lng;

  ApiPlaceLocationModel({this.lat, this.lng});

  factory ApiPlaceLocationModel.fromJson(Map<String, dynamic> json) =>
      ApiPlaceLocationModel(lat: json["lat"]?.toDouble(), lng: json["lng"]?.toDouble());
}

class ApiGoogleMapsAddressComponent {
  final String? longName;
  final String? shortName;
  final List<String>? types;

  ApiGoogleMapsAddressComponent({this.longName, this.shortName, this.types});

  factory ApiGoogleMapsAddressComponent.fromJson(Map<String, dynamic> json) => ApiGoogleMapsAddressComponent(
    longName: json["long_name"],
    shortName: json["short_name"],
    types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
  };
}
