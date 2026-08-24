part of 'toggle_order_status_cubit.dart';

class ToggleOrderStatusState extends Equatable {
  final Async<String> toggleOrderStatusState;

  const ToggleOrderStatusState({required this.toggleOrderStatusState});

  const ToggleOrderStatusState.initial() : toggleOrderStatusState = const Async.initial();

  ToggleOrderStatusState copyWith({Async<String>? toggleOrderStatusState}) {
    return ToggleOrderStatusState(toggleOrderStatusState: toggleOrderStatusState ?? this.toggleOrderStatusState);
  }

  @override
  List<Object> get props => [toggleOrderStatusState];
}
