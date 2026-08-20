import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../chat_message_handler.dart';

class TextMessageCell extends StatelessWidget {
  final ChatMessageEntity message;
  final ChatMessageCallback? onLongPressed;
  final ChatMessageCallback? onPress;

  const TextMessageCell({super.key, required this.message, required this.onLongPressed, required this.onPress});

  TextStyle get _textStyle {
    return TextStyles.regular12;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (onLongPressed != null) {
          onLongPressed!(message);
        }
      },
      onTap: () {
        if (onPress != null) {
          onPress!(message);
        }
      },
      child: Text(message.messageText, style: _textStyle, textAlign: !message.isMine ? TextAlign.end : TextAlign.start),
    );
  }
}
