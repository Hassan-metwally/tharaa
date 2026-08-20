import '../../domain/entities/chat_user_type_enum.dart';
import '../../domain/entities/message_auther.dart';

class ApiMessageAuthor {
  final int? id;
  final String? name;
  final String? avatar;
  final String? type;

  const ApiMessageAuthor({required this.id, required this.name, required this.avatar, required this.type});

  factory ApiMessageAuthor.fromJson(Map<String, dynamic> json) =>
      ApiMessageAuthor(id: json["id"], name: json["name"] ?? '', avatar: json["avatar"] ?? '', type: json["type"]);
}

extension ApiMessageAuthorExt on ApiMessageAuthor {
  MessageAuthor get map {
    return MessageAuthor(id: id ?? 0, avatar: avatar ?? '', name: name ?? '', type: ChatUserTypeEnum.fromJson(type));
  }
}
