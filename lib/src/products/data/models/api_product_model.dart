import '../../../../core/core.dart';
import '../../domain/entities/product_entity.dart';

class ApiProductModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;
  final String? category;
  final String? unit;
  final num? price;
  final num? offerPrice;
  final num? amount;

  ApiProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.unit,
    required this.price,
    this.offerPrice,
    this.amount,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) => ApiProductModel(
    id: json["id"],
    name: json["name"],
    image: AttachmentEntity.fromNetwork(url: json["image"]),
    category: json["category"] is Map<String, dynamic> ? json["category"]["name"] : json["category"]?.toString(),
    unit: json["unit"]?.toString(),
    price: num.tryParse(json["price"]?.toString() ?? ''),
    offerPrice: num.tryParse((json["offer_price"] ?? json["offerPrice"])?.toString() ?? ''),
    amount: num.tryParse(json["amount"]?.toString() ?? ''),
  );
}

extension ApiProductEXT on ApiProductModel {
  ProductEntity get map => ProductEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    category: category ?? '',
    unit: unit ?? '',
    price: price ?? 0,
    offerPrice: offerPrice,
    amount: amount,
  );
}
