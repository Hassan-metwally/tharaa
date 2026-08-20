import '../../../../../../core/core.dart';

import '../entities/rate_entity.dart';

import '../usecases/add_rate_usecase.dart';

import '../usecases/get_ratings_usecase.dart';

abstract class RatingRepository {
  DomainServiceType<String> addRate(UpsertRateParams params);

  DomainServiceType<PaginatedData<RateEntity>> getRating(GetRatingsParams params);
}
