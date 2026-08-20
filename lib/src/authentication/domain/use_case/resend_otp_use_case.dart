import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/authentication_repository.dart';
import 'verify_otp_use_case.dart';

@Injectable()
class ResendOtpUseCase extends IUseCase<void, ResendOtpParams> {
  final AuthenticationRepository _repository;

  ResendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ResendOtpParams params) async {
    return await _repository.resendOtp(params);
  }
}

class ResendOtpParams extends NoParams {
  final OtpScreenCaseEnum verifyCase;
  final String countryCode;
  final String phone;
  ResendOtpParams({required this.phone, required this.countryCode, required this.verifyCase});

  @override
  Future<Map<String, dynamic>> get toMap async => {
    "purpose": verifyCase.value,
    "country_code": countryCode,
    "phone": phone,
    "fcm_token": "test_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_token",
    // "fcm_token": await FirebaseHelper.getDeviceFcmToken(),
  };
}
