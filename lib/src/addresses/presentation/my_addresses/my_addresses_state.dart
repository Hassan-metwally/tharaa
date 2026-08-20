part of 'my_addresses_cubit.dart';

class MyAddressesState extends Equatable {
  final Async<List<LocationEntity>> getMyAddressesState;
  final int currentPage;
  final int lastPage;

  final Async<void> deleteAddressState;

  const MyAddressesState({
    required this.getMyAddressesState,
    required this.currentPage,
    required this.lastPage,
    required this.deleteAddressState,
  });

  const MyAddressesState.initial()
    : this(getMyAddressesState: const Async.initial(), deleteAddressState: const Async.initial(), currentPage: 1, lastPage: 1);

  MyAddressesState copyWith({
    final Async<List<LocationEntity>>? getMyAddressesState,
    final Async<void>? deleteAddressState,
    final int? currentPage,
    final int? lastPage,
  }) {
    return MyAddressesState(
      getMyAddressesState: getMyAddressesState ?? this.getMyAddressesState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getMyAddressesState, deleteAddressState, currentPage, lastPage];
}
