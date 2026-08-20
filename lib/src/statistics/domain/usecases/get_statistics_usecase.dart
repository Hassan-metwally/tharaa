import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/statistics_entity.dart';
import '../repositories/statistics_repository.dart';

@injectable
class GetStatisticsUsecase extends IUseCase<StatisticsEntity, NoParams> {
  final StatisticsRepository _repository;

  GetStatisticsUsecase(this._repository);

  @override
  Future<Either<Failure, StatisticsEntity>> call(NoParams params) {
    return _repository.getStatistics();
  }
}
