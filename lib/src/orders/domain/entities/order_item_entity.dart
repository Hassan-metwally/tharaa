import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

class OrderItemEntity extends Equatable {
  final int id;
  final String name;
  final AttachmentEntity image;
  final int quantity;
  final String unitLabel;
  final num price;

  const OrderItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.unitLabel,
    required this.price,
  });

  const OrderItemEntity.initial()
    : id = 0,
      name = '',
      image = const AttachmentEntity.empty(),
      quantity = 0,
      unitLabel = '',
      price = 0;

  @override
  List<Object?> get props => [id, name, image, quantity, unitLabel, price];
}
