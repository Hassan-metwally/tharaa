import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/menu/static_page_type_enum.dart';
import '../../../domain/use_cases/menu/get_static_data_use_case.dart';

class StaticPageCubit extends Cubit<Async<String>> {
  StaticPageCubit({required this.type}) : super(const Async.initial()) {
    initDependency();
  }

  final StaticPageTypeEnum type;

  static StaticPageCubit of(BuildContext context) => BlocProvider.of<StaticPageCubit>(context);

  late final GetStaticDataUseCase _getStaticPageDataUseCase;
  void initDependency() {
    _getStaticPageDataUseCase = injector<GetStaticDataUseCase>();
  }

  void getData() async {
    emit(const Async.loading());
    final result = await _getStaticPageDataUseCase(type);
    result.fold(
      (failer) {
        emit(Async.failure(failer));
      },
      (data) {
        emit(Async.success(data));
      },
    );
  }

  @override
  void emit(Async<String> state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
