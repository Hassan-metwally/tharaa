import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_case/delete_account_use_case.dart';

class DeleteAccountCubit extends Cubit<Async<void>> {
  DeleteAccountCubit() : super(const Async.initial());

  final DeleteAccountUseCase _deleteAccountUseCase = injector();

  void deleteAccount() async {
    emit(const Async.loading());
    final result = await _deleteAccountUseCase(NoParams());
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
