import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';

class ApiCartItemModel {
  final int? id;
  final int? productId;
  final String? productName;
  final AttachmentEntity? productImage;
  final int? cartQuantity;
  final int? availableQuantity;
  final bool? unavailable;
  final String? price;

  const ApiCartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.cartQuantity,
    required this.availableQuantity,
    required this.unavailable,
    required this.price,
  });

  factory ApiCartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] is Map<String, dynamic> ? json['product'] as Map<String, dynamic> : null;

    return ApiCartItemModel(
      id: _parseInt(json['id']),
      productId: _parseInt(json['product_id'] ?? product?['id']),
      productName: (product?['name'] ?? product?['name_en'] ?? product?['name_ar'])?.toString(),
      productImage: AttachmentEntity.fromNetwork(url: product?['image']?.toString() ?? ''),
      cartQuantity: _parseInt(json['quantity'] ?? json['cart_quantity']),
      availableQuantity: _parseInt(json['available_quantity'] ?? product?['quantity']),
      unavailable: json['unavailable'] == true,
      price: _formatNum(json['line_total'] ?? json['offer_price'] ?? json['unit_price'] ?? product?['price'] ?? json['total']),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static String? _formatNum(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}

extension ApiCartItemModelExtension on ApiCartItemModel {
  CartItemEntity get map => CartItemEntity(
    id: id ?? 0,
    productId: productId ?? 0,
    productName: productName ?? '',
    productImage: productImage ?? const AttachmentEntity.empty(),
    cartQuantity: cartQuantity ?? 0,
    availableQuantity: availableQuantity,
    unavailable: unavailable ?? false,
    price: price ?? '',
  );
}
