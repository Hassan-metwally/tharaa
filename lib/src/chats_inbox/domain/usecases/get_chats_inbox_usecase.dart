import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/chats_inbox_entity.dart';
import '../repositories/chats_inbox_repository.dart';

@Injectable()
class GetChatsInboxUsecase extends IUseCase<PaginatedData<ChatsInboxEntity>, GetChatLogsParams> {
  final ChatsInboxRepository repository;
  GetChatsInboxUsecase(this.repository);

  @override
  Future<Either<Failure, PaginatedData<ChatsInboxEntity>>> call(GetChatLogsParams params) {
    return repository.getChatsInbox(params);
  }
}

class GetChatLogsParams {
  final int page;

  GetChatLogsParams({required this.page});

  Map<String, dynamic> toJson() {
    return {'page': page};
  }
}
