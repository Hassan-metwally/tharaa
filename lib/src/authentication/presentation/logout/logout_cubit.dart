import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_case/logout_use_case.dart';

class LogOutCubit extends Cubit<Async<void>> {
  LogOutCubit() : super(const Async.initial());

  final LogOutUseCase _logOutUseCase = injector();

  void logout() async {
    emit(const Async.loading());
    final result = await _logOutUseCase(NoParams());
    result.fold(
      (failer) {
        emit(Async.failure(failer));
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
