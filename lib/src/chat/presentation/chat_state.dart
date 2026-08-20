part of "chat_cubit.dart";

class ChatState extends Equatable {
  final String? errorMessage;

  final Async<IChatDetailsEntity> chatInfoState;

  /// [getMessagesState] Used To Get Chat Sent Messages
  final Async<List<ChatMessageHandler>> getMessagesState;

  final Async<ChatMessageHandler> sendMessageState;

  /// This State To Add Un Send Message To Chat List Until Sent And Response Come From Server
  final Async<ChatMessageHandler> addUnSendMessgaeState;

  Async<MessageAuthor> get currentUser {
    if (chatInfoState.isSuccess) {
      return Async.success(chatInfoState.data!.currentUser);
    } else if (chatInfoState.isFailure) {
      return Async.failure(chatInfoState.failure!);
    } else if (chatInfoState.isLoading) {
      return const Async.loading();
    }
    return const Async.initial();
  }

  const ChatState({
    required this.errorMessage,
    required this.chatInfoState,
    required this.getMessagesState,
    required this.sendMessageState,
    required this.addUnSendMessgaeState,
  });

  const ChatState.initial()
    : this(
        errorMessage: null,
        chatInfoState: const Async.initial(),
        getMessagesState: const Async.initial(),
        sendMessageState: const Async.initial(),
        addUnSendMessgaeState: const Async.initial(),
      );

  ChatState copyWith({
    final String? errorMessage,
    final Async<IChatDetailsEntity>? chatInfoState,
    final Async<List<ChatMessageHandler>>? getMessagesState,
    final Async<ChatMessageHandler>? sendMessageState,
    final Async<ChatMessageHandler>? addUnSendMessgaeState,
  }) {
    return ChatState(
      errorMessage: errorMessage,
      chatInfoState: chatInfoState ?? this.chatInfoState,
      addUnSendMessgaeState: addUnSendMessgaeState ?? this.addUnSendMessgaeState,
      sendMessageState: sendMessageState ?? this.sendMessageState,
      getMessagesState: getMessagesState ?? this.getMessagesState,
    );
  }

  @override
  List<Object?> get props => [chatInfoState, getMessagesState, addUnSendMessgaeState, sendMessageState, errorMessage];
}
