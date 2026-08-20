part of 'ratings_cubit.dart';

class RatingsState extends Equatable {
  final Async<List<RateEntity>> getRatingState;

  final GetRatingsParams params;
  final int currentPage;
  final int lastPage;

  const RatingsState({required this.getRatingState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory RatingsState.initial() {
    return const RatingsState(getRatingState: Async.initial(), params: GetRatingsParams.initial());
  }

  RatingsState copyWith({Async<List<RateEntity>>? getRatingState, GetRatingsParams? params, int? currentPage, int? lastPage}) {
    return RatingsState(
      getRatingState: getRatingState ?? this.getRatingState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getRatingState, params, currentPage, lastPage];
}
