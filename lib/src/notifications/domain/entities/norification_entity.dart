import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

// contact_us
// user
// provider
// settlement_request
// wallet
// chat
// service_order
// product_order
// product

enum NotificationType {
  contact("contact_us"),
  user("user"),
  provider("provider"),
  settlementRequest("settlement_request"),
  wallet("wallet"),
  chat('chat'),
  serviceOrder("service_order"),
  productOrder("product_order"),
  product("product"),
  adminNotification("admin_notification"),
  role("role"),
  subscription("subscription"),
  rate("rate"),
  unkown("");

  final String json;

  const NotificationType(this.json);

  factory NotificationType.fromJson(String json) =>
      NotificationType.values.firstWhereOrNull((element) => element.json == json) ?? NotificationType.unkown;

  String get icon {
    switch (this) {
      case NotificationType.contact:
        return 'AppIcons.bell3';
      case NotificationType.adminNotification:
        return 'AppIcons.logo';
      case NotificationType.wallet:
        return 'AppIcons.done';
      case NotificationType.role:
        return 'AppIcons.bell3';
      case NotificationType.provider:
        return 'AppIcons.bell3';
      case NotificationType.user:
        return 'AppIcons.bell3';
      case NotificationType.unkown:
        return 'AppIcons.bell3';
      case NotificationType.subscription:
        return 'AppIcons.done';
      case NotificationType.serviceOrder:
        return 'AppIcons.bell3';
      case NotificationType.productOrder:
        return 'AppIcons.bell3';
      case NotificationType.rate:
        return 'AppIcons.bell3';
      case NotificationType.settlementRequest:
        return 'AppIcons.bell3';
      case NotificationType.chat:
        return 'AppIcons.bell3';
      case NotificationType.product:
        return 'AppIcons.bell3';
    }
  }
}

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final NotificationType type;
  final String body;
  final String createdAt;
  final bool isRead;
  final int redirectionId;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.body,
    required this.createdAt,
    required this.redirectionId,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? title,
    NotificationType? type,
    String? body,
    String? createdAt,
    NotificationType? notificationType,
    int? redirectionId,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      redirectionId: redirectionId ?? this.redirectionId,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, title, body, createdAt, redirectionId, isRead, type];
}
