part of core;

class ServerException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;
  ServerException({this.errorMap, required this.message});
}

class ApiRequestException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;
  ApiRequestException({this.errorMap, required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException({this.message = "Secure storage Fail to get data"});
}

class UnVerifiedUserException implements Exception {
  final String message;
  final Token token;

  UnVerifiedUserException({this.message = "User is not verified", required this.token});

  factory UnVerifiedUserException.fromReeponse(Map<String, dynamic> json) {
    return UnVerifiedUserException(
      token: TokenModel.forSingleSession(token: json["data"]["access_token"]),
      message: json["message"] ?? "User is not verified",
    );
  }
}

class UnExpectedException implements Exception {
  final String message;
  UnExpectedException({required this.message});
}
