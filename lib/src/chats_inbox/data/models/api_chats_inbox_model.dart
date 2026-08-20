import '../../../chat/data/models/api_chat_message_model.dart';
import '../../../chat/data/models/api_message_author.dart';
import '../../domain/entities/chats_inbox_entity.dart';

class ApiChatInboxModel {
  final int? id;
  final String? type;
  final String? orderId;
  final ApiChatMessageModel? lastMessageEntity;
  final List<ApiChatMessageModel>? messages;
  final ApiMessageAuthor? user;
  final int unreadCount;

  const ApiChatInboxModel({
    required this.id,
    required this.type,
    required this.orderId,
    required this.lastMessageEntity,
    required this.messages,
    required this.user,
    required this.unreadCount,
  });

  factory ApiChatInboxModel.fromJson(Map<String, dynamic> json) {
    return ApiChatInboxModel(
      id: json["id"],
      type: json["type"],
      orderId: json["order_id"],
      lastMessageEntity: json["last_message"] == null ? null : ApiChatMessageModel.fromJson(json["last_message"]),
      messages: json["messages"] == null
          ? []
          : List<ApiChatMessageModel>.from(json["messages"].map((x) => ApiChatMessageModel.fromJson(x))),
      user: ApiMessageAuthor.fromJson(json["client"]),
      unreadCount: json["unread_count"] ?? 0,
    );
  }
}

extension ApiChatInboxModelExt on ApiChatInboxModel {
  ChatsInboxEntity get map => ChatsInboxEntity(
    id: id ?? 0,
    type: type ?? '',
    orderId: orderId ?? '',
    lastMessageEntity: lastMessageEntity?.map,
    messages: messages?.map((e) => e.map).toList() ?? [],
    user: user!.map,
    unreadCount: unreadCount,
  );
}
