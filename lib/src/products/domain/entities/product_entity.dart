import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../categories/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;
  final CategoryEntity category;
  final String unit;
  final num price;
  final num? offerPrice;
  final num? amount;
  final num? volume;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.unit,
    required this.price,
    this.offerPrice,
    this.amount,
    this.volume,
  });

  const ProductEntity.initial()
    : id = 0,
      name = '',
      image = const AttachmentEntity.empty(),
      category = const CategoryEntity.initial(),
      unit = '',
      price = 0,
      offerPrice = null,
      amount = null,
      volume = null;

  ProductEntity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
    CategoryEntity? category,
    String? unit,
    num? price,
    num? offerPrice,
    DateTime? offerEndDate,
    num? amount,
    num? volume,
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
      volume: volume ?? this.volume,
    );
  }

  @override
  List<Object?> get props => [id, name, image, category, unit, price, offerPrice, amount, volume];
}
