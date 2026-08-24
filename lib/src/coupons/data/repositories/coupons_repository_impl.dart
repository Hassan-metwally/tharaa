import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/coupon_entity.dart';
import '../../domain/repositories/coupons_repository.dart';

import '../../domain/usecases/get_coupons_usecase.dart';

import '../datasources/coupons_datasource.dart';

import '../models/api_coupon_model.dart';

@Injectable(as: CouponsRepository)
class CouponsRepositoryImpl extends CouponsRepository {
  final CouponsDatasource _dataSource;

  CouponsRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<PaginatedData<CouponEntity>> getCoupons(GetCouponsParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getCoupons(params);

      return Right(result.map((data) => data.map));
    });
  }
}
