import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase _getOrdersUsecase;
  OrdersCubit(this._getOrdersUsecase) : super(OrdersState.initial());

  Future<void> getOrders() async {
    emit(state.copyWith(getOrdersState: const Async.loading(), currentPage: 1));
    final result = await _getOrdersUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getOrdersState: Async.failure(failure))),
      (data) => emit(state.copyWith(getOrdersState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  Future<void> getMoreOrders() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(getOrdersState: Async.paginationLoading(state.getOrdersState.data ?? []), currentPage: state.currentPage + 1));
    final result = await _getOrdersUsecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getOrdersState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getOrdersState: Async.success([...state.getOrdersState.data ?? [], ...data.items]))),
    );
  }

  void updateParams(GetOrdersParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetOrdersParams.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    getOrders();
  }

  @override
  void emit(OrdersState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
