import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../core/di/di.dart';
import '../../src/common/domain/use_cases/language/change_langauge_use_case.dart';

typedef ChangeLanguageState = Async<AppLanguageEnum>;

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(const Async.initial());

  final ChangeLanguageUseCase _changeLanguageUseCase = injector();

  void changeLanguage(AppLanguageEnum lang) async {
    emit(const Async.loading());
    final result = await _changeLanguageUseCase(lang);
    result.fold(
      (failure) {
        emit(Async.failure(failure));
      },
      (_) {
        emit(Async.success(lang));
      },
    );
    emit(const Async.initial());
  }

  @override
  void emit(ChangeLanguageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
