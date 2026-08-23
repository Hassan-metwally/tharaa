import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';

import '../../domain/usecases/get_main_categories_usecase.dart';
import '../../domain/usecases/get_sub_categories_usecase.dart';

import '../datasources/categories_datasource.dart';

import '../models/api_category_model.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoriesDatasource _dataSource;

  CategoriesRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<PaginatedData<CategoryEntity>> getMainCategories(GetMainCategoriesParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getMainCategories(params);

      return Right(result.map((data) => data.map));
    });
  }

  @override
  DomainServiceType<PaginatedData<CategoryEntity>> getSubCategories(GetSubCategoriesParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getSubCategories(params);

      return Right(result.map((data) => data.map));
    });
  }
}
