part of '{{upsert_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{upsert_pascal}}{{entity_name.pascalCase()}}State extends Equatable {
  final Async<{{entity_type_pascal}}Entity> {{upsert_camel}}{{entity_name.pascalCase()}}State;
  final {{upsert_pascal}}{{entity_name.pascalCase()}}Params params;

  const {{upsert_pascal}}{{entity_name.pascalCase()}}State({required this.{{upsert_camel}}{{entity_name.pascalCase()}}State, required this.params});

  factory {{upsert_pascal}}{{entity_name.pascalCase()}}State.initial() {
    return {{upsert_pascal}}{{entity_name.pascalCase()}}State({{upsert_camel}}{{entity_name.pascalCase()}}State: const Async.initial(), params: {{upsert_pascal}}{{entity_name.pascalCase()}}Params.initial());
  }

  {{upsert_pascal}}{{entity_name.pascalCase()}}State copyWith({Async<{{entity_type_pascal}}Entity>? {{upsert_camel}}{{entity_name.pascalCase()}}State, {{upsert_pascal}}{{entity_name.pascalCase()}}Params? params}) {
    return {{upsert_pascal}}{{entity_name.pascalCase()}}State(
      {{upsert_camel}}{{entity_name.pascalCase()}}State: {{upsert_camel}}{{entity_name.pascalCase()}}State ?? this.{{upsert_camel}}{{entity_name.pascalCase()}}State,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [{{upsert_camel}}{{entity_name.pascalCase()}}State, params];
}


