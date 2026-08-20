part of '{{show_snake}}_{{entity_name.snakeCase()}}_details_cubit.dart';

class {{show_pascal}}{{entity_name.pascalCase()}}DetailsState extends Equatable {
  final Async<{{entity_type_pascal}}DetailsEntity> {{show_camel}}{{entity_name.pascalCase()}}State;
  const {{show_pascal}}{{entity_name.pascalCase()}}DetailsState({required this.{{show_camel}}{{entity_name.pascalCase()}}State});

  factory {{show_pascal}}{{entity_name.pascalCase()}}DetailsState.initial() {
    return const {{show_pascal}}{{entity_name.pascalCase()}}DetailsState({{show_camel}}{{entity_name.pascalCase()}}State: Async.initial());
  }

  {{show_pascal}}{{entity_name.pascalCase()}}DetailsState copyWith({Async<{{entity_type_pascal}}DetailsEntity>? {{show_camel}}{{entity_name.pascalCase()}}State}) {
    return {{show_pascal}}{{entity_name.pascalCase()}}DetailsState({{show_camel}}{{entity_name.pascalCase()}}State: {{show_camel}}{{entity_name.pascalCase()}}State ?? this.{{show_camel}}{{entity_name.pascalCase()}}State);
  }

  @override
  List<Object> get props => [{{show_camel}}{{entity_name.pascalCase()}}State];
}


