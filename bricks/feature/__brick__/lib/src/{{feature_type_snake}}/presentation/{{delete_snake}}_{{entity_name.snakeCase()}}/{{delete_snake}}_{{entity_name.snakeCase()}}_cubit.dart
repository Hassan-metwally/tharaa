import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/usecases/{{delete_snake}}_{{entity_name.snakeCase()}}_usecase.dart';

part '{{delete_snake}}_{{entity_name.snakeCase()}}_state.dart';

@injectable
class {{delete_pascal}}{{entity_name.pascalCase()}}Cubit extends Cubit<{{delete_pascal}}{{entity_name.pascalCase()}}State> {
  final {{delete_pascal}}{{entity_name.pascalCase()}}Usecase _{{delete_camel}}{{entity_name.pascalCase()}}usecase;

  {{delete_pascal}}{{entity_name.pascalCase()}}Cubit(this._{{delete_camel}}{{entity_name.pascalCase()}}usecase) : super({{delete_pascal}}{{entity_name.pascalCase()}}State.initial());

  void {{delete_camel}}(int id) async {
    emit(state.copyWith({{delete_camel}}{{entity_name.pascalCase()}}State: const Async.loading()));
    final result = await _{{delete_camel}}{{entity_name.pascalCase()}}usecase(id);
    result.fold(
      (failure) => emit(state.copyWith({{delete_camel}}{{entity_name.pascalCase()}}State: Async.failure(failure))),
      (data) => emit(state.copyWith({{delete_camel}}{{entity_name.pascalCase()}}State: Async.success(data))),
    );
  }

  @override
  void emit({{delete_pascal}}{{entity_name.pascalCase()}}State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

