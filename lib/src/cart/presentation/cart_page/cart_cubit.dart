import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';

part 'cart_state.dart';

@Injectable()
class CartCubit extends Cubit<CartState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  CartCubit(this.getCartItemsUsecase) : super(CartState.initial());

  Future<void> getCart() async {
    emit(state.copyWith(getCartState: Async.loading()));
    final result = await getCartItemsUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(getCartState: Async.failure(failure)));
      },
      (items) {
        emit(state.copyWith(getCartState: Async.success(items)));
      },
    );
  }

  Future<void> cartItemsCount() async {
    emit(state.copyWith(cartItemsCountState: Async.loading()));
    final result = await getCartItemsUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(cartItemsCountState: Async.failure(failure)));
      },
      (cart) {
        emit(state.copyWith(cartItemsCountState: Async.success(cart.items.length)));
      },
    );
  }

  Future<void> updateLocalCartItems({required CartEntity cart}) async {
    emit(state.copyWith(getCartState: Async.success(cart)));
  }

  @override
  void emit(CartState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
