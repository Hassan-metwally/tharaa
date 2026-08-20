import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/ad_entity.dart';
import '../repositories/ads_repository.dart';

@injectable
class GetAllAdsUsecase extends IUseCase<List<AdEntity>, NoParams> {
  final AdsRepository _repository;

  GetAllAdsUsecase(this._repository);

  @override
  Future<Either<Failure, List<AdEntity>>> call(NoParams params) {
    return _repository.getAllAds(params);
  }
}
