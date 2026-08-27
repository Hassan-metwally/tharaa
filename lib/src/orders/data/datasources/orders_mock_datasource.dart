import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/toggle_order_status_usecase.dart';
import '../models/api_order_details_model.dart';
import '../models/api_order_model.dart';
import 'orders_datasource.dart';

@Injectable(as: OrdersDatasource)
class OrdersMockDatasource extends OrdersDatasource {
  static const _delay = Duration(milliseconds: 400);

  static final List<ApiOrderDetailsModel> _orders = [
    ApiOrderDetailsModel(
      id: 10245,
      name: 'Order 10245',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10245',
      createdAt: DateTime(2026, 8, 16),
      total: 488,
      status: 'new',
      description: '',
    ),
    ApiOrderDetailsModel(
      id: 10246,
      name: 'Order 10246',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10246',
      createdAt: DateTime(2026, 8, 16),
      total: 488,
      status: 'in_progress',
      description: '',
    ),
    ApiOrderDetailsModel(
      id: 10247,
      name: 'Order 10247',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10247',
      createdAt: DateTime(2026, 8, 16),
      total: 488,
      status: 'ready_for_delivery',
      description: '',
    ),
    ApiOrderDetailsModel(
      id: 10248,
      name: 'Order 10248',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10248',
      createdAt: DateTime(2026, 8, 15),
      total: 256,
      status: 'on_the_way',
      description: '',
    ),
    ApiOrderDetailsModel(
      id: 10249,
      name: 'Order 10249',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10249',
      createdAt: DateTime(2026, 8, 14),
      total: 320,
      status: 'delivered',
      description: '',
    ),
    ApiOrderDetailsModel(
      id: 10250,
      name: 'Order 10250',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10250',
      createdAt: DateTime(2026, 8, 12),
      total: 150,
      status: 'cancelled',
      description: '',
    ),
  ];

  @override
  Future<ApiPaginatedData<ApiOrderModel>> getOrders(GetOrdersParams params) async {
    await Future<void>.delayed(_delay);
    Iterable<ApiOrderModel> items = _orders;
    if (params.status != null) {
      items = items.where((order) => OrderStatusEnum.fromJson(order.status ?? '') == params.status);
    }
    if (params.date != null) {
      items = items.where((order) {
        final DateTime? createdAt = order.createdAt;
        if (createdAt == null) return false;
        return createdAt.year == params.date!.year && createdAt.month == params.date!.month && createdAt.day == params.date!.day;
      });
    }
    final String query = params.search?.trim().toLowerCase() ?? '';
    if (query.isNotEmpty) {
      items = items.where((order) {
        final String number = (order.orderNumber ?? '').toLowerCase();
        final String id = (order.id ?? '').toString();
        return number.contains(query) || id.contains(query);
      });
    }
    return _paginate(items.toList(), params.page);
  }

  @override
  Future<ApiOrderDetailsModel> showOrderDetails(int id) async {
    await Future<void>.delayed(_delay);
    return _orders.firstWhere((order) => order.id == id, orElse: () => _orders.first);
  }

  @override
  Future<String> toggleOrderStatus(ToggleOrderStatusParams params) async {
    await Future<void>.delayed(_delay);
    return 'ok';
  }

  ApiPaginatedData<ApiOrderModel> _paginate(List<ApiOrderModel> items, int page) {
    const perPage = 10;
    final lastPage = items.isEmpty ? 1 : (items.length / perPage).ceil();
    final start = (page - 1) * perPage;
    final pagedItems = start >= items.length ? const <ApiOrderModel>[] : items.skip(start).take(perPage).toList();

    return ApiPaginatedData(
      items: pagedItems,
      pageInfo: PageInfo(currentPage: page, lastPage: lastPage, totalPages: lastPage, countPerPage: perPage, totalItemsCount: items.length),
    );
  }


  @override
  Future<ApiOrderModel> addOrder(UpsertOrderParams params) async {
    await Future<void>.delayed(_delay);
    return ApiOrderModel(
      id: 10251,
      name: 'Order 10251',
      image: const AttachmentEntity.empty(),
      orderNumber: '#ORD-10251',
    );
  }
}
