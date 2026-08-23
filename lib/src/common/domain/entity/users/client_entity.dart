import '../../../../../core/core.dart';
import '../../../../authentication/domain/entities/user_entity.dart';

class ClientEntity extends UserEntity {
  final bool isActive;
  final String email;
  const ClientEntity({
    required super.id,
    required super.name,
    required super.mobile,
    required super.avatar,
    required super.isVerified,
    required this.isActive,
    required this.email,
  });

  const ClientEntity.initial()
    : this(id: 0, name: '', mobile: '', avatar: const AttachmentEntity.empty(), isVerified: false, isActive: false , email: '');

  @override
  ClientEntity copyWith({int? id, String? name, String? mobile, AttachmentEntity? avatar, bool? isVerified, bool? isActive, String? email}) {
    return ClientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => super.props..add(isActive)..add(email);
}
