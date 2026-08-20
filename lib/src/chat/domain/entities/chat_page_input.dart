sealed class IChatPageInput {
  const IChatPageInput();
  abstract final int currentUserId;

  abstract final int orderId;
  abstract final int? chatId;

  String get getPageRouteName;

  String get getChatDetailsApiRequestPath;

  String get getSendMessageApiRequestPath;

  bool get getCanSendAttachments;

  Map<String, dynamic> get toMap;
}

class ChatPageHelpRequestInput implements IChatPageInput {
  @override
  final int currentUserId;

  @override
  final int orderId;

  @override
  final int? chatId;

  const ChatPageHelpRequestInput({required this.currentUserId, required this.orderId, this.chatId});

  @override
  String get getPageRouteName => "HelpRequestChatPage/$orderId";

  @override
  String get getChatDetailsApiRequestPath => "chat/$orderId/show";

  @override
  bool get getCanSendAttachments => true;

  @override
  String get getSendMessageApiRequestPath => 'chat/send-message';

  @override
  Map<String, dynamic> get toMap => {"user_id": orderId};
}
