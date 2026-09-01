import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/location_entity.dart';
import '../repositories/address_repository.dart';

@Injectable()
class SetDefaultAddressUseCase extends IUseCase<LocationEntity, SetDefaultAddressParams> {
  final AddressRepository _repository;

  SetDefaultAddressUseCase(this._repository);

  @override
  Future<Either<Failure, LocationEntity>> call(SetDefaultAddressParams params) async =>
      await _repository.setDefaultAddress(params);
}

class SetDefaultAddressParams extends Equatable {
  final int id;

  const SetDefaultAddressParams({required this.id});

  @override
  List<Object?> get props => [id];
}
