import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_case/can_update_phone_use_case.dart';

class UpdatePhoneCubit extends Cubit<Async<void>> {
  UpdatePhoneCubit() : super(const Async.initial());

  final CanUpdatePhoneUseCase _canUpdatePhoneUseCase = injector();

  void canUpdate(CanUpdatePhoneParams params) async {
    emit(const Async.loading());
    final result = await _canUpdatePhoneUseCase(params);
    result.fold(
      (failure) {
        emit(Async.failure(failure));
      },
      (_) {
        emit(const Async.successWithoutData());
      },
    );
    emit(const Async.initial());
  }

  @override
  void emit(Async<void> state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
