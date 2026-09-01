import '../../../../core/core.dart';
import '../../domain/entities/category_entity.dart';

class ApiCategoryModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;

  ApiCategoryModel({required this.id, required this.name, required this.image});

  factory ApiCategoryModel.fromJson(Map<String, dynamic> json) => ApiCategoryModel(
    id: int.tryParse(json["id"]?.toString() ?? ''),
    name: json["name"]?.toString(),
    image: AttachmentEntity.fromNetwork(url: json["image"]?.toString() ?? ''),
  );
}

extension ApiCategoryEXT on ApiCategoryModel {
  CategoryEntity get map => CategoryEntity(id: id ?? 0, name: name ?? '', image: image ?? const AttachmentEntity.empty());
}
