part of 'chats_inbox_cubit.dart';

class ChatsLogState extends Equatable {
  final Async<List<ChatsInboxEntity>> getChatsLogState;
  final int currentPage;
  final int lastPage;

  const ChatsLogState({this.getChatsLogState = const Async.initial(), this.currentPage = 1, this.lastPage = 1});

  const ChatsLogState.initial() : this(getChatsLogState: const Async.initial(), currentPage: 1, lastPage: 1);

  ChatsLogState copyWith({Async<List<ChatsInboxEntity>>? getChatsLogState, int? currentPage, int? lastPage}) {
    return ChatsLogState(
      getChatsLogState: getChatsLogState ?? this.getChatsLogState,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getChatsLogState, currentPage, lastPage];
}
