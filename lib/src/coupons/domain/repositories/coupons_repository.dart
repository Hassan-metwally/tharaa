import '../../../../../../core/core.dart';

import '../entities/coupon_entity.dart';

import '../usecases/get_coupons_usecase.dart';

abstract class CouponsRepository {
  DomainServiceType<PaginatedData<CouponEntity>> getCoupons(GetCouponsParams params);
}
