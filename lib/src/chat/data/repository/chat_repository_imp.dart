import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/chat_information_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_page_input.dart';
import '../../domain/repository/chat_repository.dart';
import '../../domain/use_cases/get_chat_messages_use_case.dart';
import '../../domain/use_cases/send_chat_message_use_case.dart';
import '../data_source/chat_data_source.dart';
import '../models/api_chat_message_model.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImp implements ChatRepository {
  final ChatDataSource _dataSource;
  final GetCachedUserUseCase _getCachedUserUseCase;

  ChatRepositoryImp(this._dataSource, this._getCachedUserUseCase);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessages(GetChatMessagesParams params) async {
    return await failureCollect(() async {
      final List<ApiChatMessageModel> result = await _dataSource.getMessages(params);
      final currentUser = await _getCachedUserUseCase();
      final List<ChatMessageEntity> data = result.map((e) => e.map.copyWith(isMine: e.author?.id == currentUser?.id)).toList();

      return Right(data);
    });
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage(SendChatMessageParams params) async {
    return await failureCollect(() async {
      final ApiChatMessageModel result;
      result = await _dataSource.sendMessage(params);
      final currentUser = await _getCachedUserUseCase();
      return Right(result.map.copyWith(isMine: result.author?.id == currentUser?.id));
    });
  }

  @override
  Future<Either<Failure, IChatDetailsEntity>> getChatInfo(IChatPageInput params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getChatInformation(params);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, void>> setMessagesRead(int chatId) async {
    return await failureCollect(() async {
      await _dataSource.setMessagesAsRead(chatId);
      return const Right(null);
    });
  }
}
