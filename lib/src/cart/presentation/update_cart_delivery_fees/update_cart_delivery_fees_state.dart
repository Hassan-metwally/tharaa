part of 'update_cart_delivery_fees_cubit.dart';

class UpdateCartDeliveryFeesState extends Equatable {
  final Async<CartEntity> updateCartDeliveryFeesState;
  final UpdateCartDeliveryFeesParams params;
  const UpdateCartDeliveryFeesState({required this.updateCartDeliveryFeesState, required this.params});

  factory UpdateCartDeliveryFeesState.initial() {
    return UpdateCartDeliveryFeesState(updateCartDeliveryFeesState: Async.initial(), params: UpdateCartDeliveryFeesParams.initial());
  }

  UpdateCartDeliveryFeesState copyWith({Async<CartEntity>? updateCartDeliveryFeesState, UpdateCartDeliveryFeesParams? params}) {
    return UpdateCartDeliveryFeesState(
      updateCartDeliveryFeesState: updateCartDeliveryFeesState ?? this.updateCartDeliveryFeesState,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [updateCartDeliveryFeesState, params];
}
