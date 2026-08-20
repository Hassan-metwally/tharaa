import '../../../../core/core.dart';
import '../../../common/domain/entity/users/client_entity.dart';
import '../use_cases/update_profile_use_case.dart';

abstract class MoreRepository {
  DomainServiceType<ClientEntity> getProfileData();
  DomainServiceType<ClientEntity> updateProfileData(UpdateProfileParams params);
}
