import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../models/api_statistics_model.dart';

abstract class StatisticsDatasource {
  Future<ApiStatisticsModel> getStatistics();
}

@Injectable(as: StatisticsDatasource)
class StatisticsDatasourceImpl extends StatisticsDatasource {
  final DioHelper _dioHelper;

  StatisticsDatasourceImpl(this._dioHelper);

  @override
  Future<ApiStatisticsModel> getStatistics() async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('/statistics'));
      final data = ApiStatisticsModel.fromJson(response['data']['data']);
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
