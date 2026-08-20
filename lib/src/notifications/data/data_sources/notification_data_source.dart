import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/read_notification_usecase.dart';
import '../models/api_notification_model.dart';

String get _getNotifications => ApiConstants.addToApiUrlPath('notifications');
String get _markAllNotificationAsRead => ApiConstants.addToApiUrlPath('notifications/mark-as-read');
String get _getUnreadNotificationsCount => ApiConstants.addToApiUrlPath('notifications/unread-count');
String get _readNotification => ApiConstants.addToApiUrlPath('/notifications/:notification/mark-as-read');

abstract class NotificationDataSource {
  Future<ApiPaginatedData<ApiNotificationModel>> getNotifications(GetNotificationsParams params);
  Future<Unit> markAllNotificationAsRead();
  Future<int> getUnreadNotificationsCount();
  Future<Unit> readNotification(ReadNotificationParams params);
}

@Injectable(as: NotificationDataSource)
class NotificationDataSourceImp implements NotificationDataSource {
  final DioHelper _dioHelper;
  NotificationDataSourceImp(this._dioHelper);
  @override
  Future<ApiPaginatedData<ApiNotificationModel>> getNotifications(GetNotificationsParams params) async {
    try {
      final response = await _dioHelper.get(url: _getNotifications, queryParameters: params.toJson());

      return ApiPaginatedData.fromJson(response['data'], getData: (data) => data.map((e) => ApiNotificationModel.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> markAllNotificationAsRead() async {
    try {
      await _dioHelper.post(url: _markAllNotificationAsRead);
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    try {
      final result = await _dioHelper.get(url: _getUnreadNotificationsCount);
      return result['data']['unread_count'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> readNotification(ReadNotificationParams params) async {
    try {
      await _dioHelper.post(url: _readNotification.replaceFirst(':notification', params.id));
      return unit;
    } catch (e) {
      rethrow;
    }
  }
}
