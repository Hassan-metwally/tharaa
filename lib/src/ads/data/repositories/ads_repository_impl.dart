import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';

import '../../domain/entities/ad_entity.dart';
import '../../domain/repositories/ads_repository.dart';

import '../datasources/ads_datasource.dart';

import '../models/api_ad_model.dart';

@Injectable(as: AdsRepository)
class AdsRepositoryImpl extends AdsRepository {
  final AdsDatasource _dataSource;

  AdsRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<List<AdEntity>> getAllAds(NoParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.getAllAds(params);

      return Right(result.map((data) => data.map).toList());
    });
  }
}
