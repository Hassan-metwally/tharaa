import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/usecases/get_coupons_usecase.dart';

import '../models/api_coupon_model.dart';

abstract class CouponsDatasource {
  Future<ApiPaginatedData<ApiCouponModel>> getCoupons(GetCouponsParams params);
}

@Injectable(as: CouponsDatasource)
class CouponsDatasourceImpl extends CouponsDatasource {
  final DioHelper _dioHelper;

  CouponsDatasourceImpl(this._dioHelper);

  @override
  Future<ApiPaginatedData<ApiCouponModel>> getCoupons(GetCouponsParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('coupons'));
      final List<dynamic> rawList = response['data'] as List<dynamic>? ?? const [];
      final items = rawList.map((e) => ApiCouponModel.fromJson(e as Map<String, dynamic>)).toList();

      return ApiPaginatedData(
        items: items,
        pageInfo: PageInfo(
          currentPage: 1,
          lastPage: 1,
          totalPages: 1,
          countPerPage: items.length,
          totalItemsCount: items.length,
        ),
      );
    } catch (_) {
      rethrow;
    }
  }
}
