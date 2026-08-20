import '../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_details_entity.dart';
import '{{api_model_type_snake}}_model.dart';

class {{api_model_type_pascal}}DetailsModel extends {{api_model_type_pascal}}Model {
  final String? description;

  {{api_model_type_pascal}}DetailsModel({
    required super.id,
    required super.name,
    required super.image,
    required this.description,
  });

  factory {{api_model_type_pascal}}DetailsModel.fromJson(Map<String, dynamic> json) => {{api_model_type_pascal}}DetailsModel(
        id: json["id"],
        name: json["name"],
        image: AttachmentEntity.fromNetwork(url: json["image"]),
        description: json["description"],
      );
}

extension {{api_model_type_pascal}}DetailsEXT on {{api_model_type_pascal}}DetailsModel {
  {{entity_type_pascal}}DetailsEntity get map => {{entity_type_pascal}}DetailsEntity(
        id: id ?? 0,
        name: name ?? '',
        image: image ?? const AttachmentEntity.empty(),
        description: description ?? '',
      );
}

