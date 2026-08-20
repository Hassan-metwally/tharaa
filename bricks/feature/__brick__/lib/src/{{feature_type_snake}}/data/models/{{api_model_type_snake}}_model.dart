import '../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_entity.dart';

class {{api_model_type_pascal}}Model {
  final int? id;
  final String? name;
  final AttachmentEntity? image;

  {{api_model_type_pascal}}Model({
    required this.id,
    required this.name,
    required this.image,
  });

  factory {{api_model_type_pascal}}Model.fromJson(Map<String, dynamic> json) => {{api_model_type_pascal}}Model(
        id: json["id"],
        name: json["name"],
        image: AttachmentEntity.fromNetwork(url: json["image"]),
      );
}

extension {{api_model_type_pascal}}EXT on {{api_model_type_pascal}}Model {
  {{entity_type_pascal}}Entity get map => {{entity_type_pascal}}Entity(
        id: id ?? 0,
        name: name ?? '',
        image: image ?? const AttachmentEntity.empty(),
      );
}

