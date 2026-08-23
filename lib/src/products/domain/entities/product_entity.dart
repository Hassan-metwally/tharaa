import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;
  final String category;
  final String unit;
  final num price;
  final num? offerPrice;
  final num? amount;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.unit,
    required this.price,
    this.offerPrice,
    this.amount,
  });

  const ProductEntity.initial()
    : id = 0,
      name = '',
      image = const AttachmentEntity.empty(),
      category = '',
      unit = '',
      price = 0,
      offerPrice = null,
      amount = null;

  ProductEntity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
    String? category,
    String? unit,
    num? price,
    num? offerPrice,
    num? amount,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [id, name, image, category, unit, price, offerPrice, amount];
}
