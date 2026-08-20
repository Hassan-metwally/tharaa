import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/statistics_entity.dart';
import '../../domain/repositories/statistics_repository.dart';

import '../datasources/statistics_datasource.dart';

import '../models/api_statistics_model.dart';

@Injectable(as: StatisticsRepository)
class StatisticsRepositoryImpl extends StatisticsRepository {
  final StatisticsDatasource _dataSource;

  StatisticsRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<StatisticsEntity> getStatistics() async {
    return await failureCollect(() async {
      final result = await _dataSource.getStatistics();
      return Right(result.map);
    });
  }
}
