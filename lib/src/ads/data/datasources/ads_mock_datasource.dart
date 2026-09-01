import '../../../../core/core.dart';
import '../../domain/entities/ad_entity.dart';
import '../models/api_ad_model.dart';
import 'ads_datasource.dart';

// @Injectable(as: AdsDatasource)
class AdsMockDatasource extends AdsDatasource {
  @override
  Future<List<ApiAdModel>> getAllAds(NoParams params) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return [
      ApiAdModel(
        id: 1,
        name: 'Summer Banner',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&h=400&q=80',
        ),
        type: AdType.product,
        linkableId: 6,
        externalUrl: null,
      ),
      ApiAdModel(
        id: 2,
        name: 'Fresh Vegetables',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?auto=format&fit=crop&w=800&h=400&q=80',
        ),
        type: AdType.category,
        linkableId: 1,
        externalUrl: null,
      ),
      ApiAdModel(
        id: 3,
        name: 'Summer Banner',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&w=800&h=400&q=80',
        ),
        type: AdType.external,
        linkableId: null,
        externalUrl: 'https://docs.google.com/document/d/1uwqLpKPkg3zyxBgHoJHsr_R1Eo_P12F4/edit',
      ),
    ];
  }
}
