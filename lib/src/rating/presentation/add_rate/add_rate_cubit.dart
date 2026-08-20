import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/usecases/add_rate_usecase.dart';

part 'add_rate_state.dart';

@injectable
class AddRateCubit extends Cubit<AddRateState> {
  final AddRateUsecase _addRateUsecase;

  AddRateCubit(this._addRateUsecase) : super(AddRateState.initial());

  void addRate(UpsertRateParams params) async {
    emit(state.copyWith(params: params, addRateState: const Async.loading()));
    final result = await _addRateUsecase(params);
    result.fold(
      (failure) => emit(state.copyWith(addRateState: Async.failure(failure))),
      (data) => emit(state.copyWith(addRateState: Async.success(data))),
    );
  }

  void updateParams(UpsertRateParams params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit(AddRateState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
