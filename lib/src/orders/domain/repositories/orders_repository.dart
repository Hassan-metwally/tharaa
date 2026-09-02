import '../../../../../../core/core.dart';

import '../entities/checkout_preview_entity.dart';
import '../entities/order_details_entity.dart';
import '../entities/order_entity.dart';
import '../usecases/add_order_usecase.dart';
import '../usecases/apply_checkout_coupon_usecase.dart';
import '../usecases/get_orders_usecase.dart';
import '../usecases/preview_checkout_usecase.dart';
import '../usecases/toggle_order_status_usecase.dart';

abstract class OrdersRepository {
  DomainServiceType<OrderDetailsEntity> showOrderDetails(int id);

  DomainServiceType<PaginatedData<OrderEntity>> getOrders(GetOrdersParams params);

  DomainServiceType<String> toggleOrderStatus(ToggleOrderStatusParams params);

  DomainServiceType<CheckoutPreviewEntity> previewCheckout(PreviewCheckoutParams params);

  DomainServiceType<CheckoutPreviewEntity> applyCheckoutCoupon(ApplyCheckoutCouponParams params);

  DomainServiceType<OrderEntity> addOrder(UpsertOrderParams params);
}
