import 'package:equatable/equatable.dart';

import '../../../chat/domain/entities/chat_message_entity.dart';
import '../../../chat/domain/entities/message_auther.dart' show MessageAuthor;

class ChatsInboxEntity extends Equatable {
  final int id;
  final String type;
  final String orderId;
  final ChatMessageEntity? lastMessageEntity;
  final List<ChatMessageEntity> messages;
  final MessageAuthor user;
  final int unreadCount;

  const ChatsInboxEntity({
    required this.id,
    required this.type,
    required this.orderId,
    required this.lastMessageEntity,
    required this.messages,
    required this.user,
    required this.unreadCount,
  });

  ChatsInboxEntity copyWith({
    int? id,
    String? type,
    String? orderId,
    ChatMessageEntity? lastMessageEntity,
    List<ChatMessageEntity>? messages,
    MessageAuthor? user,
    int? unreadCount,
  }) => ChatsInboxEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    orderId: orderId ?? this.orderId,
    lastMessageEntity: lastMessageEntity ?? this.lastMessageEntity,
    messages: messages ?? this.messages,
    user: user ?? this.user,
    unreadCount: unreadCount ?? this.unreadCount,
  );

  // factory ChatEntity.fromJson(Map<String, dynamic> json) => ChatEntity(
  //       id: json["id"],
  //       type: json["type"],
  //       orderId: json["order_id"],
  //       lastMessageEntity: json["last_message"] == null ? null : ApiChatMessageModel.fromJson(json["last_message"]),
  //       messages: json["messages"] == null ? [] : List<ChatMessageEntity>.from(json["messages"].map((x) => ChatMessageEntity.fromJson(x))),
  //       user: json["user"]["user"] == null ? null :  ApiUserModel.fromJson(json["user"]["user"]).map,
  //       unreadCount: json["countMessagesUnread"] ?? 0,
  //     );

  ChatsInboxEntity addMessage(ChatMessageEntity message) {
    final List<ChatMessageEntity> newMessagesList = List.from(messages);
    newMessagesList.add(message);
    return ChatsInboxEntity(
      id: id,
      type: type,
      user: user,
      messages: newMessagesList,
      orderId: orderId,
      lastMessageEntity: message,
      unreadCount: unreadCount,
    );
  }

  @override
  List<Object?> get props => [id, type, orderId, lastMessageEntity, messages, user, unreadCount];
}
