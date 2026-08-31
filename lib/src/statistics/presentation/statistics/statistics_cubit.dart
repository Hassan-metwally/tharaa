import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/usecases/get_statistics_usecase.dart';

part 'statistics_state.dart';

@injectable
class StatisticsCubit extends Cubit<StatisticsState> {
  final GetStatisticsUsecase _getStatisticsUsecase;
  StatisticsCubit(this._getStatisticsUsecase) : super(StatisticsState.initial());

  Future<void> getStatistics() async {
    emit(state.copyWith(getStatisticsState: const Async.loading()));
    final result = await _getStatisticsUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(getStatisticsState: Async.failure(failure))),
      (data) => emit(state.copyWith(getStatisticsState: Async.success(data))),
    );
  }

  @override
  void emit(StatisticsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
