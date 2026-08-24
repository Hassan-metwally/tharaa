import '../../../../../../core/core.dart';

import '../../domain/usecases/get_coupons_usecase.dart';

import '../models/api_coupon_model.dart';

abstract class CouponsDatasource {
  Future<ApiPaginatedData<ApiCouponModel>> getCoupons(GetCouponsParams params);
}

class CouponsDatasourceImpl extends CouponsDatasource {
  final DioHelper _dioHelper;

  CouponsDatasourceImpl(this._dioHelper);

  @override
  Future<ApiPaginatedData<ApiCouponModel>> getCoupons(GetCouponsParams params) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.addToApiUrlPath('/coupon')", queryParameters: params.toMap);
      final data = ApiPaginatedData<ApiCouponModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiCouponModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
