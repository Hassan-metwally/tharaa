import '../../../../../../core/core.dart';

import '../../domain/usecases/get_products_usecase.dart';

import '../models/api_product_details_model.dart';

import '../models/api_product_model.dart';

abstract class ProductsDatasource {
  Future<ApiProductDetailsModel> showProductDetails(int id);

  Future<ApiPaginatedData<ApiProductModel>> getProducts(GetProductsParams params);
}

class ProductsDatasourceImpl extends ProductsDatasource {
  final DioHelper _dioHelper;

  ProductsDatasourceImpl(this._dioHelper);

  @override
  Future<ApiProductDetailsModel> showProductDetails(int id) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.addToApiUrlPath('/product/$id')");
      return ApiProductDetailsModel.fromJson(response['data']);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiPaginatedData<ApiProductModel>> getProducts(GetProductsParams params) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.addToApiUrlPath('/product')", queryParameters: params.toMap);
      final data = ApiPaginatedData<ApiProductModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiProductModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
