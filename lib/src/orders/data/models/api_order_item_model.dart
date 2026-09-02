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
    name: (json['product_name'] ?? json['name'] ?? json['product_name_en'])?.toString(),
    image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
    quantity: json['quantity'] is int ? json['quantity'] as int : int.tryParse(json['quantity']?.toString() ?? ''),
    unitLabel: _parseUnitLabel(json),
    price: _parseNum(json['line_total'] ?? json['price'] ?? json['unit_price'] ?? json['unitPrice'] ?? json['offer_price']),
  );

  static String? _parseUnitLabel(Map<String, dynamic> json) {
    final dynamic existing = json['unit_label'] ?? json['unitLabel'] ?? json['unit'];
    if (existing != null && existing.toString().trim().isNotEmpty) {
      return existing.toString();
    }

    final num? unitsCount = _parseNum(json['units_count']);
    final num? unitWeight = _parseNum(json['unit_weight']);
    final String unitType = json['unit_type']?.toString() ?? '';

    final String weight = unitWeight == null ? '' : unitWeight.toStringAsFixed(3);
    final String weightAndUnit = [if (weight.isNotEmpty) weight, if (unitType.isNotEmpty) unitType].join(' ');
    if (unitsCount != null && weightAndUnit.isNotEmpty) {
      return '${unitsCount.toInt()}*$weightAndUnit';
    }
    return weightAndUnit.isEmpty ? null : weightAndUnit;
  }

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
