part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final Async<List<NotificationEntity>> getNotificationsState;
  final Async<int> notificationsCountState;
  final Async<Unit> markAllNotificationsAsReadState;
  final Async<Unit> readNotificationState;
  final int currentPage;
  final int lastPage;

  const NotificationsState({
    required this.getNotificationsState,
    required this.notificationsCountState,
    required this.markAllNotificationsAsReadState,
    required this.currentPage,
    required this.lastPage,
    required this.readNotificationState,
  });

  const NotificationsState.initial()
    : this(
        getNotificationsState: const Async.initial(),
        notificationsCountState: const Async.initial(),
        markAllNotificationsAsReadState: const Async.initial(),
        readNotificationState: const Async.initial(),
        currentPage: 1,
        lastPage: 1,
      );

  NotificationsState copyWith({
    Async<List<NotificationEntity>>? getNotificationsState,
    Async<int>? notificationsCountState,
    Async<Unit>? markAllNotificationsAsReadState,
    Async<Unit>? readNotificationState,
    int? currentPage,
    int? lastPage,
  }) {
    return NotificationsState(
      getNotificationsState: getNotificationsState ?? this.getNotificationsState,
      notificationsCountState: notificationsCountState ?? this.notificationsCountState,
      markAllNotificationsAsReadState: markAllNotificationsAsReadState ?? this.markAllNotificationsAsReadState,
      readNotificationState: readNotificationState ?? this.readNotificationState,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  GetNotificationsParams get params => GetNotificationsParams(page: currentPage);

  @override
  List<Object?> get props => [
    getNotificationsState,
    notificationsCountState,
    markAllNotificationsAsReadState,
    readNotificationState,
    currentPage,
    lastPage,
  ];
}
