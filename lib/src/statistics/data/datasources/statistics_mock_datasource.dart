import 'package:injectable/injectable.dart';

import '../models/api_statistics_model.dart';
import 'statistics_datasource.dart';

@Injectable(as: StatisticsDatasource)
class StatisticsMockDatasource extends StatisticsDatasource {
  @override
  Future<ApiStatisticsModel> getStatistics() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return ApiStatisticsModel(
      newOrdersCount: 12,
      inProgressOrdersCount: 5,
      finishedOrdersCount: 28,
      completedOrdersCount: 28,
      remainingOrdersCount: 7,
    );
  }
}
