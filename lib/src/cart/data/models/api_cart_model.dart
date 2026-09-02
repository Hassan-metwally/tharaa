import '../../domain/entities/cart_entity.dart';
import 'api_cart_item_model.dart';

class ApiCartModel {
  final int? id;
  final List<ApiCartItemModel>? items;
  final String? productsPrice;
  final String? deliveryPrice;
  final String? totalPrice;
  final String? taxAmount;
  final String? savingsAmount;
  final bool? hasUnavailableItems;

  ApiCartModel({
    this.id,
    this.items,
    this.productsPrice,
    this.deliveryPrice,
    this.totalPrice,
    this.taxAmount,
    this.savingsAmount,
    this.hasUnavailableItems,
  });

  factory ApiCartModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] ?? json['products'];

    return ApiCartModel(
      id: json['id'],
      items: itemsJson != null
          ? List<ApiCartItemModel>.from(
              (itemsJson as List<dynamic>).map((item) => ApiCartItemModel.fromJson(item as Map<String, dynamic>)),
            )
          : null,
      productsPrice: _formatNum(json['cart_total']),
      deliveryPrice: _formatNum(json['delivery_fees']),
      totalPrice: _formatNum(json['grand_total'] ?? json['total']),
      taxAmount: _formatNum(json['tax_amount']),
      savingsAmount: _formatNum(json['savings_amount']),
      hasUnavailableItems: json['has_unavailable_items'] == true,
    );
  }

  static String? _formatNum(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}

extension ApiCartModelExtension on ApiCartModel {
  CartEntity get map => CartEntity(
    id: id ?? 0,
    items: items?.map((item) => item.map).toList() ?? [],
    productsPrice: productsPrice ?? '',
    deliveryPrice: deliveryPrice ?? '',
    totalPrice: totalPrice ?? '',
    taxAmount: taxAmount ?? '',
    savingsAmount: savingsAmount ?? '',
    hasUnavailableItems: hasUnavailableItems ?? false,
  );
}
