import '../../../../../core/core.dart';
import '../../../../authentication/data/models/api_user_model.dart';
import '../../../domain/entity/users/client_entity.dart';

class ApiClientModel extends ApiUserModel {
  final bool? isActive;
  final String? email;
  ApiClientModel({
    required super.id,
    required super.name,
    required super.mobile,
    required super.avatar,
    required super.isVerified,
    required this.isActive,
    required this.email,
  });

  factory ApiClientModel.fromJson(Map<String, dynamic> json) => ApiClientModel(
    id: json["id"],
    name: json["name"],
    mobile: json["phone"],
    avatar: json["avatar"] != null ? AttachmentEntity.fromNetwork(url: json["avatar"]) : null,
    isVerified: json["is_verified"],
    isActive: json["is_active"],
    email: json["email"],
  );
}

extension ApiClientModelEXT on ApiClientModel {
  ClientEntity get map => ClientEntity(
    id: id ?? 0,
    name: name ?? '',
    mobile: mobile ?? '',
    avatar: avatar ?? const AttachmentEntity.empty(),
    isVerified: isVerified,
    isActive: isActive ?? false,
    email: email ?? '',
  );
}
