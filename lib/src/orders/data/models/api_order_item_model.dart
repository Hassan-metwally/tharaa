import '../../../../core/core.dart';
import '../../domain/entities/order_item_entity.dart';

class ApiOrderItemModel {
  final int? id;
  final String? name;
  final AttachmentEntity? image;
  final int? quantity;
  final String? unitLabel;
  final num? price;

  ApiOrderItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.unitLabel,
    required this.price,
  });

  factory ApiOrderItemModel.fromJson(Map<String, dynamic> json) => ApiOrderItemModel(
    id: json['id'],
    name: json['name']?.toString(),
    image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
    quantity: json['quantity'] is int ? json['quantity'] as int : int.tryParse(json['quantity']?.toString() ?? ''),
    unitLabel: (json['unit_label'] ?? json['unitLabel'] ?? json['unit'])?.toString(),
    price: _parseNum(json['price'] ?? json['unit_price'] ?? json['unitPrice']),
  );

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}

extension ApiOrderItemModelExt on ApiOrderItemModel {
  OrderItemEntity get map => OrderItemEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? const AttachmentEntity.empty(),
    quantity: quantity ?? 0,
    unitLabel: unitLabel ?? '',
    price: price ?? 0,
  );
}
