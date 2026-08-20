import '../../../../../../core/core.dart';

import '../entities/statistics_entity.dart';

abstract class StatisticsRepository {
  DomainServiceType<StatisticsEntity> getStatistics();
}
