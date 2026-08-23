import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_main_categories_usecase.dart';

part 'main_categories_state.dart';

@injectable
class MainCategoriesCubit extends Cubit<MainCategoriesState> {
  final GetMainCategoriesUsecase _getMainCategoriesUsecase;
  MainCategoriesCubit(this._getMainCategoriesUsecase) : super(MainCategoriesState.initial());

  Future<void> getMainCategories() async {
    emit(state.copyWith(getMainCategoriesState: const Async.loading(), currentPage: 1));
    final result = await _getMainCategoriesUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getMainCategoriesState: Async.failure(failure))),
      (data) => emit(state.copyWith(getMainCategoriesState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  Future<void> getMoreMainCategories() async {
    if (state.currentPage == state.lastPage) return;
    emit(
      state.copyWith(
        getMainCategoriesState: Async.paginationLoading(state.getMainCategoriesState.data ?? []),
        currentPage: state.currentPage + 1,
      ),
    );
    final result = await _getMainCategoriesUsecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getMainCategoriesState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getMainCategoriesState: Async.success([...state.getMainCategoriesState.data ?? [], ...data.items]))),
    );
  }

  void updateParams(GetMainCategoriesParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetMainCategoriesParams.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    getMainCategories();
  }

  @override
  void emit(MainCategoriesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
