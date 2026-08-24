import '../../../../core/core.dart';
import '../../../categories/data/models/api_category_model.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

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
      id: json["id"],
      name: json["name"],
      image: AttachmentEntity.fromNetwork(url: json["image"]),
      category: json["category"] is Map<String, dynamic> ? ApiCategoryModel.fromJson(json["category"]) : null,
      unit: json["unit"]?.toString(),
      price: num.tryParse(json["price"]?.toString() ?? ''),
      offerPrice: num.tryParse((json["offer_price"] ?? json["offerPrice"])?.toString() ?? ''),
      amount: num.tryParse(json["amount"]?.toString() ?? ''),
      volume: num.tryParse(json["volume"]?.toString() ?? ''),
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
