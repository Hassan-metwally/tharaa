import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/chat_information_entity.dart';
import '../../domain/entities/chat_page_input.dart';
import '../../domain/use_cases/get_chat_messages_use_case.dart';
import '../../domain/use_cases/send_chat_message_use_case.dart';
import '../models/api_chat_message_model.dart';

String _getMessagesUrl(int orderId) => "chat/$orderId/show";
const String _setMessagesAsReadUrl = "/chat/read-chat";

abstract class ChatDataSource {
  Future<IChatDetailsEntity> getChatInformation(IChatPageInput params);

  Future<List<ApiChatMessageModel>> getMessages(GetChatMessagesParams params);

  Future<ApiChatMessageModel> sendMessage(SendChatMessageParams params);

  Future<void> setMessagesAsRead(int orderId);
}

@Injectable(as: ChatDataSource)
class ChatDataSourceImp implements ChatDataSource {
  final DioHelper _dioHelper;

  ChatDataSourceImp(this._dioHelper);

  @override
  Future<List<ApiChatMessageModel>> getMessages(GetChatMessagesParams params) async {
    try {
      final Map<String, dynamic> response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath(_getMessagesUrl(params.chatId)));
      final List messagesJson = response["data"]['chat']['messages'] ?? [];
      final List<ApiChatMessageModel> messages = messagesJson.map((e) => ApiChatMessageModel.fromJson(e)).toList();
      return messages;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiChatMessageModel> sendMessage(SendChatMessageParams params) async {
    try {
      final newDioObj = _dioHelper.copyWith(
        (options) => options
          ..connectTimeout = const Duration(minutes: 7)
          ..sendTimeout = const Duration(minutes: 7)
          ..receiveTimeout = const Duration(minutes: 7),
      );
      final Map<String, dynamic> response = await newDioObj.post(
        url: ApiConstants.addToApiUrlPath(params.getRequetUrl),
        body: await params.toMap,
      );
      return ApiChatMessageModel.fromJson(response["data"]["message"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<IChatDetailsEntity> getChatInformation(IChatPageInput params) async {
    try {
      final Map<String, dynamic> response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath(params.getChatDetailsApiRequestPath));
      return IChatDetailsEntity.fromJson(response["data"]['chat']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setMessagesAsRead(int chatId) async {
    try {
      await _dioHelper.get(url: "$_setMessagesAsReadUrl/$chatId");
    } catch (e) {
      rethrow;
    }
  }
}
