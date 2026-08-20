import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

@injectable
class {{toggle_pascal}}{{entity_name.pascalCase()}}StatusUseCase extends IUseCase<String, {{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams> {
  final {{feature_type_pascal}}Repository _repository;

  {{toggle_pascal}}{{entity_name.pascalCase()}}StatusUseCase(this._repository);
  @override
  Future<Either<Failure, String>> call({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params) {
    return _repository.{{toggle_camel}}{{entity_name.pascalCase()}}Status(params);
  }
}

class {{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams {
  final int id;
  final {{entity_name.pascalCase()}}StatusToggleActionEnum toggleAction;

  {{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams({
    required this.id,
    required this.toggleAction,
  });
}

enum {{entity_name.pascalCase()}}StatusToggleActionEnum { pay, cancel, makeAsSold, favorite }


