import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class {{entity_type_pascal}}Entity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;

  const {{entity_type_pascal}}Entity({
    required this.id,
    required this.name,
    required this.image,
  });

  const {{entity_type_pascal}}Entity.initial()
      : id = 0,
        name = '',
        image = const AttachmentEntity.empty();

  {{entity_type_pascal}}Entity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
  }) {
    return {{entity_type_pascal}}Entity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }      

  @override
  List<Object?> get props => [id, name, image];
}

