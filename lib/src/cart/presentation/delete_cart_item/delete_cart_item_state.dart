part of 'delete_cart_item_cubit.dart';

class DeleteCartItemState extends Equatable {
  final Async<CartEntity> deleteItemsState;
  const DeleteCartItemState({required this.deleteItemsState});

  factory DeleteCartItemState.initial() {
    return const DeleteCartItemState(deleteItemsState: Async.initial());
  }

  DeleteCartItemState copyWith({Async<CartEntity>? deleteItemsState}) {
    return DeleteCartItemState(deleteItemsState: deleteItemsState ?? this.deleteItemsState);
  }

  @override
  List<Object> get props => [deleteItemsState];
}
