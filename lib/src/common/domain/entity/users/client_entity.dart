import '../../../../../core/core.dart';
import '../../../../authentication/domain/entities/user_entity.dart';

class ClientEntity extends UserEntity {
  final bool isActive;

  const ClientEntity({
    required super.id,
    required super.name,
    required super.mobile,
    required super.avatar,
    required super.isVerified,
    required this.isActive,
  });

  const ClientEntity.initial()
    : this(id: 0, name: '', mobile: '', avatar: const AttachmentEntity.empty(), isVerified: false, isActive: false);

  @override
  ClientEntity copyWith({int? id, String? name, String? mobile, AttachmentEntity? avatar, bool? isVerified, bool? isActive}) {
    return ClientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => super.props..add(isActive);
}
