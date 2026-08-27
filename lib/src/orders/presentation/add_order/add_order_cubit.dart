import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/add_order_usecase.dart';

part 'add_order_state.dart';

@injectable
class AddOrderCubit extends Cubit<AddOrderState> {
  final AddOrderUsecase _addOrderUsecase;

  AddOrderCubit(this._addOrderUsecase) : super(AddOrderState.initial());

  void addOrder() async {
    emit(state.copyWith(addOrderState: const Async.loading()));
    final result = await _addOrderUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(addOrderState: Async.failure(failure))),
      (data) => emit(state.copyWith(addOrderState: Async.success(data))),
    );
  }

  void updateParams(UpsertOrderParams params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit(AddOrderState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
