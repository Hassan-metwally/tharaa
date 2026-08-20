import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entity/city_entity.dart';
import '../repository/common_repository.dart';

@injectable
class GetCitiesUseCase extends IUseCase<List<CityEntity>, NoParams> {
  final CommonRepository _repository;

  GetCitiesUseCase(this._repository);
  @override
  Future<Either<Failure, List<CityEntity>>> call(NoParams params) async {
    return await _repository.getCities();
  }
}
