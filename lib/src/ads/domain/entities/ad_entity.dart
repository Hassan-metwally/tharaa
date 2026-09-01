import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

enum AdType {
  none("none"),
  external("external"),
  product("product"),
  offer("offer"),
  category("category"),
  unknown("");

  final String json;

  const AdType(this.json);

  factory AdType.fromJson(String json) =>
      AdType.values.firstWhereOrNull((element) => element.json == json.toLowerCase().trim()) ?? AdType.unknown;
}

class AdEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;
  final AdType type;
  final int? linkableId;
  final String? externalUrl;

  const AdEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.linkableId,
    required this.externalUrl,
  });

  const AdEntity.initial()
    : id = 0,
      name = '',
      image = const AttachmentEntity.empty(),
      type = AdType.unknown,
      linkableId = null,
      externalUrl = null;

  bool get canOpen {
    switch (type) {
      case AdType.product:
      case AdType.category:
        return linkableId != null && linkableId! > 0;
      case AdType.offer:
        return true;
      case AdType.external:
        return externalUrl != null && externalUrl!.trim().isNotEmpty;
      case AdType.none:
      case AdType.unknown:
        return false;
    }
  }

  AdEntity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
    AdType? type,
    int? linkableId,
    String? externalUrl,
  }) {
    return AdEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      type: type ?? this.type,
      linkableId: linkableId ?? this.linkableId,
      externalUrl: externalUrl ?? this.externalUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, image, type, linkableId, externalUrl];
}
