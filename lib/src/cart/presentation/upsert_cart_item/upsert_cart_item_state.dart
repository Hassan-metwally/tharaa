part of 'upsert_cart_item_cubit.dart';

class UpsertCartItemState extends Equatable {
  final Async<CartEntity> upsertCartItemsState;
  final AddToCartParams params;
  const UpsertCartItemState({required this.upsertCartItemsState, required this.params});

  factory UpsertCartItemState.initial() {
    return UpsertCartItemState(upsertCartItemsState: Async.initial(), params: AddToCartParams.initial());
  }

  UpsertCartItemState copyWith({Async<CartEntity>? upsertCartItemsState, AddToCartParams? params}) {
    return UpsertCartItemState(upsertCartItemsState: upsertCartItemsState ?? this.upsertCartItemsState, params: params ?? this.params);
  }

  @override
  List<Object> get props => [upsertCartItemsState, params];
}
