import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/location_entity.dart';
import '../repositories/address_repository.dart';

@Injectable()
class GetAddressUseCase extends IUseCase<LocationEntity, GetAddressParams> {
  final AddressRepository _repository;

  GetAddressUseCase(this._repository);

  @override
  Future<Either<Failure, LocationEntity>> call(GetAddressParams params) async => await _repository.getAddress(params);
}

class GetAddressParams extends Equatable {
  final int id;

  const GetAddressParams({required this.id});

  @override
  List<Object?> get props => [id];
}
