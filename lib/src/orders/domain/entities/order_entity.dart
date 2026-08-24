import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';

class OrderEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;
  final String orderNumber;
  final DateTime? createdAt;
  final num total;
  final OrderStatusEnum status;

  const OrderEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.orderNumber,
    required this.createdAt,
    required this.total,
    required this.status,
  });

  const OrderEntity.initial()
    : id = 0,
      name = '',
      image = const AttachmentEntity.empty(),
      orderNumber = '',
      createdAt = null,
      total = 0,
      status = OrderStatusEnum.neww;

  OrderEntity copyWith({
    int? id,
    String? name,
    AttachmentEntity? image,
    String? orderNumber,
    DateTime? createdAt,
    num? total,
    OrderStatusEnum? status,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      orderNumber: orderNumber ?? this.orderNumber,
      createdAt: createdAt ?? this.createdAt,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name, image, orderNumber, createdAt, total, status];
}
