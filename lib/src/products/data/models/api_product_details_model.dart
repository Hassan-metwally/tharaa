import '../../../../core/core.dart';
import '../../../categories/data/models/api_category_model.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../domain/entities/product_details_entity.dart';
import 'api_product_model.dart';

class ApiProductDetailsModel extends ApiProductModel {
  final String? description;
  final ApiCategoryModel? subCategory;
  final DateTime? offerEndDate;

  ApiProductDetailsModel({
    required super.id,
    required super.name,
    required super.image,
    required super.category,
    required super.unit,
    required super.price,
    required this.offerEndDate,
    required super.offerPrice,
    required super.amount,
    required super.volume,
    required this.description,
    required this.subCategory,
  }) : super();

  factory ApiProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final dynamic subCategoryJson = json["sub_category"] ?? json["subCategory"] ?? json["subcategory"];
    final dynamic offerEndDateJson = json["offer_end_date"] ?? json["offerEndDate"];

    return ApiProductDetailsModel(
      id: json["id"],
      name: json["name"],
      image: AttachmentEntity.fromNetwork(url: json["image"]),
      category: json["category"] is Map<String, dynamic> ? ApiCategoryModel.fromJson(json["category"]) : null,
      unit: json["unit"]?.toString(),
      price: num.tryParse(json["price"]?.toString() ?? ''),
      offerPrice: num.tryParse((json["offer_price"] ?? json["offerPrice"])?.toString() ?? ''),
      offerEndDate: offerEndDateJson != null ? DateTime.tryParse(offerEndDateJson.toString()) : null,
      amount: num.tryParse(json["amount"]?.toString() ?? ''),
      volume: num.tryParse(json["volume"]?.toString() ?? ''),
      description: json["description"],
      subCategory: subCategoryJson is Map<String, dynamic> ? ApiCategoryModel.fromJson(subCategoryJson) : null,
    );
  }
}

extension ApiProductDetailsEXT on ApiProductDetailsModel {
  ProductDetailsEntity get map => ProductDetailsEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    category: category?.map ?? const CategoryEntity.initial(),
    unit: unit ?? '',
    price: price ?? 0,
    offerPrice: offerPrice,
    offerEndDate: offerEndDate,
    amount: amount,
    volume: volume,
    description: description ?? '',
    subCategory: subCategory?.map ?? const CategoryEntity.initial(),
  );
}
