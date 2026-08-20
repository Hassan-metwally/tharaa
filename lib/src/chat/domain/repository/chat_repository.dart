import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/chat_information_entity.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_page_input.dart';
import '../use_cases/get_chat_messages_use_case.dart';
import '../use_cases/send_chat_message_use_case.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessages(GetChatMessagesParams params);

  Future<Either<Failure, ChatMessageEntity>> sendMessage(SendChatMessageParams params);

  Future<Either<Failure, IChatDetailsEntity>> getChatInfo(IChatPageInput params);

  Future<Either<Failure, void>> setMessagesRead(int chatId);
}
