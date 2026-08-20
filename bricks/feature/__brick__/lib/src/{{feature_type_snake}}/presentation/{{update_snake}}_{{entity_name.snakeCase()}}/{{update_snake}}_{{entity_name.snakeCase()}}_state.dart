part of '{{update_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{update_pascal}}{{entity_name.pascalCase()}}State extends Equatable {
  final Async<{{entity_type_pascal}}Entity> {{update_camel}}{{entity_name.pascalCase()}}State;
  final {{upsert_pascal}}{{entity_name.pascalCase()}}Params params;

  const {{update_pascal}}{{entity_name.pascalCase()}}State({required this.{{update_camel}}{{entity_name.pascalCase()}}State, required this.params});

  factory {{update_pascal}}{{entity_name.pascalCase()}}State.initial() {
    return {{update_pascal}}{{entity_name.pascalCase()}}State({{update_camel}}{{entity_name.pascalCase()}}State: const Async.initial(), params: {{upsert_pascal}}{{entity_name.pascalCase()}}Params.initial());
  }

  {{update_pascal}}{{entity_name.pascalCase()}}State copyWith({Async<{{entity_type_pascal}}Entity>? {{update_camel}}{{entity_name.pascalCase()}}State, {{upsert_pascal}}{{entity_name.pascalCase()}}Params? params}) {
    return {{update_pascal}}{{entity_name.pascalCase()}}State(
      {{update_camel}}{{entity_name.pascalCase()}}State: {{update_camel}}{{entity_name.pascalCase()}}State ?? this.{{update_camel}}{{entity_name.pascalCase()}}State,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [{{update_camel}}{{entity_name.pascalCase()}}State, params];
}


