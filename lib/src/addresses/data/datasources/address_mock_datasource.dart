import '../../../../core/core.dart';
import '../../domain/params/address_params.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../../domain/usecases/get_address_use_case.dart';
import '../../domain/usecases/get_addresses_use_case.dart';
import '../../domain/usecases/set_default_address_use_case.dart';
import '../models/api_location_model.dart';
import 'address_datasource.dart';

// @Injectable(as: AddressDatasource)
class AddressMockDatasource extends AddressDatasource {
  static const _delay = Duration(milliseconds: 400);
  static const _streetAddress = 'شارع الأمير محمد بن عبدالعزيز، حي العليا، الرياض 12241، المملكة العربية السعودية';
  static const _lat = '24.6934';
  static const _lng = '46.6850';

  static final List<ApiLocationModel> _addresses = [
    ApiLocationModel(
      id: 1,
      title: 'المنزل',
      description: _streetAddress,
      lat: _lat,
      lng: _lng,
      address: _streetAddress,
      isDefault: true,
    ),
    ApiLocationModel(
      id: 2,
      title: 'المنزل 2',
      description: _streetAddress,
      lat: _lat,
      lng: _lng,
      address: _streetAddress,
    ),
    ApiLocationModel(
      id: 3,
      title: 'العمل',
      description: _streetAddress,
      lat: _lat,
      lng: _lng,
      address: _streetAddress,
    ),
  ];

  @override
  Future<ApiPaginatedData<ApiLocationModel>> getAddresses(GetAddressesParams params) async {
    await Future<void>.delayed(_delay);
    return _paginate(_addresses, params.page, params.limit ?? 10);
  }

  @override
  Future<ApiLocationModel> getAddress(GetAddressParams params) async {
    await Future<void>.delayed(_delay);
    final address = _addresses.firstWhere((element) => element.id == params.id);
    return address;
  }

  @override
  Future<ApiLocationModel> addLocation(AddressParams params) async {
    await Future<void>.delayed(_delay);
    final int id = _addresses.isEmpty ? 1 : (_addresses.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
    final model = ApiLocationModel(
      id: id,
      title: params.building.text,
      description: params.district.text,
      lat: params.lat.toString(),
      lng: params.lng.toString(),
      address: params.address,
      isDefault: _addresses.isEmpty,
    );
    _addresses.add(model);
    return model;
  }

  @override
  Future<ApiLocationModel> updateAddress(AddressParams params) async {
    await Future<void>.delayed(_delay);
    final index = _addresses.indexWhere((element) => element.id == params.id);
    if (index == -1) {
      throw ServerException(message: 'Address not found');
    }

    if (params.isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        final item = _addresses[i];
        _addresses[i] = ApiLocationModel(
          id: item.id,
          title: item.title,
          description: item.description,
          lat: item.lat,
          lng: item.lng,
          address: item.address,
          isDefault: item.id == params.id,
        );
      }
    }

    final current = _addresses[index];
    final model = ApiLocationModel(
      id: current.id,
      title: params.building.text,
      description: params.district.text,
      lat: params.lat.toString(),
      lng: params.lng.toString(),
      address: params.address,
      isDefault: params.isDefault || current.isDefault,
    );
    _addresses[index] = model;
    return model;
  }

  @override
  Future<ApiLocationModel> setDefaultAddress(SetDefaultAddressParams params) async {
    await Future<void>.delayed(_delay);
    final index = _addresses.indexWhere((element) => element.id == params.id);
    if (index == -1) {
      throw ServerException(message: 'Address not found');
    }

    for (var i = 0; i < _addresses.length; i++) {
      final item = _addresses[i];
      _addresses[i] = ApiLocationModel(
        id: item.id,
        title: item.title,
        description: item.description,
        lat: item.lat,
        lng: item.lng,
        address: item.address,
        isDefault: item.id == params.id,
      );
    }

    return _addresses[index];
  }

  @override
  Future<void> deleteLocation(DeleteLocationParams params) async {
    await Future<void>.delayed(_delay);
    _addresses.removeWhere((element) => element.id == params.id);
    if (_addresses.isNotEmpty && !_addresses.any((element) => element.isDefault)) {
      final first = _addresses.first;
      _addresses[0] = ApiLocationModel(
        id: first.id,
        title: first.title,
        description: first.description,
        lat: first.lat,
        lng: first.lng,
        address: first.address,
        isDefault: true,
      );
    }
  }

  ApiPaginatedData<ApiLocationModel> _paginate(List<ApiLocationModel> items, int page, int perPage) {
    final lastPage = items.isEmpty ? 1 : (items.length / perPage).ceil();
    final start = (page - 1) * perPage;
    final pagedItems = start >= items.length ? const <ApiLocationModel>[] : items.skip(start).take(perPage).toList();

    return ApiPaginatedData(
      items: pagedItems,
      pageInfo: PageInfo(
        currentPage: page,
        lastPage: lastPage,
        totalPages: lastPage,
        countPerPage: perPage,
        totalItemsCount: items.length,
      ),
    );
  }
}
