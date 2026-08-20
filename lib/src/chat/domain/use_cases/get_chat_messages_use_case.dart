import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/chat_message_entity.dart';
import '../repository/chat_repository.dart';

@Injectable()
class GetChatMessagesUseCase extends IUseCase<void, GetChatMessagesParams> {
  final ChatRepository _repository;
  GetChatMessagesUseCase(this._repository);
  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(GetChatMessagesParams params) async {
    return await _repository.getChatMessages(params);
  }
}

class GetChatMessagesParams extends NoParams {
  final int chatId;
  final int pageKey;

  GetChatMessagesParams({required this.chatId, required this.pageKey});

  @override
  Future<Map<String, dynamic>> get toMap async => {"page": pageKey};
}
