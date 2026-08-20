import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/add_location_use_case.dart';
import '../../domain/usecases/update_address_in_address_list_usecase.dart';

part 'upsert_address_state.dart';

@Injectable()
class UpsertAddressCubit extends Cubit<UpsertAddressState> {
  final AddLocationUseCase _addLocationUseCase;
  final UpdateAddressInAddressListuseCase _updateLocationUseCase;

  UpsertAddressCubit(this._addLocationUseCase, this._updateLocationUseCase) : super(UpsertAddressState.initial());

  void setInitialParams(LocationEntity? location) {
    if (location == null) return;
    emit(state.copyWith(params: AddressParams.fromEntity(location)));
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
        (_) => emit(state.copyWith(upsertAddressState: const Async.successWithoutData(), params: state.params)),
      );
    }
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
