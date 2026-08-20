import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/checkout_cart_usecase.dart';

part 'checkout_cart_state.dart';

class CheckoutCartCubit extends Cubit<CheckoutCartState> {
  final CheckoutCartUsecase _checkoutCartUsecase;

  CheckoutCartCubit(this._checkoutCartUsecase) : super(CheckoutCartState.initial());

  Future<void> checkoutCart() async {
    emit(state.copyWith(checkoutCartState: Async.loading()));
    final result = await _checkoutCartUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(checkoutCartState: Async.failure(failure)));
      },
      (message) {
        emit(state.copyWith(checkoutCartState: Async.success(message)));
      },
    );
  }

  @override
  void emit(CheckoutCartState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
