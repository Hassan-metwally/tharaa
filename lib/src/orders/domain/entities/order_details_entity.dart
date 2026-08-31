import '../../../../core/core.dart';
import '../../../addresses/domain/entities/location_entity.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import 'order_entity.dart';
import 'order_item_entity.dart';

class OrderDetailsEntity extends OrderEntity {
  final String description;
  final LocationEntity? address;
  final List<OrderItemEntity> items;
  final String paymentMethod;
  final num productsPrice;
  final num deliveryPrice;
  final num vatAmount;
  final String cancelReason;

  const OrderDetailsEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.orderNumber,
    required super.createdAt,
    required super.total,
    required super.status,
    required this.description,
    this.address,
    this.items = const [],
    this.paymentMethod = '',
    this.productsPrice = 0,
    this.deliveryPrice = 0,
    this.vatAmount = 0,
    this.cancelReason = '',
  });

  const OrderDetailsEntity.initial()
    : description = '',
      address = null,
      items = const [],
      paymentMethod = '',
      productsPrice = 0,
      deliveryPrice = 0,
      vatAmount = 0,
      cancelReason = '',
      super.initial();

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
    LocationEntity? address,
    List<OrderItemEntity>? items,
    String? paymentMethod,
    num? productsPrice,
    num? deliveryPrice,
    num? vatAmount,
    String? cancelReason,
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
      address: address ?? this.address,
      items: items ?? this.items,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      productsPrice: productsPrice ?? this.productsPrice,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      vatAmount: vatAmount ?? this.vatAmount,
      cancelReason: cancelReason ?? this.cancelReason,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([
    description,
    address,
    items,
    paymentMethod,
    productsPrice,
    deliveryPrice,
    vatAmount,
    cancelReason,
  ]);
}
