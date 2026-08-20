import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/core.dart';
import '../entities/{{entity_type_snake}}_entity.dart';
import '../repositories/{{feature_type_snake}}_repository.dart';

@injectable
class {{get_pascal}}{{feature_name.pascalCase()}}Usecase extends IUseCase<PaginatedData<{{entity_type_pascal}}Entity>, {{get_pascal}}{{feature_name.pascalCase()}}Params> {
  final {{feature_type_pascal}}Repository _repository;

  {{get_pascal}}{{feature_name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Either<Failure, PaginatedData<{{entity_type_pascal}}Entity>>> call({{get_pascal}}{{feature_name.pascalCase()}}Params params) {
    return _repository.{{get_camel}}{{feature_name.pascalCase()}}(params);
  }
}

class {{get_pascal}}{{feature_name.pascalCase()}}Params extends Equatable{
  final int page;

  const {{get_pascal}}{{feature_name.pascalCase()}}Params({required this.page});

  const {{get_pascal}}{{feature_name.pascalCase()}}Params.initial() : this(page: 1);

  {{get_pascal}}{{feature_name.pascalCase()}}Params copyWith({int? page}) {
    return {{get_pascal}}{{feature_name.pascalCase()}}Params(page: page ?? this.page);
  }

  Map<String, dynamic> get toMap => {'page': page};
  @override
  List<Object?> get props => [page];    
}


