part of 'show_order_details_cubit.dart';

class ShowOrderDetailsState extends Equatable {
  final Async<OrderDetailsEntity> showOrderState;
  const ShowOrderDetailsState({required this.showOrderState});

  factory ShowOrderDetailsState.initial() {
    return const ShowOrderDetailsState(showOrderState: Async.initial());
  }

  ShowOrderDetailsState copyWith({Async<OrderDetailsEntity>? showOrderState}) {
    return ShowOrderDetailsState(showOrderState: showOrderState ?? this.showOrderState);
  }

  @override
  List<Object> get props => [showOrderState];
}
