import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_address_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';
import '../../domain/usecases/set_default_address_use_case.dart';
import '../datasources/address_datasource.dart';
import '../models/api_location_model.dart';

@Injectable(as: AddressRepository)
class AddressRepositoryImpl extends AddressRepository {
  final AddressDatasource _dataSource;

  AddressRepositoryImpl(this._dataSource);

  @override
  DomainServiceType<LocationEntity> addLocation(AddressParams params) async {
    return await failureCollect(() async {
      final location = await _dataSource.addLocation(params);
      return Right(location.map);
    });
  }

  @override
  DomainServiceType<void> deleteLocation(DeleteLocationParams params) async {
    return await failureCollect(() async {
      await _dataSource.deleteLocation(params);
      return const Right(null);
    });
  }

  @override
  DomainServiceType<PaginatedData<LocationEntity>> getAddresses(GetAddressesParams params) async {
    return await failureCollect(() async {
      final apiPaginatedData = await _dataSource.getAddresses(params);
      return Right(apiPaginatedData.map((e) => e.map));
    });
  }

  @override
  DomainServiceType<LocationEntity> getAddress(GetAddressParams params) async {
    return await failureCollect(() async {
      final location = await _dataSource.getAddress(params);
      return Right(location.map);
    });
  }

  @override
  DomainServiceType<LocationEntity> updateAdressInAdressList(AddressParams params) async {
    return await failureCollect(() async {
      final location = await _dataSource.updateAddress(params);
      return Right(location.map);
    });
  }

  @override
  DomainServiceType<LocationEntity> setDefaultAddress(SetDefaultAddressParams params) async {
    return await failureCollect(() async {
      final location = await _dataSource.setDefaultAddress(params);
      return Right(location.map);
    });
  }
}
