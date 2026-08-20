part of '{{add_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{add_pascal}}{{entity_name.pascalCase()}}State extends Equatable {
  final Async<{{entity_type_pascal}}Entity> {{add_camel}}{{entity_name.pascalCase()}}State;
  final {{upsert_pascal}}{{entity_name.pascalCase()}}Params params;

  const {{add_pascal}}{{entity_name.pascalCase()}}State({required this.{{add_camel}}{{entity_name.pascalCase()}}State, required this.params});

  factory {{add_pascal}}{{entity_name.pascalCase()}}State.initial() {
    return {{add_pascal}}{{entity_name.pascalCase()}}State({{add_camel}}{{entity_name.pascalCase()}}State: const Async.initial(), params: {{upsert_pascal}}{{entity_name.pascalCase()}}Params.initial());
  }

  {{add_pascal}}{{entity_name.pascalCase()}}State copyWith({Async<{{entity_type_pascal}}Entity>? {{add_camel}}{{entity_name.pascalCase()}}State, {{upsert_pascal}}{{entity_name.pascalCase()}}Params? params}) {
    return {{add_pascal}}{{entity_name.pascalCase()}}State(
      {{add_camel}}{{entity_name.pascalCase()}}State: {{add_camel}}{{entity_name.pascalCase()}}State ?? this.{{add_camel}}{{entity_name.pascalCase()}}State,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [{{add_camel}}{{entity_name.pascalCase()}}State, params];
}


