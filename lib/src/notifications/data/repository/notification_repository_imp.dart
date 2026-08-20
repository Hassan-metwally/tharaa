import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/norification_entity.dart';
import '../../domain/repository/notification_repository.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/read_notification_usecase.dart';
import '../data_sources/notification_data_source.dart';
import '../models/api_notification_model.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImp implements NotificationRepository {
  final NotificationDataSource _notificationDataSource;

  NotificationRepositoryImp(this._notificationDataSource);

  @override
  Future<Either<Failure, PaginatedData<NotificationEntity>>> getNotifications(GetNotificationsParams params) => failureCollect(() async {
    final result = await _notificationDataSource.getNotifications(params);
    return Right(result.map((e) => e.map));
  });

  @override
  Future<Either<Failure, Unit>> markAllNotificationAsRead() => failureCollect(() async {
    final result = await _notificationDataSource.markAllNotificationAsRead();
    return Right(result);
  });

  @override
  Future<Either<Failure, int>> getUnreadedNotificationsCount() => failureCollect(() async {
    final result = await _notificationDataSource.getUnreadNotificationsCount();
    return Right(result);
  });

  @override
  Future<Either<Failure, Unit>> readNotification(ReadNotificationParams params) => failureCollect(() async {
    final result = await _notificationDataSource.readNotification(params);
    return Right(result);
  });
}
