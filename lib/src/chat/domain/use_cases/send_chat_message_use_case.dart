import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_message_type_enum.dart';
import '../entities/chat_page_input.dart';
import '../repository/chat_repository.dart';

@Injectable()
class SendChatMessageUseCase extends IUseCase<void, SendChatMessageParams> {
  final ChatRepository _repository;
  SendChatMessageUseCase(this._repository);
  @override
  Future<Either<Failure, ChatMessageEntity>> call(SendChatMessageParams params) async {
    return await _repository.sendMessage(params);
  }
}

class SendChatMessageParams extends NoParams {
  final int chatId;
  final String message;
  final List<String> media;
  final ChatMessageType messageType;
  final IChatPageInput input;

  SendChatMessageParams({
    required this.chatId,
    required this.message,
    this.messageType = ChatMessageType.text,
    this.media = const [],
    required this.input,
  });

  String get getRequetUrl => input.getSendMessageApiRequestPath;

  @override
  Future<Map<String, dynamic>> get toMap async => {
    "chat_id": chatId,
    "message": message,
    "type": messageType.jsonValue,
    if (media.isNotEmpty) "media[]": media.map((e) => e.toMultipartFile).toList(),
  };
}
