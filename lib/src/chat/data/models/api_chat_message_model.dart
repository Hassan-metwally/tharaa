import '../../../../core/core.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_message_type_enum.dart';
import 'api_message_author.dart';

class ApiChatMessageModel {
  final int? id;
  final String? type;
  final String? messageText;
  final List<String> attachments;
  final String? messageType;
  final bool? isRead;
  final ApiMessageAuthor? author;
  final DateTime? createdAt;

  const ApiChatMessageModel({
    required this.id,
    required this.type,
    this.attachments = const [],
    required this.messageText,
    required this.messageType,
    required this.createdAt,
    required this.isRead,
    required this.author,
  });

  factory ApiChatMessageModel.fromJson(Map<String, dynamic> json) {
    final List media = json["message_media"] ?? [];
    return ApiChatMessageModel(
      id: json["id"],
      type: json["type"],
      attachments: media.map((e) => e['image'].toString()).toList(),
      messageText: json["message"],
      messageType: json["message_type"],
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      isRead: json["is_read"],
      author: json["sender"]['user'] != null ? ApiMessageAuthor.fromJson(json["sender"]['user']) : null,
    );
  }
}

extension ApiChatMessagesModelExt on ApiChatMessageModel {
  ChatMessageEntity get map {
    return ChatMessageEntity(
      id: id ?? 0,
      localId: null,
      attachments: attachments,
      sendStatus: const Async.successWithoutData(),
      messageText: messageText ?? '',
      isRead: isRead ?? false,
      type: ChatMessageType.fromJson(type),
      author: author!.map,
      isMine: false,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
