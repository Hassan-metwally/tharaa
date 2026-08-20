import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../entities/{{entity_type_snake}}_entity.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

@injectable
class {{get_list_without_pagination_pascal}}{{feature_name.pascalCase()}}Usecase extends IUseCase<List<{{entity_type_pascal}}Entity>, NoParams> {
  final {{feature_type_pascal}}Repository _repository;

  {{get_list_without_pagination_pascal}}{{feature_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, List<{{entity_type_pascal}}Entity>>> call(
    NoParams params,
  ) {
    return _repository.{{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(params);
  }
}
