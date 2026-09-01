part of 'sub_categories_cubit.dart';

class SubCategoriesState extends Equatable {
  final Async<List<CategoryEntity>> getSubCategoriesState;

  final GetSubCategoriesParams params;

  const SubCategoriesState({required this.getSubCategoriesState, required this.params});

  factory SubCategoriesState.initial() {
    return const SubCategoriesState(getSubCategoriesState: Async.initial(), params: GetSubCategoriesParams.initial(categoryId: 0));
  }

  SubCategoriesState copyWith({
    Async<List<CategoryEntity>>? getSubCategoriesState,
    GetSubCategoriesParams? params,
  }) {
    return SubCategoriesState(
      getSubCategoriesState: getSubCategoriesState ?? this.getSubCategoriesState,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [getSubCategoriesState, params];
}
