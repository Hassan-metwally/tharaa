import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_case/login_use_case.dart';

typedef LoginState = Async<UserEntity>;

class LoginCubit extends Cubit<LoginState> with SafeEmitMixin {
  LoginCubit() : super(const Async.initial());

  final LogInUseCase _logInUseCase = injector();

  void login(LoginParams params) async {
    emit(const Async.loading());
    final result = await _logInUseCase(params);
    result.fold(
      (failure) {
        emit(Async.failure(failure));
      },
      (data) {
        emit(Async.success(data));
      },
    );
    emit(const Async.initial());
  }
}
