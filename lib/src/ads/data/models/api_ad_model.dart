import '../../../../core/core.dart';
import '../../domain/entities/ad_entity.dart';

class ApiAdModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;
  final AdType? type;
  final int? linkableId;
  final String? externalUrl;

  ApiAdModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.linkableId,
    required this.externalUrl,
  });

  factory ApiAdModel.fromJson(Map<String, dynamic> json) => ApiAdModel(
    id: int.tryParse(json["id"]?.toString() ?? ''),
    name: json["name"],
    image: AttachmentEntity.fromNetwork(url: json["media_url"]?.toString() ?? ''),
    type: AdType.fromJson(json["link_type"]?.toString() ?? ''),
    linkableId: int.tryParse(json["linkable_id"]?.toString() ?? ''),
    externalUrl: json["external_url"]?.toString(),
  );
}

extension ApiAdEXT on ApiAdModel {
  AdEntity get map => AdEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    type: type ?? AdType.unknown,
    linkableId: linkableId,
    externalUrl: externalUrl,
  );
}
