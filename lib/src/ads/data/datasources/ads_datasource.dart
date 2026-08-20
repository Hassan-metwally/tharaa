import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../models/api_ad_model.dart';

abstract class AdsDatasource {
  Future<List<ApiAdModel>> getAllAds(NoParams params);
}

@Injectable(as: AdsDatasource)
class AdsDatasourceImpl extends AdsDatasource {
  final DioHelper _dioHelper;

  AdsDatasourceImpl(this._dioHelper);

  @override
  Future<List<ApiAdModel>> getAllAds(NoParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath("banners"), queryParameters: {'page': 0, 'limit': 0});
      final rawList = (response['data'] as List<dynamic>? ?? const <dynamic>[]);
      final List<ApiAdModel> data = rawList.map((e) => ApiAdModel.fromJson(e)).toList();
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
