import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entity/common_entity.dart';
import '../repository/common_repository.dart';

@injectable
class GetServicesUseCase extends IUseCase<List<CommonEntity>, NoParams> {
  final CommonRepository _repository;

  GetServicesUseCase(this._repository);
  @override
  Future<Either<Failure, List<CommonEntity>>> call(NoParams params) async {
    return await _repository.getServices();
  }
}
