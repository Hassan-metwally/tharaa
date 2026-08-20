import '../../domain/entities/cart_entity.dart';
import 'api_cart_item_model.dart';

class ApiCartModel {
  final int? id;
  final List<ApiCartItemModel>? items;
  final String? productsPrice;
  final String? deliveryPrice;
  final String? totalPrice;
  final String? taxAmount;

  ApiCartModel({this.id, this.items, this.productsPrice, this.deliveryPrice, this.totalPrice, this.taxAmount});

  factory ApiCartModel.fromJson(Map<String, dynamic> json) => ApiCartModel(
    id: json['id'],
    items: json['products'] != null
        ? List<ApiCartItemModel>.from(
            (json['products'] as List<dynamic>).map((item) => ApiCartItemModel.fromJson(item as Map<String, dynamic>)),
          )
        : null,
    productsPrice: json['cart_total'].toString(),
    deliveryPrice: json['delivery_fees'].toString(),
    totalPrice: json['total'].toString(),
    taxAmount: json['tax_amount'].toString(),
  );
}

extension ApiCartModelExtension on ApiCartModel {
  CartEntity get map => CartEntity(
    id: id ?? 0,
    items: items?.map((item) => item.map).toList() ?? [],
    productsPrice: productsPrice ?? '',
    deliveryPrice: deliveryPrice ?? '',
    totalPrice: totalPrice ?? '',
    taxAmount: taxAmount ?? '',
  );
}
