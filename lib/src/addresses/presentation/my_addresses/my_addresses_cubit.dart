import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';

part 'my_addresses_state.dart';

@Injectable()
class MyAddressesCubit extends Cubit<MyAddressesState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final DeleteLocationUseCase _deleteLocationUseCase;

  MyAddressesCubit(this._getAddressesUseCase, this._deleteLocationUseCase) : super(const MyAddressesState.initial());

  void getAddresses() async {
    emit(state.copyWith(getMyAddressesState: const Async.loading(), currentPage: 1));
    (await _getAddressesUseCase(GetAddressesParams(page: state.currentPage))).fold(
      (failure) => emit(state.copyWith(getMyAddressesState: Async.failure(failure))),
      (data) => emit(state.copyWith(getMyAddressesState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  void getMoreAddresses() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
    (await _getAddressesUseCase(GetAddressesParams(page: state.currentPage))).fold(
      (failure) => emit(state.copyWith(getMyAddressesState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getMyAddressesState: Async.success([...state.getMyAddressesState.data ?? [], ...data.items]))),
    );
  }

  void deleteAddress(DeleteLocationParams params) async {
    emit(state.copyWith(deleteAddressState: const Async.loading()));

    (await _deleteLocationUseCase(params)).fold(
      (failure) => emit(state.copyWith(deleteAddressState: Async.failure(failure))),
      (_) => emit(state.copyWith(deleteAddressState: const Async.successWithoutData())),
    );
  }

  @override
  void emit(MyAddressesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
