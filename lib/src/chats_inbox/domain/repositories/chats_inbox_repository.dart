import '../../../../core/core.dart';
import '../entities/chats_inbox_entity.dart';

import '../usecases/get_chats_inbox_usecase.dart';

abstract class ChatsInboxRepository {
  DomainServiceType<PaginatedData<ChatsInboxEntity>> getChatsInbox(GetChatLogsParams params);
}
