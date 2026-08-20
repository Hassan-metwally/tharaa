part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Async<CartEntity> getCartState;
  final Async<int> cartItemsCountState;
  const CartState({required this.getCartState, required this.cartItemsCountState});

  factory CartState.initial() {
    return const CartState(getCartState: Async.initial(), cartItemsCountState: Async.initial());
  }

  CartState copyWith({Async<CartEntity>? getCartState, Async<int>? cartItemsCountState}) {
    return CartState(getCartState: getCartState ?? this.getCartState, cartItemsCountState: cartItemsCountState ?? this.cartItemsCountState);
  }

  @override
  List<Object> get props => [getCartState, cartItemsCountState];
}
