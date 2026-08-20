import '../../../../core/core.dart';
import 'api_user_model.dart';

class ApiLoggedUserResponse {
  final String accessToken;
  final ApiUserModel user;

  const ApiLoggedUserResponse({required this.accessToken, required this.user});

  factory ApiLoggedUserResponse.fromJson(Map<String, dynamic> json) =>
      ApiLoggedUserResponse(accessToken: json["token"] ?? '', user: ApiUserModel.fromJson(json["user"]));

  TokenModel get getTokenForSingleSession {
    if (accessToken.isEmpty) {
      throw "ApiLoggedUserResponse accessToken is requried and cant be empty";
    }
    return TokenModel.forSingleSession(token: accessToken);
  }

  TokenModel get getAsValidTokenModel {
    if (accessToken.isEmpty) {
      throw "ApiLoggedUserResponse accessToken is requried and cant be empty";
    }
    return TokenModel(token: accessToken);
  }

  ApiUserModel get getUserModel {
    return user;
  }
}
