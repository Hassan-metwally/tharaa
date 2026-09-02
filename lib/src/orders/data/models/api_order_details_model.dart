import '../../../../core/core.dart';
import '../../../addresses/data/models/api_location_model.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/entities/order_details_entity.dart';
import 'api_order_item_model.dart';
import 'api_order_model.dart';

class ApiOrderDetailsModel extends ApiOrderModel {
  final String? description;
  final ApiLocationModel? address;
  final List<ApiOrderItemModel>? items;
  final String? paymentMethod;
  final num? productsPrice;
  final num? deliveryPrice;
  final num? vatAmount;
  final String? cancelReason;
  final DateTime? ratedAt;

  ApiOrderDetailsModel({
    required super.id,
    required super.name,
    required super.image,
    super.orderNumber,
    super.createdAt,
    super.total,
    super.status,
    required this.description,
    this.address,
    this.items,
    this.paymentMethod,
    this.productsPrice,
    this.deliveryPrice,
    this.vatAmount,
    this.cancelReason,
    this.ratedAt,
  });

  factory ApiOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    final dynamic itemsJson = json['items'] ?? json['products'];
    final List<ApiOrderItemModel>? parsedItems = itemsJson is List
        ? itemsJson.map((item) => ApiOrderItemModel.fromJson(item as Map<String, dynamic>)).toList()
        : null;

    final dynamic addressJson = json['address_snapshot'] ?? json['address'] ?? json['location'];

    return ApiOrderDetailsModel(
      id: json['id'],
      name: json['name']?.toString(),
      image: AttachmentEntity.fromNetwork(url: json['image']?.toString() ?? ''),
      orderNumber: (json['order_number'] ?? json['orderNumber'] ?? json['number'])?.toString(),
      createdAt: ApiOrderModel.parseOrderDate(json['created_at'] ?? json['createdAt'] ?? json['date']),
      total: ApiOrderModel.parseOrderNum(json['total'] ?? json['total_price'] ?? json['price']),
      status: (json['status'] ?? json['order_status'])?.toString(),
      description: json['description']?.toString(),
      address: addressJson is Map<String, dynamic> ? ApiLocationModel.fromJson(addressJson) : null,
      items: parsedItems,
      paymentMethod: (json['payment_method_trans'] ?? json['payment_method'] ?? json['paymentMethod'])?.toString(),
      productsPrice: ApiOrderModel.parseOrderNum(json['subtotal'] ?? json['products_price'] ?? json['productsPrice']),
      deliveryPrice: ApiOrderModel.parseOrderNum(json['delivery_fee'] ?? json['delivery_price'] ?? json['deliveryPrice']),
      vatAmount: ApiOrderModel.parseOrderNum(json['vat'] ?? json['tax_amount'] ?? json['vatAmount']),
      cancelReason: (json['cancel_reason'] ?? json['cancelReason'])?.toString(),
      ratedAt: ApiOrderModel.parseOrderDate(json['rated_at'] ?? json['ratedAt']),
    );
  }
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
      address: address?.map,
      items: items?.map((item) => item.map).toList() ?? const [],
      paymentMethod: paymentMethod ?? '',
      productsPrice: productsPrice ?? 0,
      deliveryPrice: deliveryPrice ?? 0,
      vatAmount: vatAmount ?? 0,
      cancelReason: cancelReason ?? '',
      ratedAt: ratedAt,
    );
  }
}
