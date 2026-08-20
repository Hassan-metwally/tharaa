import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../core/di/di.dart';
import '../domain/entities/address_entity.dart';
import '../domain/use_cases/google_maps_api/get_location_address_use_case.dart';
import 'maps_main_state.dart';

class MapsMainCubit extends Cubit<MapsMainState> {
  MapsMainCubit() : super(const MapsMainState.initial()) {
    _initUseCases();
  }

  static MapsMainCubit of(BuildContext context) => BlocProvider.of<MapsMainCubit>(context);

  late final GetMapLocationAddressUseCase _getMapLocationAddressUseCase;

  void _initUseCases() {
    _getMapLocationAddressUseCase = injector();
  }

  void getLocationAddress(GetMapLocationAddressParams params) async {
    emit(state.copyWith(locationState: const Async.loading()));
    final result = await _getMapLocationAddressUseCase(params);
    result.fold(
      (error) {
        emit(state.copyWith(locationState: Async.failure(error)));
      },
      (address) {
        emit(state.copyWith(locationState: Async.success(address)));
      },
    );
  }

  void setLocationAddressData(MapAddressEntity data) {
    emit(state.copyWith(locationState: const Async.initial()));
    emit(state.copyWith(locationState: Async.success(data)));
  }

  void updateAddress(MapAddressEntity data) {
    emit(state.copyWith(locationState: const Async.initial()));
    emit(state.copyWith(locationState: Async.success(data)));
  }

  @override
  void emit(MapsMainState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
