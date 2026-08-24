import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/coupon_entity.dart';
import '../repositories/coupons_repository.dart';

@injectable
class GetCouponsUsecase extends IUseCase<PaginatedData<CouponEntity>, GetCouponsParams> {
  final CouponsRepository _repository;

  GetCouponsUsecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<CouponEntity>>> call(GetCouponsParams params) {
    return _repository.getCoupons(params);
  }
}

class GetCouponsParams extends Equatable {
  final int page;

  const GetCouponsParams({required this.page});

  const GetCouponsParams.initial() : this(page: 1);

  GetCouponsParams copyWith({int? page}) {
    return GetCouponsParams(page: page ?? this.page);
  }

  Map<String, dynamic> get toMap => {'page': page};
  @override
  List<Object?> get props => [page];
}
