import 'package:equatable/equatable.dart';

import '../enums/payment_methods_enum.dart';

class PaymentEntity extends Equatable {
  final String subTotal;
  final String tax;
  final String deliveryFee;
  final String total;
  final String adminCommission;
  final String repCommission;
  final String cancellationFee;
  final PaymentMethodsEnum paymentMethod;
  const PaymentEntity({
    required this.subTotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.adminCommission,
    required this.repCommission,
    required this.cancellationFee,
    required this.paymentMethod,
  });

  factory PaymentEntity.initial() => PaymentEntity(
    subTotal: '',
    tax: '',
    deliveryFee: '',
    total: '',
    adminCommission: '',
    repCommission: '',
    cancellationFee: '',
    paymentMethod: PaymentMethodsEnum.electronicPay,
  );

  PaymentEntity copyWith({
    String? subTotal,
    String? tax,
    String? deliveryFee,
    String? total,
    String? adminCommission,
    String? repCommission,
    String? cancellationFee,
    PaymentMethodsEnum? paymentMethod,
  }) => PaymentEntity(
    subTotal: subTotal ?? this.subTotal,
    tax: tax ?? this.tax,
    deliveryFee: deliveryFee ?? this.deliveryFee,
    total: total ?? this.total,
    adminCommission: adminCommission ?? this.adminCommission,
    repCommission: repCommission ?? this.repCommission,
    cancellationFee: cancellationFee ?? this.cancellationFee,
    paymentMethod: paymentMethod ?? this.paymentMethod,
  );

  @override
  List<Object?> get props => [subTotal, tax, deliveryFee, total, adminCommission, repCommission, cancellationFee, paymentMethod];
}
