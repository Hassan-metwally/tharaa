import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_case/register_use_case.dart';

typedef RegisterState = Async<void>;

class RegisterCubit extends Cubit<RegisterState> with SafeEmitMixin {
  RegisterCubit() : super(const Async.initial());

  final RegisterUseCase _registerUseCase = injector();

  void register(RegisterParams params) async {
    emit(const Async.loading());
    final result = await _registerUseCase(params);
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
}
