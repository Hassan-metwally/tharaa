import 'product_entity.dart';
import '../../../../core/core.dart';

class ProductDetailsEntity extends ProductEntity {
  final String description;
  final String subCategory;
  final DateTime? offerEndDate;

  const ProductDetailsEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.category,
    required super.unit,
    required super.price,
    super.offerPrice,
    super.amount,
    required this.description,
    required this.subCategory,
    this.offerEndDate,
  });

  const ProductDetailsEntity.initial()
    : description = '',
      subCategory = '',
      offerEndDate = null,
      super.initial();

  ProductDetailsEntity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
    String? category,
    String? unit,
    num? price,
    num? offerPrice,
    num? amount,
    String? description,
    String? subCategory,
    DateTime? offerEndDate,
  }) {
    return ProductDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      subCategory: subCategory ?? this.subCategory,
      offerEndDate: offerEndDate ?? this.offerEndDate,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([description, subCategory, offerEndDate]);
}
