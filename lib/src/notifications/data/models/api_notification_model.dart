import '../../domain/entities/norification_entity.dart';

class ApiNotificationModel {
  final String? id;
  final String? title;
  final String? body;
  final bool? isRead;
  final String? createdAt;
  final String? notificationType;
  final int? redirectionId;
  final NotificationType? type;

  const ApiNotificationModel({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.notificationType,
    this.redirectionId,
    this.type,
  });

  factory ApiNotificationModel.fromJson(Map<String, dynamic> json) => ApiNotificationModel(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    isRead: json["is_read"],
    notificationType: json["type"],
    redirectionId: json["redirect_id"] ?? 0,
    createdAt: json["created_at"],
    type: NotificationType.fromJson(json["type"] ?? ''),
  );
}

extension ApiNotificationModelExt on ApiNotificationModel {
  NotificationEntity get map => NotificationEntity(
    id: id ?? "",
    title: title ?? "",
    body: body ?? "",
    createdAt: createdAt ?? "",
    redirectionId: redirectionId ?? 0,
    isRead: isRead ?? false,
    type: type ?? NotificationType.unkown,
  );
}
