import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_address_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';
import '../../domain/usecases/set_default_address_use_case.dart';
import '../models/api_location_model.dart';

abstract class AddressDatasource {
  Future<ApiPaginatedData<ApiLocationModel>> getAddresses(GetAddressesParams params);
  Future<ApiLocationModel> getAddress(GetAddressParams params);
  Future<ApiLocationModel> addLocation(AddressParams params);
  Future<ApiLocationModel> updateAddress(AddressParams params);
  Future<ApiLocationModel> setDefaultAddress(SetDefaultAddressParams params);
  Future<void> deleteLocation(DeleteLocationParams params);
}

@Injectable(as: AddressDatasource)
class AddressDatasourceImpl extends AddressDatasource {
  final DioHelper _dioHelper;

  AddressDatasourceImpl(this._dioHelper);

  @override
  Future<ApiPaginatedData<ApiLocationModel>> getAddresses(GetAddressesParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('addresses'), queryParameters: params.toMap());
      return ApiPaginatedData.fromJson(
        response['data'],
        getData: (data) => data.map((element) => ApiLocationModel.fromJson(element)).toList(),
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiLocationModel> getAddress(GetAddressParams params) async {
    try {
      final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'));
      return ApiLocationModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiLocationModel> addLocation(AddressParams params) async {
    try {
      final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('addresses'), body: params.toMap());
      return ApiLocationModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiLocationModel> updateAddress(AddressParams params) async {
    try {
      final response = await _dioHelper.put(
        url: ApiConstants.addToApiUrlPath('addresses/${params.id}'),
        body: params.toMap(),
      );
      return ApiLocationModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiLocationModel> setDefaultAddress(SetDefaultAddressParams params) async {
    try {
      final response = await _dioHelper.put(url: ApiConstants.addToApiUrlPath('addresses/${params.id}/default'));
      return ApiLocationModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteLocation(DeleteLocationParams params) async {
    await _dioHelper.delete(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'));
  }
}
