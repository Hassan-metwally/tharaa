import '../../domain/entities/checkout_preview_entity.dart';

class ApiCheckoutPreviewModel {
  final num? productsExclTax;
  final num? deliveryFee;
  final num? vat;
  final num? discountPercent;
  final num? total;

  const ApiCheckoutPreviewModel({
    this.productsExclTax,
    this.deliveryFee,
    this.vat,
    this.discountPercent,
    this.total,
  });

  factory ApiCheckoutPreviewModel.fromJson(Map<String, dynamic> json) {
    return ApiCheckoutPreviewModel(
      productsExclTax: _parseNum(json['products_excl_tax']),
      deliveryFee: _parseNum(json['delivery_fee']),
      vat: _parseNum(json['vat']),
      discountPercent: _parseNum(json['discount_percent']),
      total: _parseNum(json['total']),
    );
  }

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}

extension ApiCheckoutPreviewExt on ApiCheckoutPreviewModel {
  CheckoutPreviewEntity get map => CheckoutPreviewEntity(
    productsExclTax: productsExclTax ?? 0,
    deliveryFee: deliveryFee ?? 0,
    vat: vat ?? 0,
    discountPercent: discountPercent ?? 0,
    total: total ?? 0,
  );
}
