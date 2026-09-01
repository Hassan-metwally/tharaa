import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/usecases/get_sub_categories_usecase.dart';

import '../models/api_category_model.dart';

abstract class CategoriesDatasource {
  Future<List<ApiCategoryModel>> getMainCategories(NoParams params);

  Future<ApiPaginatedData<ApiCategoryModel>> getSubCategories(GetSubCategoriesParams params);
}

@Injectable(as: CategoriesDatasource)
class CategoriesDatasourceImpl extends CategoriesDatasource {
  final DioHelper _dioHelper;

  CategoriesDatasourceImpl(this._dioHelper);

  @override
  Future<List<ApiCategoryModel>> getMainCategories(NoParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('categories'));
      final rawList = (response['data'] as List<dynamic>? ?? const <dynamic>[]);
      return rawList.map((e) => ApiCategoryModel.fromJson(e as Map<String, dynamic>)).toList();
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
