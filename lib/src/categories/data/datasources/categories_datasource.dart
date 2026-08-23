import '../../../../../../core/core.dart';

import '../../domain/usecases/get_main_categories_usecase.dart';
import '../../domain/usecases/get_sub_categories_usecase.dart';

import '../models/api_category_model.dart';

abstract class CategoriesDatasource {
  Future<ApiPaginatedData<ApiCategoryModel>> getMainCategories(GetMainCategoriesParams params);

  Future<ApiPaginatedData<ApiCategoryModel>> getSubCategories(GetSubCategoriesParams params);
}

class CategoriesDatasourceImpl extends CategoriesDatasource {
  final DioHelper _dioHelper;

  CategoriesDatasourceImpl(this._dioHelper);

  @override
  Future<ApiPaginatedData<ApiCategoryModel>> getMainCategories(GetMainCategoriesParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('category'), queryParameters: params.toMap);
      final data = ApiPaginatedData<ApiCategoryModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiCategoryModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiPaginatedData<ApiCategoryModel>> getSubCategories(GetSubCategoriesParams params) async {
    try {
      final response = await _dioHelper.get(
        url: ApiConstants.addToApiUrlPath('category/${params.categoryId}/sub-categories'),
        queryParameters: params.toMap,
      );
      final data = ApiPaginatedData<ApiCategoryModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiCategoryModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
