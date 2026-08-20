import '../../../../../../core/core.dart';
import '../entities/ad_entity.dart';

abstract class AdsRepository {
  DomainServiceType<List<AdEntity>> getAllAds(NoParams params);
}
