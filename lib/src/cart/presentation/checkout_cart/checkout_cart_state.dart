part of 'checkout_cart_cubit.dart';

class CheckoutCartState extends Equatable {
  final Async<String> checkoutCartState;

  const CheckoutCartState({required this.checkoutCartState});

  factory CheckoutCartState.initial() {
    return const CheckoutCartState(checkoutCartState: Async.initial());
  }

  CheckoutCartState copyWith({Async<String>? checkoutCartState}) {
    return CheckoutCartState(checkoutCartState: checkoutCartState ?? this.checkoutCartState);
  }

  @override
  List<Object> get props => [checkoutCartState];
}
