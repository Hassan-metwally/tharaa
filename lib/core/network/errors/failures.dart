part of core;

class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final Map<String, dynamic>? errorMap;
  final int? statusCode;
  const ServerFailure({required super.message, this.errorMap, this.statusCode});
}

class RequestFailure extends Failure {
  const RequestFailure({required super.message});
}

class UnExpectedFailure extends Failure {
  const UnExpectedFailure({required super.message});
}

class UnVerifiedUserFailure extends Failure {
  final Token token;
  const UnVerifiedUserFailure({required super.message, required this.token});
}

class SecureStorageFailure extends Failure {
  const SecureStorageFailure({required super.message});
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure({required super.message});
}
