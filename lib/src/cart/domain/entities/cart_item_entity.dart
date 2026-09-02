import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class CartItemEntity extends Equatable {
  final int id;
  final int productId;
  final String productName;
  final AttachmentEntity productImage;
  final int cartQuantity;
  final int? availableQuantity;
  final bool unavailable;
  final String price;

  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.cartQuantity,
    required this.availableQuantity,
    this.unavailable = false,
    required this.price,
  });

  factory CartItemEntity.initial() => const CartItemEntity(
    id: 0,
    productId: 0,
    productName: '',
    productImage: AttachmentEntity.empty(),
    cartQuantity: 0,
    availableQuantity: 0,
    unavailable: false,
    price: '',
  );

  CartItemEntity copyWith({
    int? id,
    int? productId,
    String? productName,
    AttachmentEntity? productImage,
    int? cartQuantity,
    int? availableQuantity,
    bool? unavailable,
    String? price,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      cartQuantity: cartQuantity ?? this.cartQuantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      unavailable: unavailable ?? this.unavailable,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, productId, productName, productImage, cartQuantity, availableQuantity, unavailable, price];
}
