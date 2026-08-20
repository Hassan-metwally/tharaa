import '../../domain/entities/place_suggestion_entity.dart';
import '../models/api_place_suggessions_model.dart';

extension PlaceSuggestionsMapper on ApiMapPlaceSuggestionModel {
  MapPlaceSuggestionsEntity get map {
    return MapPlaceSuggestionsEntity(
      description: description ?? '',
      matchedSubstrings: matchedSubstrings.map((e) => e.map).toList(),
      placeId: placeId ?? '',
    );
  }
}

extension PlaceMatchedSubstringsMapper on ApiPlaceMatchedSubstring {
  PlaceMatchedSubstringEntity get map {
    return PlaceMatchedSubstringEntity(length: length ?? 0, offset: offset ?? 0);
  }
}
