import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/rate_entity.dart';
import '../../domain/repositories/rating_repository.dart';

import '../../domain/usecases/add_rate_usecase.dart';

import '../../domain/usecases/get_ratings_usecase.dart';

import '../datasources/rating_datasource.dart';
import '../models/api_rate_model.dart';

@Injectable(as: RatingRepository)
class RatingRepositoryImpl extends RatingRepository {
  final RatingDatasource _dataSource;

  RatingRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<String> addRate(UpsertRateParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.addRate(params);
      return Right(result);
    });
  }

  @override
  DomainServiceType<PaginatedData<RateEntity>> getRating(GetRatingsParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getRating(params);

      return Right(result.map((data) => data.map));
    });
  }
}
