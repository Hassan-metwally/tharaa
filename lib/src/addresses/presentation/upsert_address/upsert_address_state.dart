part of 'upsert_address_cubit.dart';

class UpsertAddressState extends Equatable {
  final Async<LocationEntity> upsertAddressState;
  final AddressParams params;
  const UpsertAddressState({required this.upsertAddressState, required this.params});

  factory UpsertAddressState.initial() {
    return UpsertAddressState(upsertAddressState: Async.initial(), params: AddressParams.initial());
  }

  UpsertAddressState copyWith({final Async<LocationEntity>? upsertAddressState, final AddressParams? params}) {
    return UpsertAddressState(upsertAddressState: upsertAddressState ?? this.upsertAddressState, params: params ?? this.params);
  }

  @override
  List<Object> get props => [upsertAddressState, params];
}
