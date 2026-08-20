import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_details_entity.dart';
import '../../domain/usecases/{{show_snake}}_{{entity_name.snakeCase()}}_details_usecase.dart';

part '{{show_snake}}_{{entity_name.snakeCase()}}_details_state.dart';

@injectable
class {{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit extends Cubit<{{show_pascal}}{{entity_name.pascalCase()}}DetailsState> {
  final {{show_pascal}}{{entity_name.pascalCase()}}DetailsUsecase _{{show_camel}}{{entity_name.pascalCase()}}DetailsUsecase;
  {{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit(this._{{show_camel}}{{entity_name.pascalCase()}}DetailsUsecase) : super({{show_pascal}}{{entity_name.pascalCase()}}DetailsState.initial());

  Future<void> {{show_camel}}{{entity_name.pascalCase()}}Details(int id) async {
    emit(state.copyWith({{show_camel}}{{entity_name.pascalCase()}}State: const Async.loading()));
    final result = await _{{show_camel}}{{entity_name.pascalCase()}}DetailsUsecase(id);
    result.fold(
      (failure) => emit(state.copyWith({{show_camel}}{{entity_name.pascalCase()}}State: Async.failure(failure))),
      (data) => emit(state.copyWith({{show_camel}}{{entity_name.pascalCase()}}State: Async.success(data))),
    );
  }

  void change{{entity_name.pascalCase()}}Locally() {
      final {{entity_name.camelCase()}} = state.{{show_camel}}{{entity_name.pascalCase()}}State.data;
      if ({{entity_name.camelCase()}} != null) {
        emit(state.copyWith({{show_camel}}{{entity_name.pascalCase()}}State: Async.success({{entity_name.camelCase()}}.copyWith())));
      }
  }

  @override
  void emit({{show_pascal}}{{entity_name.pascalCase()}}DetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}


