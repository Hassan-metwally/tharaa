import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/data/models/users/api_client_model.dart';
import '../../../common/domain/entity/users/client_entity.dart';
import '../../domain/repository/client_more_repository.dart';
import '../../domain/use_cases/update_profile_use_case.dart';

@Injectable(as: MoreRepository)
class MoreRepositoryImp implements MoreRepository {
  final DioHelper _apiHelper;
  final SecureStorageRepository _secureStorage;

  const MoreRepositoryImp(this._apiHelper, this._secureStorage);
  @override
  DomainServiceType<ClientEntity> getProfileData() async {
    return await failureCollect<ClientEntity>(() async {
      final result = await _apiHelper.get(url: ApiConstants.addToApiUrlPath("auth/profile"));
      final data = ApiClientModel.fromJson(result['data']);
      return Right(data.map);
    });
  }

  @override
  DomainServiceType<ClientEntity> updateProfileData(UpdateProfileParams params) async {
    return await failureCollect<ClientEntity>(() async {
      final result = await _apiHelper.post(url: ApiConstants.addToApiUrlPath("auth/update-profile"), body: params.toMap);
      final ClientEntity data = ApiClientModel.fromJson(List.from(result['data']).firstOrNull).map;

      await _secureStorage.setCachedUser(data.mapToCacheEntity);
      return Right(data);
    });
  }
}
