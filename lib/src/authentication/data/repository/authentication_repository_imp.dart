import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/authentication_repository.dart';
import '../../domain/use_case/register_use_case.dart';
import '../../domain/use_case/can_update_phone_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/resend_otp_use_case.dart';
import '../../domain/use_case/verify_otp_use_case.dart';
import '../models/api_authentication_response.dart';
import '../models/api_user_model.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImp implements AuthenticationRepository {
  final DioHelper _apiHelper;
  final SecureStorageRepository _secureStorageRepository;

  const AuthenticationRepositoryImp(this._apiHelper, this._secureStorageRepository);

  @override
  DomainServiceType<UserEntity> login(LoginParams params) async {
    return await failureCollect(() async {
      final response = await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/login"), body: await params.toMap);
      final user = ApiLoggedUserResponse.fromJson(response['data']);
      return Right(user.user.map);
    });
  }

  @override
  DomainServiceType<void> register(RegisterParams params) async {
    return await failureCollect(() async {
      await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/register"), body: await params.toMap);
      return const Right(null);
    });
  }

  @override
  DomainServiceType<void> verifyOtp(VerifyOtpParams params) async {
    return await failureCollect<void>(() async {
      switch (params.verifyCase) {
        case OtpScreenCaseEnum.register:
        case OtpScreenCaseEnum.login:
          final result = await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/verify-otp"), body: await params.toMap);
          final UserEntity user = ApiUserModel.fromJson(result['data']['user']).map;
          await _secureStorageRepository.setCachedUser(user.mapToCacheEntity);
          final token = ApiLoggedUserResponse.fromJson(result['data']);
          await _secureStorageRepository.setToken(token.getAsValidTokenModel);
          break;
        case OtpScreenCaseEnum.changePhone:
          final result = await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/verify-otp"), body: await params.toMap);
          await _secureStorageRepository.deleteToken();
          await _secureStorageRepository.deleteCachedUser();
          final userAndToken = ApiLoggedUserResponse.fromJson(result['data']);
          await _secureStorageRepository.setToken(userAndToken.getAsValidTokenModel);
          await _secureStorageRepository.setCachedUser(userAndToken.user.map.mapToCacheEntity);
          break;
      }
      return const Right(null);
    });
  }

  @override
  DomainServiceType<void> resendOtp(ResendOtpParams params) async {
    return await failureCollect<void>(() async {
      await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/resend-otp"), body: await params.toMap);
      return const Right(null);
    });
  }

  @override
  DomainServiceType<void> logOut() async {
    return await failureCollect<void>(() async {
      await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/logout"));
      await _secureStorageRepository.deleteAllCache();
      return const Right(null);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    return await failureCollect<void>(() async {
      await _apiHelper.delete(url: ApiConstants.addToApiUrlPath("profile"));
      await _secureStorageRepository.deleteAllCache();
      return const Right(null);
    });
  }

  @override
  DomainServiceType<void> canUpdateMobile(CanUpdatePhoneParams params) async {
    return await failureCollect<void>(() async {
      await _apiHelper.post(url: ApiConstants.addToApiUrlPath("profile/change-phone"), body: params.toMap);
      return const Right(null);
    });
  }

  /// Common Services
  ///

  // @override
  // DomainServiceType<void> forgotPassword(ForgotPasswordParams params) async {
  //   return await failureCollect<void>(() async {
  //     final result = await _apiHelper.post(url: "auth/forget-password", body: params.toMap);
  //     final tokenValue = result["data"]["access_token"];
  //     final token = TokenModel.forSingleSession(token: tokenValue);
  //     await _secureStorageRepository.setToken(token);
  //     return const Right(null);
  //   });
  // }

  // @override
  // DomainServiceType<void> resetPassword(ResetPasswordParams params) async {
  //   return await failureCollect<void>(() async {
  //     await _apiHelper.post(url: "auth/reset-password", body: params.toMap);
  //     await _secureStorageRepository.deleteAllCache();
  //     return const Right(null);
  //   });
  // }

  // @override
  // DomainServiceType<void> updatePassword(UpdatePasswordParams params) async {
  //   return await failureCollect<void>(() async {
  //     await _apiHelper.post(url: "auth/change-password", body: params.toMap);
  //     await _secureStorageRepository.deleteAllCache();
  //     return const Right(null);
  //   });
  // }
}
