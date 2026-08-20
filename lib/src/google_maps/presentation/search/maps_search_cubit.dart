import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/place_suggestion_entity.dart';
import '../../domain/use_cases/google_maps_api/get_maps_place_details_use_case.dart';
import '../../domain/use_cases/google_maps_api/get_maps_search_suggestions_use_case.dart';

part "maps_search_state.dart";

class MapsSearchCubit extends Cubit<MapsSearchState> {
  MapsSearchCubit() : super(const MapsSearchState.initial()) {
    _initUseCases();
  }

  static MapsSearchCubit of(BuildContext context) => BlocProvider.of<MapsSearchCubit>(context);

  late final GetSearchSuggestionsUseCase _getSearchSuggestionsUseCase;
  late final GetMapsPlaceDetailsUseCase _getMapsPlaceDetailsUseCase;

  void _initUseCases() {
    _getSearchSuggestionsUseCase = injector();
    _getMapsPlaceDetailsUseCase = injector();
  }

  void getSearchSuggestions(String text) async {
    if (text.isEmpty) {
      emit(
        state.copyWith(
          suggestionState: const Async.initial(),
          currentFetchedTappedPlaceID: const Async.initial(),
          getPlaceLocationState: const Async.initial(),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        currentFetchedTappedPlaceID: const Async.initial(),
        suggestionState: const Async.loading(),
        getPlaceLocationState: const Async.initial(),
      ),
    );
    final result = await _getSearchSuggestionsUseCase(GetSearchSuggestionsParams(searchText: text));
    result.fold(
      (error) {
        emit(state.copyWith(suggestionState: Async.failure(error)));
      },
      (data) {
        emit(state.copyWith(suggestionState: Async.success(data)));
      },
    );
  }

  void getPlaceLocation(String placeID) async {
    emit(state.copyWith(getPlaceLocationState: const Async.loading(), currentFetchedTappedPlaceID: Async.success(placeID)));
    final result = await _getMapsPlaceDetailsUseCase(GetMapsPlaceDetailsParams(placeID: placeID));
    result.fold(
      (error) {
        emit(state.copyWith(getPlaceLocationState: Async.failure(error)));
      },
      (data) {
        emit(state.copyWith(getPlaceLocationState: Async.success(data)));
      },
    );
    emit(state.copyWith(currentFetchedTappedPlaceID: const Async.initial()));
  }

  @override
  void emit(MapsSearchState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
