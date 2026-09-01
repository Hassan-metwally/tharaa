import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/location_entity.dart';
import '../repositories/address_repository.dart';

@Injectable()
class GetAddressesUseCase extends IUseCase<PaginatedData<LocationEntity>, GetAddressesParams> {
  final AddressRepository _repository;

  GetAddressesUseCase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<LocationEntity>>> call(GetAddressesParams params) async => await _repository.getAddresses(params);
}

class GetAddressesParams extends Equatable {
  final int page;
  final int? limit;

  const GetAddressesParams({required this.page, this.limit});

  @override
  List<Object?> get props => [page, limit];

  Map<String, dynamic> toMap() => {'page': page, if (limit != null) 'per_page': limit};
}
