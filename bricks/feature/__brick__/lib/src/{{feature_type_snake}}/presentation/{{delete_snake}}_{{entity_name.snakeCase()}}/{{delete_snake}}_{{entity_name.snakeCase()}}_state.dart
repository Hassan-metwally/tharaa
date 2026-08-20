part of '{{delete_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{delete_pascal}}{{entity_name.pascalCase()}}State extends Equatable {
  final Async<String> {{delete_camel}}{{entity_name.pascalCase()}}State;
  const {{delete_pascal}}{{entity_name.pascalCase()}}State({required this.{{delete_camel}}{{entity_name.pascalCase()}}State});

  factory {{delete_pascal}}{{entity_name.pascalCase()}}State.initial() {
    return const {{delete_pascal}}{{entity_name.pascalCase()}}State({{delete_camel}}{{entity_name.pascalCase()}}State: Async.initial());
  }
  {{delete_pascal}}{{entity_name.pascalCase()}}State copyWith({Async<String>? {{delete_camel}}{{entity_name.pascalCase()}}State}) {
    return {{delete_pascal}}{{entity_name.pascalCase()}}State({{delete_camel}}{{entity_name.pascalCase()}}State: {{delete_camel}}{{entity_name.pascalCase()}}State ?? this.{{delete_camel}}{{entity_name.pascalCase()}}State);
  }

  @override
  List<Object> get props => [{{delete_camel}}{{entity_name.pascalCase()}}State];
}

