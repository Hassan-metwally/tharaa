part of 'upsert_address_cubit.dart';

class UpsertAddressState extends Equatable {
  final Async<LocationEntity> upsertAddressState;
  final Async<LocationEntity> getAddressState;
  final AddressParams params;

  const UpsertAddressState({
    required this.upsertAddressState,
    required this.getAddressState,
    required this.params,
  });

  factory UpsertAddressState.initial() {
    return UpsertAddressState(
      upsertAddressState: Async.initial(),
      getAddressState: Async.initial(),
      params: AddressParams.initial(),
    );
  }

  UpsertAddressState copyWith({
    final Async<LocationEntity>? upsertAddressState,
    final Async<LocationEntity>? getAddressState,
    final AddressParams? params,
  }) {
    return UpsertAddressState(
      upsertAddressState: upsertAddressState ?? this.upsertAddressState,
      getAddressState: getAddressState ?? this.getAddressState,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [upsertAddressState, getAddressState, params];
}
