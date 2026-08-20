import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../common/domain/entity/users/client_entity.dart';
import '../repository/client_more_repository.dart';

@Injectable()
class GetProfileUseCase extends IUseCase<ClientEntity, NoParams> {
  final MoreRepository _repository;

  GetProfileUseCase(this._repository);
  @override
  Future<Either<Failure, ClientEntity>> call(NoParams params) async {
    return await _repository.getProfileData();
  }
}
