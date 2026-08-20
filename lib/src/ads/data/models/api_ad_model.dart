import '../../../../core/core.dart';
import '../../domain/entities/ad_entity.dart';

class ApiAdModel {
  final int? id;
  final String? title;
  final AttachmentEntity? image;

  ApiAdModel({required this.id, required this.title, required this.image});

  factory ApiAdModel.fromJson(Map<String, dynamic> json) => ApiAdModel(
    id: json["id"],
    title: json["title"],
    image: AttachmentEntity.fromNetwork(url: json["image"]),
  );
}

extension ApiAdEXT on ApiAdModel {
  AdEntity get map => AdEntity(id: id ?? 0, title: title ?? '', image: image ?? const AttachmentEntity.empty());
}
