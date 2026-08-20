import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../domain/entities/norification_entity.dart';
import '../domain/use_cases/get_notifications_use_case.dart';
import '../domain/use_cases/get_unreaded_notifications_count_usecase.dart';
import '../domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import '../domain/use_cases/read_notification_usecase.dart';

part 'notifications_state.dart';

@Injectable()
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
    this._getNotificationsUseCase,
    this._markAllNotificationsAsReadUseCase,
    this._getUnreadNotificationsCountUseCase,
    this._readNotificationUseCase,
  ) : super(const NotificationsState.initial());

  static NotificationsCubit of(BuildContext context) => BlocProvider.of<NotificationsCubit>(context);

  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkAllNotificationsAsReadUseCase _markAllNotificationsAsReadUseCase;
  final GetUnreadedNotificationsCountUsecase _getUnreadNotificationsCountUseCase;
  final ReadNotificationUseCase _readNotificationUseCase;
  Future<void> getNotifications() async {
    emit(state.copyWith(currentPage: 1, getNotificationsState: const Async.loading()));
    final result = await _getNotificationsUseCase(state.params);
    result.fold(
      (failure) {
        emit(state.copyWith(getNotificationsState: Async.failure(failure)));
      },
      (right) {
        emit(state.copyWith(getNotificationsState: Async.success(right.items), lastPage: right.pageInfo.lastPage));
      },
    );
  }

  Future<void> getMoreNotifications() async {
    if (state.currentPage == state.lastPage) return;
    emit(
      state.copyWith(
        getNotificationsState: Async.paginationLoading(state.getNotificationsState.data ?? []),
        currentPage: state.currentPage + 1,
      ),
    );
    final result = await _getNotificationsUseCase(state.params);
    result.fold(
      (failure) {
        emit(state.copyWith(getNotificationsState: Async.failure(failure), currentPage: state.currentPage - 1));
      },
      (right) {
        emit(state.copyWith(getNotificationsState: Async.success([...state.getNotificationsState.data ?? [], ...right.items])));
      },
    );
  }

  Future<void> markAllNotificationAsRead() async {
    emit(state.copyWith(markAllNotificationsAsReadState: const Async.loading()));
    final result = await _markAllNotificationsAsReadUseCase(NoParams());
    result.fold(
      (left) {
        emit(state.copyWith(markAllNotificationsAsReadState: Async.failure(left)));
      },
      (_) {
        emit(
          state.copyWith(markAllNotificationsAsReadState: const Async.successWithoutData(), notificationsCountState: const Async.initial()),
        );
        emit(state.copyWith(markAllNotificationsAsReadState: const Async.initial()));
      },
    );
  }

  Future<void> readNotification(ReadNotificationParams params) async {
    emit(state.copyWith(readNotificationState: const Async.loading()));
    final result = await _readNotificationUseCase(params);
    result.fold(
      (left) {
        emit(state.copyWith(readNotificationState: Async.failure(left)));
      },
      (_) {
        emit(state.copyWith(readNotificationState: const Async.successWithoutData()));
      },
    );
  }

  Future<void> getUnreadedNotificationsCount() async {
    emit(state.copyWith(notificationsCountState: const Async.loading()));
    final result = await _getUnreadNotificationsCountUseCase(NoParams());
    result.fold(
      (left) {
        emit(state.copyWith(notificationsCountState: Async.failure(left)));
      },
      (right) {
        emit(state.copyWith(notificationsCountState: Async.success(right)));
      },
    );
  }
}
