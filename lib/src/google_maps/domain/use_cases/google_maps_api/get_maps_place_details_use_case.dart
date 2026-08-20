import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../entities/address_entity.dart';
import '../../repository/maps_repository.dart';

@Injectable()
class GetMapsPlaceDetailsUseCase extends IUseCase<MapAddressEntity, GetMapsPlaceDetailsParams> {
  final MapsRepository _repository;
  GetMapsPlaceDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, MapAddressEntity>> call(GetMapsPlaceDetailsParams params) async {
    return await _repository.getPlaceDetails(params.placeID);
  }
}

class GetMapsPlaceDetailsParams extends NoParams {
  final String placeID;

  GetMapsPlaceDetailsParams({required this.placeID});
}
