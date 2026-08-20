class ApiMapPlaceSuggestionsResponse {
  List<ApiMapPlaceSuggestionModel> predictions;
  String? status;
  String? errorMessage;

  ApiMapPlaceSuggestionsResponse({required this.predictions, required this.status, required this.errorMessage});

  factory ApiMapPlaceSuggestionsResponse.fromJson(Map<String, dynamic> json) => ApiMapPlaceSuggestionsResponse(
    predictions: json["predictions"] == null
        ? []
        : List<ApiMapPlaceSuggestionModel>.from(json["predictions"].map((x) => ApiMapPlaceSuggestionModel.fromJson(x))),
    status: json["status"],
    errorMessage: json["error_message"],
  );
}

class ApiMapPlaceSuggestionModel {
  String? description;
  List<ApiPlaceMatchedSubstring> matchedSubstrings;
  String? placeId;

  ApiMapPlaceSuggestionModel({required this.description, required this.matchedSubstrings, required this.placeId});

  factory ApiMapPlaceSuggestionModel.fromJson(Map<String, dynamic> json) => ApiMapPlaceSuggestionModel(
    description: json["description"],
    matchedSubstrings: List<ApiPlaceMatchedSubstring>.from(json["matched_substrings"].map((x) => ApiPlaceMatchedSubstring.fromJson(x))),
    placeId: json["place_id"],
  );
}

class ApiPlaceMatchedSubstring {
  int? length;
  int? offset;

  ApiPlaceMatchedSubstring({required this.length, required this.offset});

  factory ApiPlaceMatchedSubstring.fromJson(Map<String, dynamic> json) =>
      ApiPlaceMatchedSubstring(length: json["length"], offset: json["offset"]);
}
