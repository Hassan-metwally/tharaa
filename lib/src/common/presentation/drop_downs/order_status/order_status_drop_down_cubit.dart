import '../../../../../../core/core.dart';
import '../../../domain/enums/orders/order_status_enum.dart';
import '../drop_downs/drop_down_cubit.dart';

class OrderStatusDropDownCubit extends DropDownCubit<OrderStatusEnum> {
  OrderStatusDropDownCubit();

  @override
  void fetch() async {
    if (state.isSuccess) return;
    emit(const Async.loading());
    emit(Async.success(OrderStatusEnum.values));
  }
}
