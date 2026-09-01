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
    emit(state.copyWith(getMainCategoriesState: const Async.loading()));
    final result = await _getMainCategoriesUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(getMainCategoriesState: Async.failure(failure))),
      (data) => emit(state.copyWith(getMainCategoriesState: Async.success(data))),
    );
  }

  @override
  void emit(MainCategoriesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
