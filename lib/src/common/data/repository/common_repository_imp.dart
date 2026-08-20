import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entity/city_entity.dart';
import '../../domain/entity/common_entity.dart';
import '../../domain/repository/common_repository.dart';
import '../datasources/common_datasource.dart';
import '../models/api_city_model.dart';
import '../models/api_common_model.dart';

@Injectable(as: CommonRepository)
class CommonRepositoryImp implements CommonRepository {
  final CommonDatasource _dataSource;

  const CommonRepositoryImp(this._dataSource);

  @override
  DomainServiceType<AppLanguageEnum> changeLanguage(AppLanguageEnum lang) {
    return failureCollect(() async {
      await _dataSource.changeLanguage(lang);
      return Right(lang);
    });
  }

  @override
  DomainServiceType<List<CityEntity>> getCities() async {
    return await failureCollect(() async {
      final cities = await _dataSource.getCities();
      return Right(cities.map((e) => e.map).toList());
    });
  }

  @override
  DomainServiceType<List<CommonEntity>> getServices() async {
    return await failureCollect(() async {
      final services = await _dataSource.getServices();
      return Right(services.map((e) => e.map).toList());
    });
  }

  @override
  DomainServiceType<List<CommonEntity>> getBanks() async {
    return await failureCollect(() async {
      final banks = await _dataSource.getBanks();
      return Right(banks.map((e) => e.map).toList());
    });
  }
}
