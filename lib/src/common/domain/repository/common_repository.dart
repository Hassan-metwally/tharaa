import '../../../../core/core.dart';
import '../entity/city_entity.dart';
import '../entity/common_entity.dart';

abstract class CommonRepository {
  DomainServiceType<AppLanguageEnum> changeLanguage(AppLanguageEnum lang);
  DomainServiceType<List<CityEntity>> getCities();
  DomainServiceType<List<CommonEntity>> getServices();
  DomainServiceType<List<CommonEntity>> getBanks();
}
