import '../../../../../../core/core.dart';

import '../entities/order_details_entity.dart';

import '../entities/order_entity.dart';

import '../usecases/add_order_usecase.dart';
import '../usecases/get_orders_usecase.dart';

import '../usecases/toggle_order_status_usecase.dart';

abstract class OrdersRepository {
  DomainServiceType<OrderDetailsEntity> showOrderDetails(int id);

  DomainServiceType<PaginatedData<OrderEntity>> getOrders(GetOrdersParams params);

  DomainServiceType<String> toggleOrderStatus(ToggleOrderStatusParams params);
  
  DomainServiceType<OrderEntity> addOrder(UpsertOrderParams params);

}
