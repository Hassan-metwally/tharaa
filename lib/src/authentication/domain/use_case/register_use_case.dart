import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../notifications/helpers/firebase/firebase_helper.dart';
import '../repository/authentication_repository.dart';

@Injectable()
class RegisterUseCase extends IUseCase<void, RegisterParams> {
  final AuthenticationRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    return await _repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String countryCode;
  final String phone;

  const RegisterParams({
    required this.countryCode,
    required this.phone,
    required this.name,
  });

  Future<Map<String, dynamic>> get toMap async {
    return {
      "name": name,
      "country_code": countryCode,
      "phone": (phone.isNotEmpty && !phone.startsWith('0')) ? '0$phone' : phone,
      "terms": 1,
    };
  }

  @override
  List<Object?> get props => [phone, name, countryCode];
}
