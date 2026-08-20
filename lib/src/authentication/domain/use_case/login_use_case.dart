import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/user_entity.dart';
import '../repository/authentication_repository.dart';

@Injectable()
class LogInUseCase extends IUseCase<UserEntity, LoginParams> {
  final AuthenticationRepository _repository;

  LogInUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await _repository.login(params);
  }
}

class LoginParams extends Equatable {
  final String countryCode;
  final String phone;

  const LoginParams({required this.countryCode, required this.phone});

  Future<Map<String, dynamic>> get toMap async {
    return {"country_code": countryCode, "phone": (phone.isNotEmpty && !phone.startsWith('0')) ? '0$phone' : phone};
  }

  @override
  List<Object?> get props => [countryCode, phone];
}
