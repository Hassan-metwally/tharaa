import '../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import 'order_entity.dart';

class OrderDetailsEntity extends OrderEntity {
  final String description;

  const OrderDetailsEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.orderNumber,
    required super.createdAt,
    required super.total,
    required super.status,
    required this.description,
  });

  const OrderDetailsEntity.initial() : description = '', super.initial();

  @override
  OrderDetailsEntity copyWith({
    String? description,
    AttachmentEntity? image,
    String? name,
    int? id,
    String? orderNumber,
    DateTime? createdAt,
    num? total,
    OrderStatusEnum? status,
  }) {
    return OrderDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      orderNumber: orderNumber ?? this.orderNumber,
      createdAt: createdAt ?? this.createdAt,
      total: total ?? this.total,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([description]);
}
