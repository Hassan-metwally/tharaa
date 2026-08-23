import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUsecase _getProductsUsecase;
  ProductsCubit(this._getProductsUsecase) : super(ProductsState.initial());

  Future<void> getProducts() async {
    emit(state.copyWith(getProductsState: const Async.loading(), currentPage: 1));
    final result = await _getProductsUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getProductsState: Async.failure(failure))),
      (data) => emit(state.copyWith(getProductsState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  Future<void> getMoreProducts() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(getProductsState: Async.paginationLoading(state.getProductsState.data ?? []), currentPage: state.currentPage + 1));
    final result = await _getProductsUsecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getProductsState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getProductsState: Async.success([...state.getProductsState.data ?? [], ...data.items]))),
    );
  }

  void updateParams(GetProductsParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetProductsParams.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    getProducts();
  }

  @override
  void emit(ProductsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
