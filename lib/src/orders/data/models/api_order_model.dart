import '../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/entities/order_entity.dart';

class ApiOrderModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;
  final String? orderNumber;
  final DateTime? createdAt;
  final num? total;
  final String? status;

  ApiOrderModel({required this.id, required this.name, required this.image, this.orderNumber, this.createdAt, this.total, this.status});

  factory ApiOrderModel.fromJson(Map<String, dynamic> json) => ApiOrderModel(
    id: json['id'],
    name: json['name']?.toString(),
    image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
    orderNumber: _parseOrderNumber(json),
    createdAt: parseOrderDate(json['created_at'] ?? json['createdAt'] ?? json['date']),
    total: parseOrderNum(json['total'] ?? json['total_price'] ?? json['price']),
    status: (json['status'] ?? json['order_status'])?.toString(),
  );

  static String? _parseOrderNumber(Map<String, dynamic> json) {
    final dynamic value = json['order_number'] ?? json['orderNumber'] ?? json['number'];
    if (value == null) return null;
    final String text = value.toString();
    return text.isEmpty ? null : text;
  }

  static DateTime? parseOrderDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static num? parseOrderNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}

extension ApiOrderEXT on ApiOrderModel {
  OrderEntity get map {
    final int mappedId = id ?? 0;
    final String mappedNumber = orderNumber?.trim() ?? '';
    return OrderEntity(
      id: mappedId,
      name: name ?? '',
      image: image ?? const AttachmentEntity.empty(),
      orderNumber: mappedNumber.isNotEmpty ? mappedNumber : '#ORD-$mappedId',
      createdAt: createdAt,
      total: total ?? 0,
      status: OrderStatusEnum.fromJson(status ?? ''),
    );
  }
}
