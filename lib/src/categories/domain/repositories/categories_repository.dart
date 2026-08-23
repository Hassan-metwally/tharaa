import '../../../../../../core/core.dart';

import '../entities/category_entity.dart';

import '../usecases/get_main_categories_usecase.dart';
import '../usecases/get_sub_categories_usecase.dart';

abstract class CategoriesRepository {
  DomainServiceType<PaginatedData<CategoryEntity>> getMainCategories(GetMainCategoriesParams params);

  DomainServiceType<PaginatedData<CategoryEntity>> getSubCategories(GetSubCategoriesParams params);
}
