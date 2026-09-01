import '../../../../../../core/core.dart';

import '../entities/category_entity.dart';

import '../usecases/get_sub_categories_usecase.dart';

abstract class CategoriesRepository {
  DomainServiceType<List<CategoryEntity>> getMainCategories(NoParams params);

  DomainServiceType<PaginatedData<CategoryEntity>> getSubCategories(GetSubCategoriesParams params);
}
