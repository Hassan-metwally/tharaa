import '../../../../../../core/core.dart';
import '../../../addresses/data/models/api_location_model.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/toggle_order_status_usecase.dart';
import '../models/api_order_details_model.dart';
import '../models/api_order_item_model.dart';
import '../models/api_order_model.dart';
import 'orders_datasource.dart';

// @Injectable(as: OrdersDatasource)
class OrdersMockDatasource extends OrdersDatasource {
  static const _delay = Duration(milliseconds: 400);

  static final ApiLocationModel _riyadhAddress = ApiLocationModel(
    id: 1,
    title: 'Home11',
    description: 'Riyadh, Al Olaya District, Building 12',
    lat: '24.7136',
    lng: '46.6753',
    address: 'this is the address',
  );

  static final List<ApiOrderItemModel> _oliveOilItems = [
    ApiOrderItemModel.fromJson({
      'id': 21,
      'product_name': 'زيت زيتون جاردن من الصالحية - زيت زيتون اصلي',
      'units_count': 5,
      'unit_weight': 1,
      'unit_type': 'kg',
      'quantity': 5,
      'line_total': 100,
    }),
    ApiOrderItemModel.fromJson({
      'id': 22,
      'product_name': 'زيت زيتون جاردن من الصالحية - زيت زيتون اصلي',
      'units_count': 5,
      'unit_weight': 1,
      'unit_type': 'kg',
      'quantity': 5,
      'line_total': 100,
    }),
    ApiOrderItemModel.fromJson({
      'id': 23,
      'product_name': 'زيت زيتون جاردن من الصالحية - زيت زيتون اصلي',
      'units_count': 5,
      'unit_weight': 1,
      'unit_type': 'kg',
      'quantity': 5,
      'line_total': 100,
    }),
  ];

  static ApiOrderDetailsModel _sampleOrder({
    required int id,
    required String status,
    String? cancelReason,
    DateTime? ratedAt,
  }) {
    return ApiOrderDetailsModel(
      id: id,
      name: 'Order $id',
      image: const AttachmentEntity.empty(),
      orderNumber: 'ORD-20260825-0001',
      createdAt: DateTime(2026, 8, 16),
      total: 488,
      status: status,
      description: '',
      address: _riyadhAddress,
      items: _oliveOilItems,
      paymentMethod: 'Cash',
      productsPrice: 502,
      deliveryPrice: 106,
      vatAmount: 106,
      cancelReason: cancelReason,
      ratedAt: ratedAt,
    );
  }

  static final List<ApiOrderDetailsModel> _orders = [
    _sampleOrder(id: 10245, status: 'new'),
    _sampleOrder(id: 10246, status: 'preparing'),
    _sampleOrder(id: 10247, status: 'ready_for_delivery'),
    _sampleOrder(id: 10248, status: 'on_the_way'),
    _sampleOrder(id: 10249, status: 'delivered'),
    _sampleOrder(id: 10250, status: 'cancelled', cancelReason: 'Customer requested cancellation'),
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
