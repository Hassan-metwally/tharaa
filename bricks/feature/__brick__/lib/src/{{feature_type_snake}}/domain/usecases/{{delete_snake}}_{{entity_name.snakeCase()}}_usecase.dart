import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

@injectable
class {{delete_pascal}}{{entity_name.pascalCase()}}Usecase extends IUseCase<String, int> {
  final {{feature_type_pascal}}Repository _repository;

  {{delete_pascal}}{{entity_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, String>> call(int id) {
    return _repository.{{delete_camel}}{{entity_name.pascalCase()}}(id);
  }
}


