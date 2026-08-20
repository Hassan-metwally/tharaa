import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/core.dart';
import '../../domain/usecases/{{toggle_snake}}_{{entity_name.snakeCase()}}_status_usecase.dart';
part '{{toggle_snake}}_{{entity_name.snakeCase()}}_status_state.dart';

@injectable
class {{toggle_pascal}}{{entity_name.pascalCase()}}StatusCubit extends Cubit<{{toggle_pascal}}{{entity_name.pascalCase()}}StatusState> {
  final {{toggle_pascal}}{{entity_name.pascalCase()}}StatusUseCase _{{toggle_camel}}{{entity_name.pascalCase()}}StatusUseCase;
  {{toggle_pascal}}{{entity_name.pascalCase()}}StatusCubit(this._{{toggle_camel}}{{entity_name.pascalCase()}}StatusUseCase) : super(const {{toggle_pascal}}{{entity_name.pascalCase()}}StatusState.initial());

  Future<void> {{toggle_camel}}{{entity_name.pascalCase()}}Status({{toggle_pascal}}{{entity_name.pascalCase()}}StatusParams params) async {
    emit(state.copyWith({{toggle_camel}}{{entity_name.pascalCase()}}StatusState: const Async.loading()));
    final result = await _{{toggle_camel}}{{entity_name.pascalCase()}}StatusUseCase(params);
    result.fold(
      (failure) => emit(state.copyWith({{toggle_camel}}{{entity_name.pascalCase()}}StatusState: Async.failure(failure))),
      (data) => emit(state.copyWith({{toggle_camel}}{{entity_name.pascalCase()}}StatusState: Async.success(data))),
    );
  }

  @override
  void emit({{toggle_pascal}}{{entity_name.pascalCase()}}StatusState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

