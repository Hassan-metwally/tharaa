import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/core.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/usecases/get_statistics_usecase.dart';

part 'driver_statistics_state.dart';

@injectable
class DriverStatisticsCubit extends Cubit<DriverStatisticsState> {
  final GetStatisticsUsecase _getStatisticsUsecase;
  DriverStatisticsCubit(this._getStatisticsUsecase) : super(DriverStatisticsState.initial());

  Future<void> getStatistics() async {
    emit(state.copyWith(getStatisticsState: const Async.loading()));
    final result = await _getStatisticsUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(getStatisticsState: Async.failure(failure))),
      (data) => emit(state.copyWith(getStatisticsState: Async.success(data))),
    );
  }

  @override
  void emit(DriverStatisticsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
