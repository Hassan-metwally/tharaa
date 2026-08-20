import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
import '../../domain/usecases/{{active_get_snake}}_{{feature_name.snakeCase()}}_usecase.dart';

part '{{feature_type_snake}}_state.dart';

@injectable
class {{feature_type_pascal}}Cubit extends Cubit<{{feature_type_pascal}}State> {
  final {{active_get_pascal}}{{feature_name.pascalCase()}}Usecase
      _{{active_get_camel}}{{feature_name.pascalCase()}}Usecase;
  {{feature_type_pascal}}Cubit(this._{{active_get_camel}}{{feature_name.pascalCase()}}Usecase)
      : super({{feature_type_pascal}}State.initial());

  Future<void> {{active_get_camel}}{{feature_name.pascalCase()}}() async {
    emit(
      state.copyWith(
        {{active_get_camel}}{{feature_name.pascalCase()}}State: const Async.loading(),
        {{#active_get_is_paginated}}
        currentPage: 1,
        {{/active_get_is_paginated}}
      ),
    );
    final result =
        await _{{active_get_camel}}{{feature_name.pascalCase()}}Usecase(
      {{#active_get_is_paginated}}
      state.params,
      {{/active_get_is_paginated}}
      {{^active_get_is_paginated}}
      NoParams(),
      {{/active_get_is_paginated}}
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          {{active_get_camel}}{{feature_name.pascalCase()}}State:
              Async.failure(failure),
        ),
      ),
      (data) => emit(
        state.copyWith(
          {{active_get_camel}}{{feature_name.pascalCase()}}State:
              Async.success(
            {{#active_get_is_paginated}}
            data.items,
            {{/active_get_is_paginated}}
            {{^active_get_is_paginated}}
            data,
            {{/active_get_is_paginated}}
          ),
          {{#active_get_is_paginated}}
          lastPage: data.pageInfo.lastPage,
          {{/active_get_is_paginated}}
        ),
      ),
    );
  }

  {{#active_get_is_paginated}}
  Future<void> {{get_camel}}More{{feature_name.pascalCase()}}() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith( 
      {{get_camel}}{{feature_name.pascalCase()}}State: Async.paginationLoading(state.{{get_camel}}{{feature_name.pascalCase()}}State.data ?? []),
      currentPage: state.currentPage + 1),
      );
    final result = await _{{get_camel}}{{feature_name.pascalCase()}}Usecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith({{get_camel}}{{feature_name.pascalCase()}}State: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith({{get_camel}}{{feature_name.pascalCase()}}State: Async.success([...state.{{get_camel}}{{feature_name.pascalCase()}}State.data ?? [], ...data.items]))),
    );
  }

  void updateParams({{get_pascal}}{{feature_name.pascalCase()}}Params params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: {{get_pascal}}{{feature_name.pascalCase()}}Params.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    {{get_camel}}{{feature_name.pascalCase()}}();
  }
  {{/active_get_is_paginated}}

  @override
  void emit({{feature_type_pascal}}State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}


