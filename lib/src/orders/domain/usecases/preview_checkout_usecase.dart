import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/checkout_preview_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class PreviewCheckoutUsecase extends IUseCase<CheckoutPreviewEntity, PreviewCheckoutParams> {
  final OrdersRepository _repository;

  PreviewCheckoutUsecase(this._repository);

  @override
  Future<Either<Failure, CheckoutPreviewEntity>> call(PreviewCheckoutParams params) {
    return _repository.previewCheckout(params);
  }
}

class PreviewCheckoutParams extends Equatable {
  final String deliveryMethod;
  final String? couponCode;

  const PreviewCheckoutParams({required this.deliveryMethod, this.couponCode});

  Map<String, dynamic> get toMap {
    final map = <String, dynamic>{'delivery_method': deliveryMethod};
    final code = couponCode?.trim();
    if (code != null && code.isNotEmpty) {
      map['coupon_code'] = code;
    }
    return map;
  }

  @override
  List<Object?> get props => [deliveryMethod, couponCode];
}
