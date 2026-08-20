import '../../../../core/core.dart';
import '../entities/location_entity.dart';
import '../params/address_params.dart';
import '../usecases/delete_location_use_case.dart';
import '../usecases/get_addresses_use_case.dart';

abstract class AddressRepository {
  DomainServiceType<PaginatedData<LocationEntity>> getAddresses(GetAddressesParams params);
  DomainServiceType<LocationEntity> addLocation(AddressParams params);
  DomainServiceType<LocationEntity> updateAdressInAdressList(AddressParams params);
  DomainServiceType<void> deleteLocation(DeleteLocationParams params);
}
