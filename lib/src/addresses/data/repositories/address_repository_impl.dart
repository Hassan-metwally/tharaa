import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/params/address_params.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';
import '../models/api_location_model.dart';

@Injectable(as: AddressRepository)
class AddressRepositoryImpl extends AddressRepository {
  final DioHelper _dioHelper;

  AddressRepositoryImpl(this._dioHelper);

  @override
  DomainServiceType<LocationEntity> addLocation(AddressParams params) async {
    return await failureCollect(() async {
      final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('addresses'), body: params.toMap());
      final location = ApiLocationModel.fromJson(response['data']['address']).map;
      return Right(location);
    });
  }

  @override
  DomainServiceType<void> deleteLocation(DeleteLocationParams params) async {
    return await failureCollect(() async {
      await _dioHelper.delete(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'));
      return const Right(null);
    });
  }

  @override
  DomainServiceType<PaginatedData<LocationEntity>> getAddresses(GetAddressesParams params) async {
    return await failureCollect(() async {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('addresses'), queryParameters: params.toMap());
      final apiPaginatedData = ApiPaginatedData.fromJson(
        response['data'],
        getData: (data) => data.map((element) => ApiLocationModel.fromJson(element)).toList(),
      );
      final data = apiPaginatedData.map((e) => e.map);
      return Right(data);
    });
  }

  @override
  DomainServiceType<LocationEntity> updateAdressInAdressList(AddressParams params) async {
    final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'), body: params.toMap());
    final location = ApiLocationModel.fromJson(response['data']['address']).map;
    return Right(location);
  }
}
