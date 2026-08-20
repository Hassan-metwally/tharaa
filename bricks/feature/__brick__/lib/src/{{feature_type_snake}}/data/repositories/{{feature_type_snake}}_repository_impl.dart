import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
{{#with_show}}
import '../../domain/entities/{{entity_type_snake}}_details_entity.dart';
{{/with_show}}
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
import '../../domain/repositories/{{feature_type_snake}}_repository.dart';
{{#with_add}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_add}}
{{^with_add}}
{{#with_update}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_update}}
{{^with_update}}
{{#with_upsert}}
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_upsert}}
{{/with_update}}
{{/with_add}}
{{#get_paginated_data}}
import '../../domain/usecases/{{get_snake}}_{{feature_name.snakeCase()}}_usecase.dart';
{{/get_paginated_data}}
{{#with_toggle_status}}
import '../../domain/usecases/{{toggle_snake}}_{{entity_name.snakeCase()}}_status_usecase.dart';
{{/with_toggle_status}}
import '../datasources/{{feature_type_snake}}_datasource.dart';
{{#with_show}}
import '../models/{{api_model_type_snake}}_details_model.dart';
{{/with_show}}
import '../models/{{api_model_type_snake}}_model.dart';

@Injectable(as: {{feature_type_pascal}}Repository)
class {{feature_type_pascal}}RepositoryImpl extends {{feature_type_pascal}}Repository {
  final {{feature_type_pascal}}Datasource _dataSource;

  {{feature_type_pascal}}RepositoryImpl(this._dataSource);

  {{#with_add}}
  @override
  DomainServiceType<{{entity_type_pascal}}Entity> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{add_camel}}{{entity_name.pascalCase()}}(params);
      return Right(result.map);
    });
  }
  {{/with_add}}
  {{^with_add}}
  {{#with_upsert}}
  @override
  DomainServiceType<{{entity_type_pascal}}Entity> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{add_camel}}{{entity_name.pascalCase()}}(params);
      return Right(result.map);
    });
  }
  {{/with_upsert}}
  {{/with_add}}

  {{#with_delete}}
  @override
  DomainServiceType<String> {{delete_camel}}{{entity_name.pascalCase()}}(int id) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{delete_camel}}{{entity_name.pascalCase()}}(id);
      return Right(result);
    });
  }
  {{/with_delete}}

  {{#with_show}}
  @override
  DomainServiceType<{{entity_type_pascal}}DetailsEntity> {{show_camel}}{{entity_name.pascalCase()}}Details(int id) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{show_camel}}{{entity_name.pascalCase()}}Details(id);
      return Right(result.map);
    });
  }
  {{/with_show}}

  {{#get_paginated_data}}
  @override
  DomainServiceType<PaginatedData<{{entity_type_pascal}}Entity>> {{get_camel}}{{feature_name.pascalCase()}}({{get_pascal}}{{feature_name.pascalCase()}}Params params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{get_camel}}{{feature_name.pascalCase()}}(params);

      return Right(result.map((data) => data.map));
    });
  }
  {{/get_paginated_data}}
  {{#get_list_without_pagination}}
  @override
  DomainServiceType<List<{{entity_type_pascal}}Entity>> {{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(NoParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(params);

      return Right(result.map((data) => data.map).toList());
    });
  }
  {{/get_list_without_pagination}}

  {{#with_update}}
  @override
  DomainServiceType<{{entity_type_pascal}}Entity> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{update_camel}}{{entity_name.pascalCase()}}(params);
      return Right(result.map);
    });
  }
  {{/with_update}}
  {{^with_update}}
  {{#with_upsert}}
  @override
  DomainServiceType<{{entity_type_pascal}}Entity> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{update_camel}}{{entity_name.pascalCase()}}(params);
      return Right(result.map);
    });
  }
  {{/with_upsert}}
  {{/with_update}}

  {{#with_toggle_status}}
  @override
  DomainServiceType<String> {{toggle_camel}}{{entity_name.pascalCase()}}Status({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params) async {
    return await failureCollect(() async {
      final result = await _dataSource.{{toggle_camel}}{{entity_name.pascalCase()}}Status(params);
      return Right(result);
    });
  }
  {{/with_toggle_status}}
}

