part of 'main_categories_cubit.dart';

class MainCategoriesState extends Equatable {
  final Async<List<CategoryEntity>> getMainCategoriesState;

  final GetMainCategoriesParams params;
  final int currentPage;
  final int lastPage;

  const MainCategoriesState({required this.getMainCategoriesState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory MainCategoriesState.initial() {
    return const MainCategoriesState(getMainCategoriesState: Async.initial(), params: GetMainCategoriesParams.initial());
  }

  MainCategoriesState copyWith({
    Async<List<CategoryEntity>>? getMainCategoriesState,

    GetMainCategoriesParams? params,
    int? currentPage,
    int? lastPage,
  }) {
    return MainCategoriesState(
      getMainCategoriesState: getMainCategoriesState ?? this.getMainCategoriesState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getMainCategoriesState, params, currentPage, lastPage];
}
