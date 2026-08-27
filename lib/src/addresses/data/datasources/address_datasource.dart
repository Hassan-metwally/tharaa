import '../../../../core/core.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';
import '../models/api_location_model.dart';

abstract class AddressDatasource {
  Future<ApiPaginatedData<ApiLocationModel>> getAddresses(GetAddressesParams params);
  Future<ApiLocationModel> addLocation(AddressParams params);
  Future<ApiLocationModel> updateAddress(AddressParams params);
  Future<void> deleteLocation(DeleteLocationParams params);
}

class AddressDatasourceImpl extends AddressDatasource {
  final DioHelper _dioHelper;

  AddressDatasourceImpl(this._dioHelper);

  @override
  Future<ApiPaginatedData<ApiLocationModel>> getAddresses(GetAddressesParams params) async {
    final response = await _dioHelper.get(url: ApiConstants.addToApiUrlPath('addresses'), queryParameters: params.toMap());
    return ApiPaginatedData.fromJson(
      response['data'],
      getData: (data) => data.map((element) => ApiLocationModel.fromJson(element)).toList(),
    );
  }

  @override
  Future<ApiLocationModel> addLocation(AddressParams params) async {
    final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('addresses'), body: params.toMap());
    return ApiLocationModel.fromJson(response['data']['address']);
  }

  @override
  Future<ApiLocationModel> updateAddress(AddressParams params) async {
    final response = await _dioHelper.post(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'), body: params.toMap());
    return ApiLocationModel.fromJson(response['data']['address']);
  }

  @override
  Future<void> deleteLocation(DeleteLocationParams params) async {
    await _dioHelper.delete(url: ApiConstants.addToApiUrlPath('addresses/${params.id}'));
  }
}
