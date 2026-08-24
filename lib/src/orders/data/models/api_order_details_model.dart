import '../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/entities/order_details_entity.dart';
import 'api_order_model.dart';

class ApiOrderDetailsModel extends ApiOrderModel {
  final String? description;

  ApiOrderDetailsModel({
    required super.id,
    required super.name,
    required super.image,
    super.orderNumber,
    super.createdAt,
    super.total,
    super.status,
    required this.description,
  });

  factory ApiOrderDetailsModel.fromJson(Map<String, dynamic> json) => ApiOrderDetailsModel(
    id: json['id'],
    name: json['name']?.toString(),
    image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
    orderNumber: (json['order_number'] ?? json['orderNumber'] ?? json['number'])?.toString(),
    createdAt: ApiOrderModel.parseOrderDate(json['created_at'] ?? json['createdAt'] ?? json['date']),
    total: ApiOrderModel.parseOrderNum(json['total'] ?? json['total_price'] ?? json['price']),
    status: (json['status'] ?? json['order_status'])?.toString(),
    description: json['description']?.toString(),
  );
}

extension ApiOrderDetailsEXT on ApiOrderDetailsModel {
  OrderDetailsEntity get map {
    final int mappedId = id ?? 0;
    final String mappedNumber = orderNumber?.trim() ?? '';
    return OrderDetailsEntity(
      id: mappedId,
      name: name ?? '',
      image: image ?? const AttachmentEntity.empty(),
      orderNumber: mappedNumber.isNotEmpty ? mappedNumber : '#ORD-$mappedId',
      createdAt: createdAt,
      total: total ?? 0,
      status: OrderStatusEnum.fromJson(status ?? ''),
      description: description ?? '',
    );
  }
}
