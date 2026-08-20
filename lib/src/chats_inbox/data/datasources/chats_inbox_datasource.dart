import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/get_chats_inbox_usecase.dart';
import '../models/api_chats_inbox_model.dart';

abstract class ChatsInboxDatasource {
  Future<ApiPaginatedData<ApiChatInboxModel>> getChatsInbox(GetChatLogsParams params);
}

@Injectable(as: ChatsInboxDatasource)
class ChatsInboxDatasourceImpl extends ChatsInboxDatasource {
  final DioHelper dio;
  ChatsInboxDatasourceImpl(this.dio);

  @override
  Future<ApiPaginatedData<ApiChatInboxModel>> getChatsInbox(GetChatLogsParams params) async {
    try {
      final response = await dio.get(url: ApiConstants.addToApiUrlPath('chats'));
      return ApiPaginatedData.fromJson(response, getData: (dataList) => dataList.map((e) => ApiChatInboxModel.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
