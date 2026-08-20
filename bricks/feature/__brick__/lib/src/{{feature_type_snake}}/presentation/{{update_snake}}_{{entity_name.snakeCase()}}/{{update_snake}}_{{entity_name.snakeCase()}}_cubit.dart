import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
import '../../domain/usecases/{{update_snake}}_{{entity_name.snakeCase()}}_usecase.dart';

part '{{update_snake}}_{{entity_name.snakeCase()}}_state.dart';

@injectable
class {{update_pascal}}{{entity_name.pascalCase()}}Cubit extends Cubit<{{update_pascal}}{{entity_name.pascalCase()}}State> {
  final {{update_pascal}}{{entity_name.pascalCase()}}Usecase _{{update_camel}}{{entity_name.pascalCase()}}Usecase;

  {{update_pascal}}{{entity_name.pascalCase()}}Cubit(this._{{update_camel}}{{entity_name.pascalCase()}}Usecase) : super({{update_pascal}}{{entity_name.pascalCase()}}State.initial());

  void setInitialParams({{entity_type_pascal}}Entity? {{entity_name.camelCase()}}Entity) {
    if ({{entity_name.camelCase()}}Entity == null) return;
    emit(state.copyWith(params: {{upsert_pascal}}{{entity_name.pascalCase()}}Params.fromEntity({{entity_name.camelCase()}}Entity)));
  }

  void {{update_camel}}{{entity_name.pascalCase()}}() async {
    emit(state.copyWith({{update_camel}}{{entity_name.pascalCase()}}State: const Async.loading()));
    final result = await _{{update_camel}}{{entity_name.pascalCase()}}Usecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith({{update_camel}}{{entity_name.pascalCase()}}State: Async.failure(failure))),
      (data) => emit(state.copyWith({{update_camel}}{{entity_name.pascalCase()}}State: Async.success(data))),
    );
  }

  void updateParams({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit({{update_pascal}}{{entity_name.pascalCase()}}State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}


