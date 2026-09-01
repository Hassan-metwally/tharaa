part of 'main_categories_cubit.dart';

class MainCategoriesState extends Equatable {
  final Async<List<CategoryEntity>> getMainCategoriesState;

  const MainCategoriesState({required this.getMainCategoriesState});

  factory MainCategoriesState.initial() {
    return const MainCategoriesState(getMainCategoriesState: Async.initial());
  }

  MainCategoriesState copyWith({Async<List<CategoryEntity>>? getMainCategoriesState}) {
    return MainCategoriesState(getMainCategoriesState: getMainCategoriesState ?? this.getMainCategoriesState);
  }

  @override
  List<Object> get props => [getMainCategoriesState];
}
