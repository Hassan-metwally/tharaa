part of '{{feature_type_snake}}_cubit.dart';

class {{feature_type_pascal}}State extends Equatable {
  final Async<List<{{entity_type_pascal}}Entity>> {{active_get_camel}}{{feature_name.pascalCase()}}State;
  {{#active_get_is_paginated}}
  final {{get_pascal}}{{feature_name.pascalCase()}}Params params;
  final int currentPage;
  final int lastPage;
  {{/active_get_is_paginated}}
  const {{feature_type_pascal}}State({
    required this.{{active_get_camel}}{{feature_name.pascalCase()}}State,
    {{#active_get_is_paginated}}
    required this.params,
    this.currentPage = 1,
    this.lastPage = 1,
    {{/active_get_is_paginated}}
  });

  factory {{feature_type_pascal}}State.initial() {
    return const {{feature_type_pascal}}State(
      {{active_get_camel}}{{feature_name.pascalCase()}}State: Async.initial(),
      {{#active_get_is_paginated}}
      params: {{get_pascal}}{{feature_name.pascalCase()}}Params.initial(),
      {{/active_get_is_paginated}}
    );
  }

  {{feature_type_pascal}}State copyWith({
    Async<List<{{entity_type_pascal}}Entity>>? {{active_get_camel}}{{feature_name.pascalCase()}}State,
    {{#active_get_is_paginated}}
    {{get_pascal}}{{feature_name.pascalCase()}}Params? params,
    int? currentPage,
    int? lastPage,
    {{/active_get_is_paginated}}
  }) {
    return {{feature_type_pascal}}State(
      {{active_get_camel}}{{feature_name.pascalCase()}}State: {{active_get_camel}}{{feature_name.pascalCase()}}State ?? this.{{active_get_camel}}{{feature_name.pascalCase()}}State,
      {{#active_get_is_paginated}}
      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      {{/active_get_is_paginated}}
    );
  }

  @override
  List<Object> get props => [
        {{active_get_camel}}{{feature_name.pascalCase()}}State,
        {{#active_get_is_paginated}}
        params,
        currentPage,
        lastPage,
        {{/active_get_is_paginated}}
      ];
}

