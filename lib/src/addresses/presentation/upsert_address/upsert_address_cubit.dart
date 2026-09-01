import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/add_location_use_case.dart';
import '../../domain/usecases/get_address_use_case.dart';
import '../../domain/usecases/set_default_address_use_case.dart';
import '../../domain/usecases/update_address_in_address_list_usecase.dart';

part 'upsert_address_state.dart';

@Injectable()
class UpsertAddressCubit extends Cubit<UpsertAddressState> {
  final AddLocationUseCase _addLocationUseCase;
  final UpdateAddressInAddressListuseCase _updateLocationUseCase;
  final GetAddressUseCase _getAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;

  UpsertAddressCubit(
    this._addLocationUseCase,
    this._updateLocationUseCase,
    this._getAddressUseCase,
    this._setDefaultAddressUseCase,
  ) : super(UpsertAddressState.initial());

  Future<void> loadAddress(int id) async {
    emit(state.copyWith(getAddressState: const Async.loading()));
    (await _getAddressUseCase(GetAddressParams(id: id))).fold(
      (failure) => emit(state.copyWith(getAddressState: Async.failure(failure))),
      (data) => emit(
        state.copyWith(
          getAddressState: Async.success(data),
          params: AddressParams.fromEntity(data),
        ),
      ),
    );
  }

  void upsertAddress() async {
    emit(state.copyWith(upsertAddressState: const Async.loading()));
    if (state.params.id == null) {
      (await _addLocationUseCase(state.params)).fold(
        (failure) => emit(state.copyWith(upsertAddressState: Async.failure(failure))),
        (data) => emit(state.copyWith(upsertAddressState: Async.success(data), params: state.params)),
      );
    } else {
      (await _updateLocationUseCase(state.params)).fold(
        (failure) => emit(state.copyWith(upsertAddressState: Async.failure(failure))),
        (data) => emit(state.copyWith(upsertAddressState: Async.success(data), params: state.params)),
      );
    }
  }

  void setAsDefaultAddress() async {
    final int? id = state.params.id;
    if (id == null) return;

    emit(state.copyWith(upsertAddressState: const Async.loading()));
    (await _setDefaultAddressUseCase(SetDefaultAddressParams(id: id))).fold(
      (failure) => emit(state.copyWith(upsertAddressState: Async.failure(failure))),
      (data) => emit(
        state.copyWith(
          upsertAddressState: Async.success(data),
          params: state.params.copyWith(isDefault: true),
        ),
      ),
    );
  }

  void updateParams(AddressParams params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit(UpsertAddressState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
