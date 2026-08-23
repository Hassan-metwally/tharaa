import '../../../../core/core.dart';
import '../../domain/entities/product_details_entity.dart';
import 'api_product_model.dart';

class ApiProductDetailsModel extends ApiProductModel {
  final String? description;
  final String? subCategory;
  final DateTime? offerEndDate;

  ApiProductDetailsModel({
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

  factory ApiProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final dynamic subCategoryJson = json["sub_category"] ?? json["subCategory"] ?? json["subcategory"];
    final dynamic offerEndDateJson = json["offer_end_date"] ?? json["offerEndDate"];

    return ApiProductDetailsModel(
      id: json["id"],
      name: json["name"],
      image: AttachmentEntity.fromNetwork(url: json["image"]),
      category: json["category"] is Map<String, dynamic> ? json["category"]["name"] : json["category"]?.toString(),
      unit: json["unit"]?.toString(),
      price: num.tryParse(json["price"]?.toString() ?? ''),
      offerPrice: num.tryParse((json["offer_price"] ?? json["offerPrice"])?.toString() ?? ''),
      amount: num.tryParse(json["amount"]?.toString() ?? ''),
      description: json["description"],
      subCategory: subCategoryJson is Map<String, dynamic> ? subCategoryJson["name"]?.toString() : subCategoryJson?.toString(),
      offerEndDate: offerEndDateJson != null ? DateTime.tryParse(offerEndDateJson.toString()) : null,
    );
  }
}

extension ApiProductDetailsEXT on ApiProductDetailsModel {
  ProductDetailsEntity get map => ProductDetailsEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    category: category ?? '',
    unit: unit ?? '',
    price: price ?? 0,
    offerPrice: offerPrice,
    amount: amount,
    description: description ?? '',
    subCategory: subCategory ?? '',
    offerEndDate: offerEndDate,
  );
}
