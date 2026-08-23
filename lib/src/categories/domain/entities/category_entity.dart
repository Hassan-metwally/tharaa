import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;

  const CategoryEntity({required this.id, required this.name, required this.image});

  const CategoryEntity.initial() : id = 0, name = '', image = const AttachmentEntity.empty();

  CategoryEntity copyWith({int? id, String? name, AttachmentEntity? image}) {
    return CategoryEntity(id: id ?? this.id, name: name ?? this.name, image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id, name, image];
}
