part of core;

Future<T> apiExecptionCollecter<T>({required Future<Response?> Function() task}) async {
  try {
    final taskResult = await task();
    final Response? response = taskResult;
    if (response == null) {
      final String errorMessage = response?.data["message"] ?? appLocalizer.unexpectedError;
      throw UnExpectedException(message: errorMessage);
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      /// Bad response
      ///
      case 400:
      case 422:
        final data = response.data;
        throw ApiRequestException(message: data['message'].toString());

      /// Un autherized
      ///
      case 401:
        final data = response.data;
        final String errorMessage = data["message"] ?? appLocalizer.unAutherizedUserExeption;
        throw UnauthorizedException(message: errorMessage);

      /// Forbidden user [Like user token has expired]
      case 403:
        final data = response.data;
        final String errorMessage = data["message"] ?? appLocalizer.unAutherizedUserExeption;
        throw ApiRequestException(message: errorMessage);

      /// If the account is temporarily locked due to unverified status.
      case 423:
        throw UnVerifiedUserException.fromReeponse(response.data);

      case 500:
      default:
        throw UnExpectedException(message: response.data["error"] ?? response.data["message"] ?? appLocalizer.unexpectedError);
    }
  } on SocketException {
    throw ServerException(message: appLocalizer.noInternetConnection);
  }
  /// On exception occured
  /// Like bad response or server error or any execption back from server
  ///
  on DioException catch (e) {
    final Response? response = e.response;
    String? errorMessage;
    final dynamic data = response?.data;
    if (data is Map<String, dynamic>) {
      errorMessage = data["message"];
    } else if (data is String) {
      errorMessage = data;
    } else {
      errorMessage = e.message;
    }

    if (errorMessage?.isEmpty ?? false) {
      errorMessage = null;
    }

    /// If the account is temporarily locked due to unverified status.
    if (response?.statusCode == 423) {
      throw UnVerifiedUserException.fromReeponse(response?.data);
    }

    if (e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionTimeout) {
      throw ApiRequestException(message: appLocalizer.noInternetConnection);
    } else if (e.type == DioExceptionType.badResponse) {
      throw ApiRequestException(message: errorMessage ?? appLocalizer.noInternetConnection);
    } else if (e.type == DioExceptionType.connectionError) {
      throw ApiRequestException(message: appLocalizer.noInternetConnection);
    } else {
      throw UnExpectedException(message: errorMessage ?? appLocalizer.unexpectedError);
    }
  } on UnExpectedException catch (_) {
    rethrow;
  } on ApiRequestException catch (_) {
    rethrow;
  } on SecureStorageException catch (_) {
    rethrow;
  } on UnauthorizedException catch (_) {
    rethrow;
  } on String catch (e) {
    throw UnExpectedException(message: e);
  } catch (e) {
    throw UnExpectedException(message: appLocalizer.unexpectedError);
  }
}
