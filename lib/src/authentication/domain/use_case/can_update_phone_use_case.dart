import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/authentication_repository.dart';

@Injectable()
class CanUpdatePhoneUseCase extends IUseCase<void, CanUpdatePhoneParams> {
  final AuthenticationRepository _repository;

  CanUpdatePhoneUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(CanUpdatePhoneParams params) async => await _repository.canUpdateMobile(params);
}

class CanUpdatePhoneParams extends Equatable {
  final String countryCode;
  final String phone;

  const CanUpdatePhoneParams({required this.countryCode, required this.phone});

  @override
  List<Object?> get props => [countryCode, phone];

  Map<String, dynamic> get toMap {
    return {"country_code": countryCode, "phone": (phone.isNotEmpty && !phone.startsWith('0')) ? '0$phone' : phone};
  }
}
