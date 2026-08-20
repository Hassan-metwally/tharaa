part of '{{toggle_snake}}_{{entity_name.snakeCase()}}_status_cubit.dart';

class {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState extends Equatable {
  final Async<String> {{toggle_camel}}{{entity_name.pascalCase()}}StatusState;

  const {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState({required this.{{toggle_camel}}{{entity_name.pascalCase()}}StatusState});

  const {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState.initial() : {{toggle_camel}}{{entity_name.pascalCase()}}StatusState = const Async.initial();

  {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState copyWith({
    Async<String>? {{toggle_camel}}{{entity_name.pascalCase()}}StatusState,
  }) {
    return {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState(
      {{toggle_camel}}{{entity_name.pascalCase()}}StatusState: {{toggle_camel}}{{entity_name.pascalCase()}}StatusState ?? this.{{toggle_camel}}{{entity_name.pascalCase()}}StatusState,
    );
  }

  @override
  List<Object> get props => [{{toggle_camel}}{{entity_name.pascalCase()}}StatusState];
}

