import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/{{entity_type_snake}}_entity.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';
import '{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';

{{#with_update}}
@injectable
class {{update_pascal}}{{entity_name.pascalCase()}}Usecase extends IUseCase<{{entity_type_pascal}}Entity, {{upsert_pascal}}{{entity_name.pascalCase()}}Params> {
  final {{feature_type_pascal}}Repository _repository;

  {{update_pascal}}{{entity_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, {{entity_type_pascal}}Entity>> call({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    return _repository.{{update_camel}}{{entity_name.pascalCase()}}(params);
  }
}
{{/with_update}}
{{^with_update}}
{{#with_upsert}}
@injectable
class {{update_pascal}}{{entity_name.pascalCase()}}Usecase extends IUseCase<{{entity_type_pascal}}Entity, {{upsert_pascal}}{{entity_name.pascalCase()}}Params> {
  final {{feature_type_pascal}}Repository _repository;

  {{update_pascal}}{{entity_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, {{entity_type_pascal}}Entity>> call({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    return _repository.{{update_camel}}{{entity_name.pascalCase()}}(params);
  }
}
{{/with_upsert}}
{{/with_update}}


