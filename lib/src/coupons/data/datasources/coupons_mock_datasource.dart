import '../../../../core/core.dart';
import '../../domain/usecases/get_coupons_usecase.dart';
import '../models/api_coupon_model.dart';
import 'coupons_datasource.dart';

// @Injectable(as: CouponsDatasource)
class CouponsMockDatasource extends CouponsDatasource {
  static const _delay = Duration(milliseconds: 400);
  static final DateTime _validFrom = DateTime(2025, 8);
  static final DateTime _validTo = DateTime(2025, 8, 30);

  static final List<ApiCouponModel> _coupons = [
    ApiCouponModel(
      id: 1,
      name: 'SAVE10',
      code: 'ST-V2586',
      discountLabel: '10% OFF',
      status: 'unused',
      validFrom: _validFrom,
      validTo: _validTo,
      minOrderAmount: 106,
      image: const AttachmentEntity.empty(),
    ),
    ApiCouponModel(
      id: 2,
      name: 'SAVE10',
      code: 'ST-V2586',
      discountLabel: '10% OFF',
      status: 'used',
      validFrom: _validFrom,
      validTo: _validTo,
      minOrderAmount: 106,
      image: const AttachmentEntity.empty(),
    ),
    ApiCouponModel(
      id: 3,
      name: 'SAVE10',
      code: 'ST-V2586',
      discountLabel: '10% OFF',
      status: 'expired',
      validFrom: _validFrom,
      validTo: _validTo,
      minOrderAmount: 106,
      image: const AttachmentEntity.empty(),
    ),
    ApiCouponModel(
      id: 4,
      name: 'SAVE10',
      code: 'ST-V2586',
      discountLabel: '10% OFF',
      status: 'unused',
      validFrom: _validFrom,
      validTo: _validTo,
      minOrderAmount: 106,
      image: const AttachmentEntity.empty(),
    ),
  ];

  @override
  Future<ApiPaginatedData<ApiCouponModel>> getCoupons(GetCouponsParams params) async {
    await Future<void>.delayed(_delay);
    return _paginate(_coupons, params.page);
  }

  ApiPaginatedData<ApiCouponModel> _paginate(List<ApiCouponModel> items, int page) {
    const perPage = 10;
    final lastPage = items.isEmpty ? 1 : (items.length / perPage).ceil();
    final start = (page - 1) * perPage;
    final pagedItems = start >= items.length ? const <ApiCouponModel>[] : items.skip(start).take(perPage).toList();

    return ApiPaginatedData(
      items: pagedItems,
      pageInfo: PageInfo(currentPage: page, lastPage: lastPage, totalPages: lastPage, countPerPage: perPage, totalItemsCount: items.length),
    );
  }
}
