import '../../presentation/message_handler/chat_message_handler.dart';
import '../../presentation/message_handler/other/other_media_message_handler.dart';
import '../../presentation/message_handler/other/other_text_message_handler.dart';
import '../../presentation/message_handler/owner/owner_media_message_handler.dart';
import '../../presentation/message_handler/owner/owner_text_message_handler.dart';
import '../entities/chat_message_entity.dart';

extension ChatMessageHandlerMapper on ChatMessageEntity {
  bool _isOwnerMessage() {
    return isMine;
  }

  ChatMessageHandler mapIntoHandler() {
    final bool hasAttachments = attachments.isNotEmpty;
    if (_isOwnerMessage()) {
      if (hasAttachments) {
        return OwnerMediaMessageHandler(message: this);
      } else {
        return _ownerMessageHandler();
      }
    } else {
      if (hasAttachments) {
        return OtherMediaMessageHandler(message: this);
      } else {
        return _otherMessageHandler();
      }
    }
  }

  ChatMessageHandler _ownerMessageHandler() {
    return OwnerTextMessageHandler(message: this);
  }

  ChatMessageHandler _otherMessageHandler() {
    return OtherTextMessageHandler(message: this);
  }
}
