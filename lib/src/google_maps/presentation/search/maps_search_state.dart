part of "maps_search_cubit.dart";

class MapsSearchState extends Equatable {
  final Async<List<MapPlaceSuggestionsEntity>> suggestionState;
  final Async<MapAddressEntity> getPlaceLocationState;
  final Async<String> currentFetchedTappedPlaceID;

  const MapsSearchState({required this.suggestionState, required this.getPlaceLocationState, required this.currentFetchedTappedPlaceID});

  const MapsSearchState.initial()
    : this(
        currentFetchedTappedPlaceID: const Async.initial(),
        suggestionState: const Async.initial(),
        getPlaceLocationState: const Async.initial(),
      );

  MapsSearchState copyWith({
    Async<List<MapPlaceSuggestionsEntity>>? suggestionState,
    Async<MapAddressEntity>? getPlaceLocationState,
    Async<String>? currentFetchedTappedPlaceID,
  }) {
    return MapsSearchState(
      suggestionState: suggestionState ?? this.suggestionState,
      getPlaceLocationState: getPlaceLocationState ?? this.getPlaceLocationState,
      currentFetchedTappedPlaceID: currentFetchedTappedPlaceID ?? this.currentFetchedTappedPlaceID,
    );
  }

  @override
  List<Object?> get props => [suggestionState, getPlaceLocationState, currentFetchedTappedPlaceID];
}
