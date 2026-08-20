import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class CartItemEntity extends Equatable {
  final int productId;
  final String productName;
  final AttachmentEntity productImage;
  final int cartQuantity;
  final int? availableQuantity;
  final String price;

  const CartItemEntity({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.cartQuantity,
    required this.availableQuantity,
    required this.price,
  });

  factory CartItemEntity.initial() => const CartItemEntity(
    productId: 0,
    productName: '',
    productImage: AttachmentEntity.empty(),
    cartQuantity: 0,
    availableQuantity: 0,
    price: '',
  );

  CartItemEntity copyWith({
    int? productId,
    String? productName,
    AttachmentEntity? productImage,
    int? cartQuantity,
    int? availableQuantity,
    String? price,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      cartQuantity: cartQuantity ?? this.cartQuantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [productId, productName, productImage, cartQuantity, availableQuantity, price];
}
