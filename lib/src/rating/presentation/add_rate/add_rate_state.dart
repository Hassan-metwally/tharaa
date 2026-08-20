part of 'add_rate_cubit.dart';

class AddRateState extends Equatable {
  final Async<String> addRateState;
  final UpsertRateParams params;

  const AddRateState({required this.addRateState, required this.params});

  factory AddRateState.initial() {
    return const AddRateState(addRateState: Async.initial(), params: UpsertRateParams.initial());
  }

  AddRateState copyWith({Async<String>? addRateState, UpsertRateParams? params}) {
    return AddRateState(addRateState: addRateState ?? this.addRateState, params: params ?? this.params);
  }

  @override
  List<Object> get props => [addRateState, params];
}
