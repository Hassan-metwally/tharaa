import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../repository/authentication_repository.dart';

@Injectable()
class VerifyOtpUseCase extends IUseCase<void, VerifyOtpParams> {
  final AuthenticationRepository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
    return await _repository.verifyOtp(params);
  }
}

class VerifyOtpParams {
  final String verificationCode;
  final OtpScreenCaseEnum verifyCase;
  final String countryCode;
  final String phone;

  const VerifyOtpParams({required this.verificationCode, required this.countryCode, required this.phone, required this.verifyCase});

  Future<Map<String, dynamic>> get toMap async => {
    "code": verificationCode,
    "country_code": countryCode,
    "phone": phone,
    "purpose": verifyCase.value,
    "fcm_token": "test_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_tokentest_token",
    // "fcm_token": await FirebaseHelper.getDeviceFcmToken(),
  };
}

enum OtpScreenCaseEnum {
  register("register"),
  changePhone("change_phone"),
  login("login");

  final String value;
  const OtpScreenCaseEnum(this.value);
}

class OtpScreenArguments {
  final String countryCode;
  final String phone;
  final OtpScreenCaseEnum verifyCase;
  final String? _illustration;

  OtpScreenArguments({required this.countryCode, required this.phone, required this.verifyCase, String? illustration})
    : _illustration = illustration;

  String get illustration => _illustration ?? "AppIcons.fullLogo";
}
