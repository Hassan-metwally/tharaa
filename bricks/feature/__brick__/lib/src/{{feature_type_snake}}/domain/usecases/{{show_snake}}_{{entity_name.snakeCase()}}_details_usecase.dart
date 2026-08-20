import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/{{entity_type_snake}}_details_entity.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

@injectable
class {{show_pascal}}{{entity_name.pascalCase()}}DetailsUsecase extends IUseCase<{{entity_type_pascal}}DetailsEntity, int> {
  final {{feature_type_pascal}}Repository _repository;

  {{show_pascal}}{{entity_name.pascalCase()}}DetailsUsecase(this._repository);

  @override
  Future<Either<Failure, {{entity_type_pascal}}DetailsEntity>> call(int id) {
    return _repository.{{show_camel}}{{entity_name.pascalCase()}}Details(id);
  }
}


