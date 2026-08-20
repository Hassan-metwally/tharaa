import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/pusher/pusher_handler.dart';
import '../data/models/api_chat_message_model.dart';
import '../domain/entities/chat_information_entity.dart';
import '../domain/entities/chat_page_input.dart';
import '../domain/entities/message_auther.dart';
import '../domain/mapper/map_message_to_handler.dart';
import '../domain/use_cases/get_chat_information_use_case.dart';
import '../domain/use_cases/get_chat_messages_use_case.dart';
import '../domain/use_cases/send_chat_message_use_case.dart';
import 'message_handler/chat_message_handler.dart';

part "chat_state.dart";

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.input) : super(const ChatState.initial());

  final IChatPageInput input;

  static ChatCubit of(BuildContext context) => BlocProvider.of<ChatCubit>(context);

  int get _orderId => input.orderId;
  int? _chatId;

  final GetChatMessagesUseCase _getChatMessagesUseCase = injector();
  final GetChatInformationUseCase _getChatInformationUseCase = injector();
  final SendChatMessageUseCase _sendChatMessageUseCase = injector();

  /// Get Chat Required Data
  ///
  void getChatInfo() async {
    emit(state.copyWith(chatInfoState: const Async.loading()));
    final Either<Failure, IChatDetailsEntity> result;
    result = await _getChatInformationUseCase(input);
    result.fold(
      (failer) {
        emit(state.copyWith(chatInfoState: Async.failure(failer)));
      },
      (data) {
        _chatId = data.id;
        _newMessageChannelName = "presence-chat.${_chatId ?? 0}";
        _subscripeNewMessageChannel();
        emit(state.copyWith(chatInfoState: Async.success(data)));
        // _setAllMessagesAsRead();
      },
    );
  }

  void getMessages() async {
    emit(state.copyWith(getMessagesState: const Async.loading()));

    final result = await _getChatMessagesUseCase(GetChatMessagesParams(chatId: _orderId, pageKey: 1));

    result.fold(
      (failer) {
        emit(state.copyWith(getMessagesState: Async.failure(failer)));
      },
      (data) {
        final List<ChatMessageHandler> newData = data.map<ChatMessageHandler>((data) => data.mapIntoHandler()).toList();
        emit(state.copyWith(getMessagesState: Async.success(newData)));
      },
    );
  }

  /// Manage Send Messages and
  ///
  void sendMessage({required final String messageText, required final List<AttachmentEntity> media}) async {
    emit(state.copyWith(sendMessageState: const Async.loading()));
    final input = SendChatMessageParams(
      chatId: _chatId ?? 0,
      message: messageText,
      media: media.map((e) => e.path).toList(),
      input: this.input,
    );
    // final message = input.toMessage();
    final result = await _sendChatMessageUseCase(input);

    result.fold(
      (failure) {
        emit(state.copyWith(sendMessageState: Async.failure(failure)));
      },
      (sentMessage) {
        final msg = sentMessage.mapIntoHandler();
        emit(state.copyWith(sendMessageState: Async.success(msg)));
        _addNewMessage(sentMessage.mapIntoHandler());
      },
    );

    emit(state.copyWith(sendMessageState: const Async.initial()));
  }

  void _addNewMessage(ChatMessageHandler message) {
    final messagesList = List<ChatMessageHandler>.from(state.getMessagesState.data ?? []);
    messagesList.insert(0, message);
    emit(state.copyWith(getMessagesState: Async.success(messagesList)));
  }

  /// Manage Pusher Stream
  ///

  String? _newMessageChannelName;
  final String _newMessageEventName = "chat.message";
  void _subscripeNewMessageChannel() {
    PusherHandler.subscribeToChannel(
      channelName: _newMessageChannelName ?? '',
      onEvent: (event) {
        final dynamic response = event.data;
        final eventName = event.eventName;
        if (response != null && response != {} && response != "" && eventName == _newMessageEventName) {
          final Map<String, dynamic> json = jsonDecode(response);
          final data = json['message'];
          final message = ApiChatMessageModel.fromJson(data);
          if (message.author?.id == state.chatInfoState.data?.currentUser.id) {
            return;
          }
          _addNewMessage(message.map.mapIntoHandler());
        }
      },
    );
  }

  void _unSubscripeNewMessageChannel() {
    PusherHandler.unsubscribeFromChannel(_newMessageChannelName ?? '');
  }

  @override
  void emit(ChatState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  @override
  Future<void> close() {
    _unSubscripeNewMessageChannel();
    return super.close();
  }
}
