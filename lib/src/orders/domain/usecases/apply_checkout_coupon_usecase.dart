import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/checkout_preview_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class ApplyCheckoutCouponUsecase extends IUseCase<CheckoutPreviewEntity, ApplyCheckoutCouponParams> {
  final OrdersRepository _repository;

  ApplyCheckoutCouponUsecase(this._repository);

  @override
  Future<Either<Failure, CheckoutPreviewEntity>> call(ApplyCheckoutCouponParams params) {
    return _repository.applyCheckoutCoupon(params);
  }
}

class ApplyCheckoutCouponParams extends Equatable {
  final String deliveryMethod;
  final String couponCode;

  const ApplyCheckoutCouponParams({required this.deliveryMethod, required this.couponCode});

  Map<String, dynamic> get toMap => {
    'delivery_method': deliveryMethod,
    'coupon_code': couponCode.trim(),
  };

  @override
  List<Object?> get props => [deliveryMethod, couponCode];
}
