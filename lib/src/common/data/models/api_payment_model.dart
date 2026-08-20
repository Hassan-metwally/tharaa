import '../../domain/entity/payment_entity.dart';
import '../../domain/enums/payment_methods_enum.dart';

class ApiPaymentModel {
  final String? subTotal;
  final String? tax;
  final String? deliveryFee;
  final String? total;
  final String? adminCommission;
  final String? repCommission;
  final String? cancellationFee;
  final PaymentMethodsEnum? paymentMethod;

  ApiPaymentModel({
    this.subTotal,
    this.tax,
    this.deliveryFee,
    this.total,
    this.adminCommission,
    this.repCommission,
    this.cancellationFee,
    this.paymentMethod,
  });
  factory ApiPaymentModel.initial() =>
      ApiPaymentModel(subTotal: '', tax: '', deliveryFee: '', total: '', adminCommission: '', repCommission: '', cancellationFee: '');

  factory ApiPaymentModel.fromJson(Map<String, dynamic> json) => ApiPaymentModel(
    subTotal: json["sub_total"],
    tax: json["tax"],
    deliveryFee: json["delivery_fee"],
    total: json["total"],
    adminCommission: json["admin_commission"],
    repCommission: json["rep_commission"],
    cancellationFee: json["cancellation_fee"],
    paymentMethod: json["payment_method"] != null ? PaymentMethodsEnum.fromJson(json["payment_method"]) : null,
  );
}

extension ApiPaymentModelExt on ApiPaymentModel {
  PaymentEntity get map => PaymentEntity(
    subTotal: subTotal ?? '',
    tax: tax ?? '',
    deliveryFee: deliveryFee ?? '',
    total: total ?? '',
    adminCommission: adminCommission ?? '',
    repCommission: repCommission ?? '',
    cancellationFee: cancellationFee ?? '',
    paymentMethod: paymentMethod ?? PaymentMethodsEnum.electronicPay,
  );
}
