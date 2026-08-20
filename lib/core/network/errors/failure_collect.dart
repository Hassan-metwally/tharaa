part of core;

Future<Either<Failure, T>> failureCollect<T>(
  Future<Either<Failure, T>> Function() task, {
  Future<Failure?> Function(Exception execption)? catchExecption,
  Future<Failure?> Function(Object? execption)? catchError,
}) async {
  try {
    return await task();
  } catch (e) {
    if (catchExecption != null && e is Exception) {
      final failer = await catchExecption(e);
      if (failer != null) {
        return Left(failer);
      }
    } else if (catchError != null) {
      final failer = await catchError(e);
      if (failer != null) {
        return Left(failer);
      }
    }

    if (e is ApiRequestException) {
      return Left(RequestFailure(message: e.message));
    } else if (e is ServerException) {
      return Left(ServerFailure(message: e.message));
    } else if (e is SecureStorageException) {
      return Left(SecureStorageFailure(message: e.message));
    } else if (e is UnauthorizedException) {
      return Left(UnAuthorizedFailure(message: e.message));
    } else if (e is UnVerifiedUserException) {
      return Left(UnVerifiedUserFailure(message: e.message, token: e.token));
    } else if (e is UnExpectedException) {
      return Left(UnExpectedFailure(message: e.message));
    } else {
      return Left(ServerFailure(message: appLocalizer.somethingWentWrong));
    }
  }
}
