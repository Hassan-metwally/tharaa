import 'api_address_model.dart';

class ApiAddressFromLatLonResponse {
  final List<ApiMapPlaceDetailsModel>? responseDetails;
  final ApiMapPlaceDetailsModel? placeDetails;
  final String? status;
  final String? errorMessage;

  ApiAddressFromLatLonResponse({this.responseDetails, this.placeDetails, this.status, this.errorMessage});

  factory ApiAddressFromLatLonResponse.fromJson(Map<String, dynamic> json) {
    return ApiAddressFromLatLonResponse(
      responseDetails: List<ApiMapPlaceDetailsModel>.from(json["results"].map((x) => ApiMapPlaceDetailsModel.fromJson(x))),
      placeDetails: json["results"]?[0] == null ? null : ApiMapPlaceDetailsModel.fromJson(json["results"][0]),
      status: json["status"],
      errorMessage: json["error_message"],
    );
  }
}
