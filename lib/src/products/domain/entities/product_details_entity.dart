import '../../../../core/core.dart';
import '../../../categories/domain/entities/category_entity.dart';
import 'product_entity.dart';

class ProductDetailsEntity extends ProductEntity {
  final String description;
  final CategoryEntity subCategory;
  final DateTime? offerEndDate;

  const ProductDetailsEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.category,
    required super.unit,
    required super.price,
    required super.offerPrice,
    required this.offerEndDate,
    required super.amount,
    required super.volume,
    required this.description,
    required this.subCategory,
  });

  const ProductDetailsEntity.initial()
    : description = '',
      subCategory = const CategoryEntity.initial(),
      offerEndDate = null,
      super.initial();

  @override
  ProductDetailsEntity copyWith({
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
    String? description,
    CategoryEntity? subCategory,
  }) {
    return ProductDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      offerEndDate: offerEndDate ?? this.offerEndDate,
      amount: amount ?? this.amount,
      volume: volume ?? this.volume,
      description: description ?? this.description,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([description, subCategory, offerEndDate]);
}
