part of core;

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await Future.wait([_initToken(options), _initLang(options)]);
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  final _getCachedLanguageUseCase = GetCachedLanguageUseCase.getInstance();
  final _getTokenUseCase = GetTokenUseCase.getInstance();

  Future<void> _initLang(RequestOptions options) async {
    try {
      final lang = await _getCachedLanguageUseCase();
      options.headers.addEntries({"lang": lang.value, "Accept-Language": lang.value}.entries);
    } catch (error) {
      debugPrint("======= HeaderInterceptor Language Error ==> ${error.toString()}");
    }
  }

  Future<void> _initToken(RequestOptions options) async {
    try {
      final token = await _getTokenUseCase();
      if (token != null) {
        if (!token.isExpired) {
          options.headers.addEntries({"Authorization": 'Bearer ${token.token}'}.entries);
        }
      }
    } catch (error) {
      debugPrint("======= HeaderInterceptor TOKEN Error ==> ${error.toString()}");
    }
  }
}
