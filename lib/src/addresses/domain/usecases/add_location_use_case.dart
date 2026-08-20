import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/location_entity.dart';
import '../params/address_params.dart';
import '../repositories/address_repository.dart';

@Injectable()
class AddLocationUseCase extends IUseCase<LocationEntity, AddressParams> {
  final AddressRepository _repository;

  AddLocationUseCase(this._repository);

  @override
  Future<Either<Failure, LocationEntity>> call(AddressParams params) async => await _repository.addLocation(params);
}
