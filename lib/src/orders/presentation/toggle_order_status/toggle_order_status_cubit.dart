import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/core.dart';
import '../../domain/usecases/toggle_order_status_usecase.dart';
part 'toggle_order_status_state.dart';

@injectable
class ToggleOrderStatusCubit extends Cubit<ToggleOrderStatusState> {
  final ToggleOrderStatusUseCase _toggleOrderStatusUseCase;
  ToggleOrderStatusCubit(this._toggleOrderStatusUseCase) : super(const ToggleOrderStatusState.initial());

  Future<void> toggleOrderStatus(ToggleOrderStatusParams params) async {
    emit(state.copyWith(toggleOrderStatusState: const Async.loading()));
    final result = await _toggleOrderStatusUseCase(params);
    result.fold(
      (failure) => emit(state.copyWith(toggleOrderStatusState: Async.failure(failure))),
      (data) => emit(state.copyWith(toggleOrderStatusState: Async.success(data))),
    );
  }

  @override
  void emit(ToggleOrderStatusState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
