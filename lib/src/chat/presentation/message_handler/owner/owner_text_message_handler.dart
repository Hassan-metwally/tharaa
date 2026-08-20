import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../utils/chat_decoration_constants.dart';
import '../cells/text_message_cell.dart';
import '../chat_message_handler.dart';

class OwnerTextMessageHandler extends Equatable implements OwnerChatMessageHandler {
  @override
  final ChatMessageEntity message;
  const OwnerTextMessageHandler({required this.message});

  @override
  OwnerTextMessageHandler modify(ChatMessageEntity message) {
    return OwnerTextMessageHandler(message: message);
  }

  @override
  Widget getMessageWidget({ChatMessageCallback? onLongPressed, ChatMessageCallback? onPressed}) {
    final context = appNavigatorKey.currentContext;

    if (context == null || context.mounted == false) {
      return const SizedBox();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            decoration: ChatDecorationConstants.ownerCellDecoration,
            padding: ChatDecorationConstants.cellPadding,
            margin: ChatDecorationConstants.cellMargin,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            constraints: BoxConstraints(
              minWidth: ChatDecorationConstants.getMinCellWidth,
              maxWidth: ChatDecorationConstants.getMaxCellWidth(context),
            ),
            child: TextMessageCell(message: message, onLongPressed: onLongPressed, onPress: onPressed),
          ),
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [message];
}
