import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/order_details_entity.dart';
import '../../domain/usecases/show_order_details_usecase.dart';

part 'show_order_details_state.dart';

@injectable
class ShowOrderDetailsCubit extends Cubit<ShowOrderDetailsState> {
  final ShowOrderDetailsUsecase _showOrderDetailsUsecase;
  ShowOrderDetailsCubit(this._showOrderDetailsUsecase) : super(ShowOrderDetailsState.initial());

  Future<void> showOrderDetails(int id) async {
    emit(state.copyWith(showOrderState: const Async.loading()));
    final result = await _showOrderDetailsUsecase(id);
    result.fold(
      (failure) => emit(state.copyWith(showOrderState: Async.failure(failure))),
      (data) => emit(state.copyWith(showOrderState: Async.success(data))),
    );
  }

  void changeOrderLocally() {
    final order = state.showOrderState.data;
    if (order != null) {
      emit(state.copyWith(showOrderState: Async.success(order.copyWith())));
    }
  }

  @override
  void emit(ShowOrderDetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
