import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/chats_inbox_entity.dart';
import '../../domain/repositories/chats_inbox_repository.dart';
import '../../domain/usecases/get_chats_inbox_usecase.dart';
import '../datasources/chats_inbox_datasource.dart';
import '../models/api_chats_inbox_model.dart';

@Injectable(as: ChatsInboxRepository)
class ChatsInboxRepositoryImpl extends ChatsInboxRepository {
  final ChatsInboxDatasource _datasource;

  ChatsInboxRepositoryImpl(this._datasource);

  @override
  DomainServiceType<PaginatedData<ChatsInboxEntity>> getChatsInbox(GetChatLogsParams params) async {
    return await failureCollect(() async {
      final result = await _datasource.getChatsInbox(params);
      return Right(result.map((data) => data.map));
    });
  }
}
