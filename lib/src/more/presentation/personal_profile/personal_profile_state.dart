part of 'personal_profile_cubit.dart';

class ClientPersonalProfileState extends Equatable {
  final Async<ClientEntity> getDataState;
  final Async<void> updateDataState;

  const ClientPersonalProfileState({required this.getDataState, required this.updateDataState});

  const ClientPersonalProfileState.initial() : this(getDataState: const Async.initial(), updateDataState: const Async.initial());
  ClientPersonalProfileState copyWith({final Async<ClientEntity>? getDataState, final Async<void>? updateDataState}) {
    return ClientPersonalProfileState(
      getDataState: getDataState ?? this.getDataState,
      updateDataState: updateDataState ?? this.updateDataState,
    );
  }

  @override
  List<Object?> get props => [getDataState, updateDataState];
}
