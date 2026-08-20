import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/usecases/add_rate_usecase.dart';

import '../../domain/usecases/get_ratings_usecase.dart';

import '../models/api_rate_model.dart';

abstract class RatingDatasource {
  Future<String> addRate(UpsertRateParams params);

  Future<ApiPaginatedData<ApiRateModel>> getRating(GetRatingsParams params);
}

@Injectable(as: RatingDatasource)
class RatingDatasourceImpl extends RatingDatasource {
  final DioHelper _dioHelper;

  RatingDatasourceImpl(this._dioHelper);

  @override
  Future<String> addRate(UpsertRateParams params) async {
    try {
      final response = await _dioHelper.post(url: "ApiConstants.appRoleApi('/rate')", body: params.toMap);
      return response['message'];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiPaginatedData<ApiRateModel>> getRating(GetRatingsParams params) async {
    try {
      final response = await _dioHelper.get(url: "ApiConstants.appRoleApi('/rate')", queryParameters: params.toMap);
      final data = ApiPaginatedData<ApiRateModel>.fromJson(
        response['data'],
        getData: (dataList) => dataList.map((e) => ApiRateModel.fromJson(e)).toList(),
      );
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
