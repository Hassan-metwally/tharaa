part of 'add_order_cubit.dart';

class AddOrderState extends Equatable {
  final Async<OrderEntity> addOrderState;
  final Async<CheckoutPreviewEntity> previewState;
  final Async<CheckoutPreviewEntity> applyCouponState;
  final UpsertOrderParams params;

  const AddOrderState({
    required this.addOrderState,
    required this.previewState,
    required this.applyCouponState,
    required this.params,
  });

  factory AddOrderState.initial() {
    return AddOrderState(
      addOrderState: const Async.initial(),
      previewState: const Async.initial(),
      applyCouponState: const Async.initial(),
      params: UpsertOrderParams.initial(),
    );
  }

  CheckoutPreviewEntity get preview => previewState.data ?? const CheckoutPreviewEntity.initial();

  AddOrderState copyWith({
    Async<OrderEntity>? addOrderState,
    Async<CheckoutPreviewEntity>? previewState,
    Async<CheckoutPreviewEntity>? applyCouponState,
    UpsertOrderParams? params,
  }) {
    return AddOrderState(
      addOrderState: addOrderState ?? this.addOrderState,
      previewState: previewState ?? this.previewState,
      applyCouponState: applyCouponState ?? this.applyCouponState,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [addOrderState, previewState, applyCouponState, params];
}
