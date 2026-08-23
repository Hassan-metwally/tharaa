part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final Async<List<ProductEntity>> getProductsState;

  final GetProductsParams params;
  final int currentPage;
  final int lastPage;

  const ProductsState({required this.getProductsState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory ProductsState.initial() {
    return const ProductsState(getProductsState: Async.initial(), params: GetProductsParams.initial());
  }

  ProductsState copyWith({Async<List<ProductEntity>>? getProductsState, GetProductsParams? params, int? currentPage, int? lastPage}) {
    return ProductsState(
      getProductsState: getProductsState ?? this.getProductsState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getProductsState, params, currentPage, lastPage];
}
