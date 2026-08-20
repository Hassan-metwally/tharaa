import 'package:flutter/widgets.dart';

import '../../domain/entities/chat_message_entity.dart';

typedef ChatMessageCallback = void Function(ChatMessageEntity message);

abstract class ChatMessageHandler {
  abstract final ChatMessageEntity message;

  Widget getMessageWidget({ChatMessageCallback? onLongPressed, ChatMessageCallback? onPressed});
}

abstract class OwnerChatMessageHandler implements ChatMessageHandler {
  OwnerChatMessageHandler modify(ChatMessageEntity message);
}
