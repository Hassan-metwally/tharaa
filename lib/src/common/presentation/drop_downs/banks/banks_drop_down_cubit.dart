import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../domain/entity/common_entity.dart';
import '../../../domain/use_cases/get_banks_usecase.dart';
import '../drop_downs/drop_down_cubit.dart';

class BanksDropDownCubit extends DropDownCubit<CommonEntity> {
  BanksDropDownCubit();

  final GetBanksUseCase _getBanksUseCase = injector();

  @override
  void fetch() async {
    if (state.isSuccess) return;
    emit(const Async.loading());
    final result = await _getBanksUseCase(NoParams());
    result.fold(
      (failer) {
        emit(Async.failure(failer));
      },
      (data) {
        emit(Async.success(data));
      },
    );
  }
}
