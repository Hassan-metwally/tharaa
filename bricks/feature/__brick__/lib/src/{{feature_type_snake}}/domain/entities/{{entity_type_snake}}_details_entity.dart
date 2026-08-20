import '{{entity_type_snake}}_entity.dart';
import '../../../../core/core.dart';

class {{entity_type_pascal}}DetailsEntity extends {{entity_type_pascal}}Entity {
  final String description;

  const {{entity_type_pascal}}DetailsEntity({
    required super.id,
    required super.name,
    required super.image,
    required this.description,
  });

  const {{entity_type_pascal}}DetailsEntity.initial()
      : description = '',
        super.initial();

  {{entity_type_pascal}}DetailsEntity copyWith({String? description, AttachmentEntity? image, String? name, int? id}) {
    return {{entity_type_pascal}}DetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([description]);
}

