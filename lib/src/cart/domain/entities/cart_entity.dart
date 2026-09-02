import 'package:equatable/equatable.dart';

import 'cart_item_entity.dart';

class CartEntity extends Equatable {
  final int id;
  final List<CartItemEntity> items;
  final String productsPrice;
  final String deliveryPrice;
  final String totalPrice;
  final String taxAmount;
  final String savingsAmount;
  final bool hasUnavailableItems;

  const CartEntity({
    required this.id,
    required this.items,
    required this.productsPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.taxAmount,
    this.savingsAmount = '',
    this.hasUnavailableItems = false,
  });

  @override
  List<Object?> get props => [
    id,
    items,
    productsPrice,
    deliveryPrice,
    totalPrice,
    taxAmount,
    savingsAmount,
    hasUnavailableItems,
  ];
}
