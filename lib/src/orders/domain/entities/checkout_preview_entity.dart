import 'package:equatable/equatable.dart';

class CheckoutPreviewEntity extends Equatable {
  final num productsExclTax;
  final num deliveryFee;
  final num vat;
  final num discountPercent;
  final num total;

  const CheckoutPreviewEntity({
    required this.productsExclTax,
    required this.deliveryFee,
    required this.vat,
    required this.discountPercent,
    required this.total,
  });

  const CheckoutPreviewEntity.initial()
    : productsExclTax = 0,
      deliveryFee = 0,
      vat = 0,
      discountPercent = 0,
      total = 0;

  @override
  List<Object?> get props => [productsExclTax, deliveryFee, vat, discountPercent, total];
}
