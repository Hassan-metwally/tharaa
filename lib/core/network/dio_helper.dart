part of core;

@Injectable()
class DioHelper {
  DioHelper({required Dio dio}) : _dio = dio {
    _init();
  }

  final Dio _dio;

  final Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "api-key": ApiConstants.apiKey,
  };

  void _init() {
    _dio.options.headers = _headers;
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
    _dio.interceptors.add(UnAuthenticatedInterceptor.instance);
  }

  DioHelper copyWith(BaseOptions Function(BaseOptions options) getOptions) {
    final DioHelper newDioObj = this;
    newDioObj._dio.options = getOptions(_dio.options);
    return newDioObj;
  }

  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final result = await apiExecptionCollecter(
      task: () async {
        final FormData? formData = body != null ? FormData.fromMap(body) : null;
        final result = await _dio.get(url, data: formData, queryParameters: queryParameters, cancelToken: cancelToken);
        return result;
      },
    );
    if (result is List) {
      return {'data': result};
    } else {
      return result;
    }
  }

  Future<Map<String, dynamic>> put({
    required String url,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    return apiExecptionCollecter(
      task: () async {
        final FormData? form = formData != null ? FormData.fromMap(formData) : null;
        return await _dio.put(url, data: form ?? body, cancelToken: cancelToken);
      },
    );
  }

  Future<Map<String, dynamic>> post({
    required final String url,
    final Map<String, dynamic>? body,
    final Map<String, dynamic>? json,
    final Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return apiExecptionCollecter(
      task: () async {
        final FormData? formData = body != null ? FormData.fromMap(body) : null;
        return await _dio.post(url, data: json ?? formData, queryParameters: queryParameters, cancelToken: cancelToken);
      },
    );
  }

  Future<dynamic> delete({required String url}) async {
    return apiExecptionCollecter(
      task: () async {
        return await _dio.delete(url);
      },
    );
  }

  Future<dynamic> patch({required String url}) async {
    return apiExecptionCollecter(
      task: () async {
        return await _dio.patch(url);
      },
    );
  }
}
