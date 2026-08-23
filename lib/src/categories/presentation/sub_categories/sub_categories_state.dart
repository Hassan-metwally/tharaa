part of 'sub_categories_cubit.dart';

class SubCategoriesState extends Equatable {
  final Async<List<CategoryEntity>> getSubCategoriesState;

  final GetSubCategoriesParams params;
  final int currentPage;
  final int lastPage;

  const SubCategoriesState({required this.getSubCategoriesState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory SubCategoriesState.initial() {
    return const SubCategoriesState(getSubCategoriesState: Async.initial(), params: GetSubCategoriesParams.initial(categoryId: 0));
  }

  SubCategoriesState copyWith({
    Async<List<CategoryEntity>>? getSubCategoriesState,

    GetSubCategoriesParams? params,
    int? currentPage,
    int? lastPage,
  }) {
    return SubCategoriesState(
      getSubCategoriesState: getSubCategoriesState ?? this.getSubCategoriesState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getSubCategoriesState, params, currentPage, lastPage];
}
