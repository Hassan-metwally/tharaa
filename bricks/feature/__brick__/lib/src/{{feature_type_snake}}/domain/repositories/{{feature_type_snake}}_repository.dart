import '../../../../../../core/core.dart';
{{#with_show}}
import '../entities/{{entity_type_snake}}_details_entity.dart';
{{/with_show}}
import '../entities/{{entity_type_snake}}_entity.dart';
{{#with_add}}
import '../usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_add}}
{{^with_add}}
{{#with_update}}
import '../usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_update}}
{{^with_update}}
{{#with_upsert}}
import '../usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{/with_upsert}}
{{/with_update}}
{{/with_add}}
{{#get_paginated_data}}
import '../usecases/{{get_snake}}_{{feature_name.snakeCase()}}_usecase.dart';
{{/get_paginated_data}}
{{#with_toggle_status}}
import '../usecases/{{toggle_snake}}_{{entity_name.snakeCase()}}_status_usecase.dart';
{{/with_toggle_status}}

abstract class {{feature_type_pascal}}Repository {
  {{#with_add}}
  DomainServiceType<{{entity_type_pascal}}Entity> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_add}}
  {{^with_add}}
  {{#with_upsert}}
  DomainServiceType<{{entity_type_pascal}}Entity> {{add_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_upsert}}
  {{/with_add}}
  {{#with_update}}
  DomainServiceType<{{entity_type_pascal}}Entity> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_update}}
  {{^with_update}}
  {{#with_upsert}}
  DomainServiceType<{{entity_type_pascal}}Entity> {{update_camel}}{{entity_name.pascalCase()}}({{upsert_pascal}}{{entity_name.pascalCase()}}Params params);
  {{/with_upsert}}
  {{/with_update}}
  {{#with_show}}
  DomainServiceType<{{entity_type_pascal}}DetailsEntity> {{show_camel}}{{entity_name.pascalCase()}}Details(int id);
  {{/with_show}}
  {{#get_paginated_data}}
  DomainServiceType<PaginatedData<{{entity_type_pascal}}Entity>> {{get_camel}}{{feature_name.pascalCase()}}({{get_pascal}}{{feature_name.pascalCase()}}Params params);
  {{/get_paginated_data}}
  {{#get_list_without_pagination}}
  DomainServiceType<List<{{entity_type_pascal}}Entity>> {{get_list_without_pagination_camel}}{{feature_name.pascalCase()}}(NoParams params);
  {{/get_list_without_pagination}}
  {{#with_delete}}
  DomainServiceType<String> {{delete_camel}}{{entity_name.pascalCase()}}(int id);
  {{/with_delete}}
  {{#with_toggle_status}}
  DomainServiceType<String> {{toggle_camel}}{{entity_name.pascalCase()}}Status({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params);
  {{/with_toggle_status}}
}

