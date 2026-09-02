import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

@injectable
class AddOrderUsecase extends IUseCase<OrderEntity, UpsertOrderParams> {
  final OrdersRepository _repository;

  AddOrderUsecase(this._repository);

  @override
  Future<Either<Failure, OrderEntity>> call(UpsertOrderParams params) {
    return _repository.addOrder(params);
  }
}

class UpsertOrderParams extends Equatable {
  final String deliveryMethod;
  final String paymentMethod;
  final int? addressId;
  final TextEditingController couponCode;

  const UpsertOrderParams({
    required this.deliveryMethod,
    required this.paymentMethod,
    this.addressId,
    required this.couponCode,
  });

  UpsertOrderParams.initial()
    : deliveryMethod = 'home_delivery',
      paymentMethod = 'electronic',
      addressId = null,
      couponCode = TextEditingController();

  UpsertOrderParams copyWith({
    String? deliveryMethod,
    String? paymentMethod,
    int? addressId,
    bool clearAddressId = false,
  }) {
    return UpsertOrderParams(
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      addressId: clearAddressId ? null : (addressId ?? this.addressId),
      couponCode: couponCode,
    );
  }

  Map<String, dynamic> get toMap {
    final map = <String, dynamic>{
      'delivery_method': deliveryMethod,
      'payment_method': paymentMethod,
    };
    if (deliveryMethod == 'home_delivery' && addressId != null) {
      map['address_id'] = addressId;
    }
    final code = couponCode.text.trim();
    if (code.isNotEmpty) {
      map['coupon_code'] = code;
    }
    return map;
  }

  @override
  List<Object?> get props => [deliveryMethod, paymentMethod, addressId, couponCode];
}
