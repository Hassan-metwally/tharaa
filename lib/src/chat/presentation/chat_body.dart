import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../material/app_fail_widget.dart';
import '../../../material/media/app_image.dart';
import '../domain/entities/message_auther.dart';
import '../utils/chat_decoration_constants.dart';
import 'chat_cubit.dart';
import 'message_handler/chat_message_handler.dart';
import 'widgets/messages_loading_widget.dart';

class ChatBodyWidget extends StatelessWidget {
  const ChatBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatCubit, ChatState, Async<List<ChatMessageHandler>>>(
      selector: (state) {
        return state.getMessagesState;
      },
      builder: (context, state) {
        final List<ChatMessageHandler> messagesList = state.data ?? [];
        if (state.isSuccess && messagesList.isNotEmpty) {
          final sortedMessages = messagesList..sort((a, b) => a.message.createdAt.compareTo(b.message.createdAt));
          return ListView.separated(
            reverse: true,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
            physics: const ClampingScrollPhysics(),
            itemCount: sortedMessages.length,
            itemBuilder: (context, index) {
              final message = sortedMessages[sortedMessages.length - 1 - index];
              final previousMessage = index < sortedMessages.length - 1 ? sortedMessages[sortedMessages.length - 2 - index] : null;
              final nextMessage = index > 0 ? sortedMessages[sortedMessages.length - index] : null;
              return _MessageTile(message: message, nextMessage: nextMessage, previousMessage: previousMessage);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
        } else if (state.isLoading) {
          return const MessagesLoadingWidget();
        } else if (state.isFailure) {
          return AppFailWidget(
            onRetry: () {
              ChatCubit.of(context).getMessages();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _MessageTile extends StatelessWidget {
  final ChatMessageHandler message;
  final ChatMessageHandler? nextMessage;
  final ChatMessageHandler? previousMessage;

  const _MessageTile({required this.message, this.nextMessage, this.previousMessage});

  @override
  Widget build(BuildContext context) {
    final showDateTile = _shouldShowDateTile();
    final showTimestamp = _shouldShowTimestamp();
    final bool isMine = message.message.isMine;

    final crossAxisAlignment = !isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return Column(
      spacing: 4,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (showDateTile) _buildDateTile(message.message.createdAt),
        _BuilUserTile(user: message.message.author, isMine: isMine),
        message.getMessageWidget(),
        if (showTimestamp)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              message.message.createdAt.toHHMMa,
              textAlign: TextAlign.start,
              style: TextStyles.regular8.copyWith(
                // color: AppColors.text1,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  bool _shouldShowDateTile() {
    if (previousMessage == null) return true; // First message of a day
    final currentDate = DateTime(message.message.createdAt.year, message.message.createdAt.month, message.message.createdAt.day);
    final previousDate = DateTime(
      previousMessage!.message.createdAt.year,
      previousMessage!.message.createdAt.month,
      previousMessage!.message.createdAt.day,
    );
    return currentDate != previousDate; // Show date tile if dates differ
  }

  bool _shouldShowTimestamp() {
    // final samePreviosusSender =
    //     previousMessage?.message.isMine == message.message.isMine;
    // final sameNextSender =
    //     nextMessage?.message.isMine == message.message.isMine;
    // if (!sameNextSender) return true;
    // if (nextMessage == null) return true;
    // if (previousMessage == null) return true;
    // final timeDiff = message.message.createdAt
    //     .difference(previousMessage!.message.createdAt)
    //     .inMinutes
    //     .abs();
    // return timeDiff > 2 && !samePreviosusSender;
    return true;
  }

  Widget _buildDateTile(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: AppColors.black.withAlpha(8), blurRadius: 4, offset: Offset(0, 1))],
          ),
          child: Text(_formatDateForTile(date), style: TextStyles.medium8.copyWith(color: AppColors.black700)),
        ),
      ),
    );
  }

  String _formatDateForTile(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return appLocalizer.today;
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return appLocalizer.yesterday;
    } else {
      return date.DMYHMA;
    }
  }
}

class _BuilUserTile extends StatelessWidget {
  const _BuilUserTile({required this.user, required this.isMine});

  final MessageAuthor user;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      AppImage.circle(dimension: 16, path: user.avatar),
      Flexible(
        child: Text(
          user.name.split(' ').firstOrNull ?? '',
          maxLines: 1,
          overflow: TextOverflow.fade,
          // style: TextStyles.medium10.copyWith(color: AppColors.text1),
        ),
      ),
    ];
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ChatDecorationConstants.getMaxCellWidth(context)),
      child: Row(
        // mainAxisAlignment:
        //     !isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: isMine ? children : children.reversed.toList(),
      ),
    );
  }
}
