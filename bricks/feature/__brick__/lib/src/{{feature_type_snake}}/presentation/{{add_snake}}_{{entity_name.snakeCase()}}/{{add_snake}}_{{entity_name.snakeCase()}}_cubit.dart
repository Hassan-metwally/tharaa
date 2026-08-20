import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';

part '{{add_snake}}_{{entity_name.snakeCase()}}_state.dart';

@injectable
class {{add_pascal}}{{entity_name.pascalCase()}}Cubit extends Cubit<{{add_pascal}}{{entity_name.pascalCase()}}State> {
  final {{add_pascal}}{{entity_name.pascalCase()}}Usecase _{{add_camel}}{{entity_name.pascalCase()}}Usecase;

  {{add_pascal}}{{entity_name.pascalCase()}}Cubit(this._{{add_camel}}{{entity_name.pascalCase()}}Usecase) : super({{add_pascal}}{{entity_name.pascalCase()}}State.initial());

  void {{add_camel}}{{entity_name.pascalCase()}}() async {
    emit(state.copyWith({{add_camel}}{{entity_name.pascalCase()}}State: const Async.loading()));
    final result = await _{{add_camel}}{{entity_name.pascalCase()}}Usecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith({{add_camel}}{{entity_name.pascalCase()}}State: Async.failure(failure))),
      (data) => emit(state.copyWith({{add_camel}}{{entity_name.pascalCase()}}State: Async.success(data))),
    );
  }

  void updateParams({{upsert_pascal}}{{entity_name.pascalCase()}}Params params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit({{add_pascal}}{{entity_name.pascalCase()}}State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}


