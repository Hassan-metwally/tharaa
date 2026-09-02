import '../../../../core/core.dart';
import '../../../categories/data/models/api_category_model.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

num? _parseNum(dynamic value) => num.tryParse(value?.toString() ?? '');

class ApiProductModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;
  final ApiCategoryModel? category;
  final num? price;
  final num? offerPrice;
  final num? amount;
  final num? volume;
  final String? unit;

  ApiProductModel({
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

  factory ApiProductModel.fromJson(Map<String, dynamic> json) {
    return ApiProductModel(
      id: json['id'],
      name: json['name'],
      image: AttachmentEntity.fromNetwork(url: json['image']),
      category: json['category'] is Map<String, dynamic> ? ApiCategoryModel.fromJson(json['category']) : null,
      unit: (json['unit_type'] ?? json['unit'])?.toString(),
      price: _parseNum(json['price']),
      offerPrice: _parseNum(
        json['effective_price'],
      ),
      amount: _parseNum(json['units_count'] ?? json['amount']),
      volume: _parseNum(json['unit_weight'] ?? json['volume']),
    );
  }
}

class ApiOfferModel {
  final int? id;
  final int? productId;
  final num? originalPrice;
  final num? discountedPrice;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final ApiProductModel? product;

  ApiOfferModel({
    required this.id,
    required this.productId,
    required this.originalPrice,
    required this.discountedPrice,
    required this.startsAt,
    required this.endsAt,
    required this.product,
  });

  factory ApiOfferModel.fromJson(Map<String, dynamic> json) {
    return ApiOfferModel(
      id: json['id'],
      productId: json['product_id'],
      originalPrice: _parseNum(json['price']),
      discountedPrice: _parseNum(json['effective_price'] ?? json['discounted_price']),
      startsAt: json['starts_at'] != null ? DateTime.tryParse(json['starts_at'].toString()) : null,
      endsAt: json['ends_at'] != null ? DateTime.tryParse(json['ends_at'].toString()) : null,
      product: json['product'] is Map<String, dynamic> ? ApiProductModel.fromJson(json['product']) : null,
    );
  }

  static ApiProductModel mapListItem(Map<String, dynamic> json) {
    if (json['product'] is Map<String, dynamic>) {
      return ApiOfferModel.fromJson(json).toProductModel();
    }
    return ApiProductModel.fromJson(json);
  }

  ApiProductModel toProductModel() {
    final nested = product!;
    return ApiProductModel(
      id: nested.id,
      name: nested.name,
      image: nested.image,
      category: nested.category,
      unit: nested.unit,
      price: originalPrice ?? nested.price,
      offerPrice: discountedPrice ?? nested.offerPrice,
      amount: nested.amount,
      volume: nested.volume,
    );
  }
}

extension ApiProductEXT on ApiProductModel {
  ProductEntity get map => ProductEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    category: category?.map ?? const CategoryEntity.initial(),
    unit: unit ?? '',
    price: price ?? 0,
    offerPrice: offerPrice,
    amount: amount,
    volume: volume,
  );
}

extension ApiOfferEXT on ApiOfferModel {
  ProductEntity get map {
    final entity = product!.map;
    return entity.copyWith(price: originalPrice ?? entity.price, offerPrice: discountedPrice ?? entity.offerPrice);
  }
}
