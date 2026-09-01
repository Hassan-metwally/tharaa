import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_sub_categories_usecase.dart';

part 'sub_categories_state.dart';

@injectable
class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final GetSubCategoriesUsecase _getSubCategoriesUsecase;
  SubCategoriesCubit(this._getSubCategoriesUsecase) : super(SubCategoriesState.initial());

  Future<void> getSubCategories() async {
    emit(state.copyWith(getSubCategoriesState: const Async.loading()));
    final result = await _getSubCategoriesUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getSubCategoriesState: Async.failure(failure))),
      (data) => emit(state.copyWith(getSubCategoriesState: Async.success(data))),
    );
  }

  void updateParams(GetSubCategoriesParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetSubCategoriesParams.initial(categoryId: state.params.categoryId)));

  void search() {
    emit(state.copyWith(params: state.params));
    getSubCategories();
  }

  @override
  void emit(SubCategoriesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
