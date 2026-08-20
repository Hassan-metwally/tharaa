import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../domain/entity/city_entity.dart';
import '../../../domain/use_cases/get_cities_usecase.dart';
import '../drop_downs/drop_down_cubit.dart';

class CitiesDropDownCubit extends DropDownCubit<CityEntity> {
  CitiesDropDownCubit();

  final GetCitiesUseCase _getCitiesUseCase = injector();

  @override
  void fetch() async {
    if (state.isSuccess) return;
    emit(const Async.loading());
    final result = await _getCitiesUseCase(NoParams());
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
