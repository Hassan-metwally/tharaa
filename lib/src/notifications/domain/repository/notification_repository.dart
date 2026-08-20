import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/norification_entity.dart';
import '../use_cases/get_notifications_use_case.dart';
import '../use_cases/read_notification_usecase.dart';

abstract class NotificationRepository {
  Future<Either<Failure, PaginatedData<NotificationEntity>>> getNotifications(GetNotificationsParams params);
  Future<Either<Failure, Unit>> markAllNotificationAsRead();
  Future<Either<Failure, int>> getUnreadedNotificationsCount();
  Future<Either<Failure, Unit>> readNotification(ReadNotificationParams params);
}
