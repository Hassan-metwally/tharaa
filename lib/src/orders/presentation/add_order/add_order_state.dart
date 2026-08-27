part of 'add_order_cubit.dart';

class AddOrderState extends Equatable {
  final Async<OrderEntity> addOrderState;
  final UpsertOrderParams params;

  const AddOrderState({required this.addOrderState, required this.params});

  factory AddOrderState.initial() {
    return AddOrderState(addOrderState: const Async.initial(), params: UpsertOrderParams.initial());
  }

  AddOrderState copyWith({Async<OrderEntity>? addOrderState, UpsertOrderParams? params}) {
    return AddOrderState(addOrderState: addOrderState ?? this.addOrderState, params: params ?? this.params);
  }

  @override
  List<Object> get props => [addOrderState, params];
}
