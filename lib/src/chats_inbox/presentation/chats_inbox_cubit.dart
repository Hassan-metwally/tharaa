// ignore_for_file: strict_top_level_inference, always_declare_return_types

import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../core/core.dart';
import '../../../core/utils/pusher/pusher_handler.dart';
import '../data/models/api_chats_inbox_model.dart';
import '../domain/entities/chats_inbox_entity.dart';
import '../domain/usecases/get_chats_inbox_usecase.dart';

part 'chats_inbox_state.dart';

@Injectable()
class ChatsLogCubit extends Cubit<ChatsLogState> {
  final GetChatsInboxUsecase getChatsInboxUsecase;
  ChatsLogCubit(this.getChatsInboxUsecase) : super(const ChatsLogState.initial());

  late int chatID;

  Future<void> getChatLogs() async {
    emit(state.copyWith(currentPage: 1, getChatsLogState: const Async.loading()));
    final result = await getChatsInboxUsecase(GetChatLogsParams(page: state.currentPage));
    result.fold(
      (error) {
        emit(state.copyWith(getChatsLogState: Async.failure(error)));
      },
      (data) {
        emit(state.copyWith(getChatsLogState: Async.success(data.items), lastPage: data.pageInfo.lastPage));
      },
    );
  }

  Future<void> getMoreChatsLog() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
    final result = await getChatsInboxUsecase(GetChatLogsParams(page: state.currentPage));
    result.fold(
      (error) {
        emit(state.copyWith(getChatsLogState: Async.failure(error), currentPage: state.currentPage - 1));
      },
      (data) {
        emit(state.copyWith(getChatsLogState: Async.success([...state.getChatsLogState.data ?? [], ...data.items])));
      },
    );
  }

  resetUnreadCount(int index) {
    final List<ChatsInboxEntity> chats = List.from(state.getChatsLogState.data ?? []);
    chats[index] = chats[index].copyWith(unreadCount: 0);
    emit(state.copyWith(getChatsLogState: Async.success(chats)));
  }

  PusherChannel? pusherChannel;

  void subscribeToChatChannel({required String userId}) async {
    try {
      // chatID = userId;
      await PusherHandler.unsubscribeFromChannel('inbox.$userId');
      // Subscribe to the channel
      pusherChannel = await PusherHandler.subscribeToChannel(
        channelName: 'inbox.$userId',
        onSubscriptionError: (e) {
          log('Subscription error: $e');
        },
        onSubscriptionSucceeded: (d) {
          log('Subscription succeeded: $d');
        },
        onEvent: onEvent,
      );
    } catch (e) {
      log('ERROR connecting to chat channel: $e');
    }
  }

  Future<void> onEvent(dynamic event) async {
    if (event == null) return;
    try {
      if (event.eventName == 'inbox.updated') {
        final jsonData = json.decode(event.data);
        final newChat = ApiChatInboxModel.fromJson(jsonData['chat']);
        final List<ChatsInboxEntity> chats = List<ChatsInboxEntity>.from(state.getChatsLogState.data ?? []);

        final existingIndex = chats.indexWhere((chat) => chat.id == newChat.id);

        if (existingIndex != -1) {
          chats.removeAt(existingIndex);
        }

        chats.insert(0, newChat.map);
        emit(state.copyWith(getChatsLogState: Async.success(chats)));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void emit(ChatsLogState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
