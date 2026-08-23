import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../models/api_ad_model.dart';
import 'ads_datasource.dart';

@Injectable(as: AdsDatasource)
class AdsMockDatasource extends AdsDatasource {
  @override
  Future<List<ApiAdModel>> getAllAds(NoParams params) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return [
      ApiAdModel(
        id: 1,
        title: 'Fresh Vegetables Daily',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&h=400&q=80',
        ),
      ),
      ApiAdModel(
        id: 2,
        title: 'Tastiest Fresh Fruits',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?auto=format&fit=crop&w=800&h=400&q=80',
        ),
      ),
      ApiAdModel(
        id: 3,
        title: 'Market Special Offers',
        image: AttachmentEntity.fromNetwork(
          url: 'https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&w=800&h=400&q=80',
        ),
      ),
    ];
  }
}
