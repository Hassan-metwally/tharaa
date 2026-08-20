import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../repository/common_repository.dart';

@injectable
class ChangeLanguageUseCase extends IUseCase<AppLanguageEnum, AppLanguageEnum> {
  final CommonRepository _repository;

  ChangeLanguageUseCase(this._repository);

  @override
  Future<Either<Failure, AppLanguageEnum>> call(AppLanguageEnum params) async {
    return await _repository.changeLanguage(params);
  }
}
