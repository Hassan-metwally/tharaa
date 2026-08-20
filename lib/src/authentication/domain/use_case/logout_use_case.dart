import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/authentication_repository.dart';

@Injectable()
class LogOutUseCase extends IUseCase<void, void> {
  final AuthenticationRepository _repository;

  LogOutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await _repository.logOut();
  }
}
