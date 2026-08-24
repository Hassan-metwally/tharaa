part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final Async<List<OrderEntity>> getOrdersState;

  final GetOrdersParams params;
  final int currentPage;
  final int lastPage;

  const OrdersState({required this.getOrdersState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory OrdersState.initial() {
    return const OrdersState(getOrdersState: Async.initial(), params: GetOrdersParams.initial());
  }

  OrdersState copyWith({Async<List<OrderEntity>>? getOrdersState, GetOrdersParams? params, int? currentPage, int? lastPage}) {
    return OrdersState(
      getOrdersState: getOrdersState ?? this.getOrdersState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getOrdersState, params, currentPage, lastPage];
}
