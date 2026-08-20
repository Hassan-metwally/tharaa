import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/rate_entity.dart';
import '../../domain/usecases/get_ratings_usecase.dart';

part 'ratings_state.dart';

@injectable
class RatingsCubit extends Cubit<RatingsState> {
  final GetRatingsUsecase _getRatingUsecase;
  RatingsCubit(this._getRatingUsecase) : super(RatingsState.initial());

  Future<void> getRating() async {
    emit(state.copyWith(getRatingState: const Async.loading(), currentPage: 1));
    final result = await _getRatingUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getRatingState: Async.failure(failure))),
      (data) => emit(state.copyWith(getRatingState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  Future<void> getMoreRating() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(getRatingState: Async.paginationLoading(state.getRatingState.data ?? []), currentPage: state.currentPage + 1));
    final result = await _getRatingUsecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getRatingState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getRatingState: Async.success([...state.getRatingState.data ?? [], ...data.items]))),
    );
  }

  void updateParams(GetRatingsParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetRatingsParams.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    getRating();
  }

  @override
  void emit(RatingsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
