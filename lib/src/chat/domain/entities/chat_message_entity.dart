import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import 'chat_message_type_enum.dart';
import 'message_auther.dart';

class ChatMessageEntity extends Equatable {
  final int id;
  final String messageText;
  final List<String> attachments;
  final ChatMessageType type;
  final bool isRead;
  final bool isMine;
  final MessageAuthor author;
  final DateTime createdAt;

  /// Handle On Send Message
  final int? localId;
  final Async<void> sendStatus;

  const ChatMessageEntity({
    required this.id,
    required this.messageText,
    required this.attachments,
    required this.isMine,
    this.type = ChatMessageType.text,
    required this.isRead,
    required this.localId,
    required this.sendStatus,
    required this.author,
    required this.createdAt,
  });

  ChatMessageEntity copyWith({
    final DateTime? readAt,
    final bool? isRead,
    final Async<void>? sendStatus,
    final int? localId,
    final bool? isMine,
  }) {
    return ChatMessageEntity(
      id: id,
      messageText: messageText,
      attachments: attachments,
      isMine: isMine ?? this.isMine,
      type: type,
      isRead: isRead ?? this.isRead,
      localId: localId ?? this.localId,
      author: author,
      sendStatus: sendStatus ?? this.sendStatus,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, type, attachments, isRead, isMine, sendStatus, localId, messageText, author, createdAt];
}
