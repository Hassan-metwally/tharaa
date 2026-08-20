import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';

class ApiCartItemModel {
  final int? productId;
  final String? productName;
  final AttachmentEntity? productImage;
  final int? cartQuantity;
  final int? availableQuantity;
  final String? price;

  const ApiCartItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.cartQuantity,
    required this.availableQuantity,
    required this.price,
  });

  factory ApiCartItemModel.fromJson(Map<String, dynamic> json) => ApiCartItemModel(
    productId: json['product']['id'],
    productName: json['product']['name'],
    productImage: AttachmentEntity.fromNetwork(url: json['product']['image']),
    cartQuantity: json['cart_quantity'],
    availableQuantity: json['product']['quantity'],
    price: json['total'],
  );
}

extension ApiCartItemModelExtension on ApiCartItemModel {
  CartItemEntity get map => CartItemEntity(
    productId: productId ?? 0,
    productName: productName ?? '',
    productImage: productImage ?? const AttachmentEntity.empty(),
    cartQuantity: cartQuantity ?? 0,
    availableQuantity: availableQuantity,
    price: price ?? '',
  );
}
