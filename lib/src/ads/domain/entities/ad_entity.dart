import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class AdEntity extends Equatable {
  final int id;
  final String title;
  final AttachmentEntity image;

  const AdEntity({required this.id, required this.title, required this.image});

  const AdEntity.initial() : id = 0, title = '', image = const AttachmentEntity.empty();

  AdEntity copyWith({int? id, String? title, AttachmentEntity? image}) {
    return AdEntity(id: id ?? this.id, title: title ?? this.title, image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id, title, image];
}
