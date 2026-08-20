import 'package:equatable/equatable.dart';

class MapPlaceSuggestionsEntity extends Equatable {
  final String description;
  final List<PlaceMatchedSubstringEntity> matchedSubstrings;
  final String placeId;

  const MapPlaceSuggestionsEntity({required this.description, required this.matchedSubstrings, required this.placeId});

  @override
  List<Object?> get props => [description, matchedSubstrings, placeId];
}

class PlaceMatchedSubstringEntity extends Equatable {
  final int length;
  final int offset;

  const PlaceMatchedSubstringEntity({required this.length, required this.offset});

  @override
  List<Object?> get props => [length, offset];
}
