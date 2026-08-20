import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../entities/address_entity.dart';
import '../../repository/maps_repository.dart';

@Injectable()
class GetMapLocationAddressUseCase extends IUseCase<MapAddressEntity, GetMapLocationAddressParams> {
  final MapsRepository _repository;
  GetMapLocationAddressUseCase(this._repository);
  @override
  Future<Either<Failure, MapAddressEntity>> call(GetMapLocationAddressParams params) async {
    return await _repository.getLocationAddress(params);
  }
}

class GetMapLocationAddressParams extends NoParams {
  final double lat;
  final double long;
  GetMapLocationAddressParams({required this.lat, required this.long});
}
