part of 'statistics_cubit.dart';

class StatisticsState extends Equatable {
  final Async<StatisticsEntity> getStatisticsState;
  const StatisticsState({required this.getStatisticsState});

  factory StatisticsState.initial() {
    return const StatisticsState(getStatisticsState: Async.initial());
  }

  StatisticsState copyWith({Async<StatisticsEntity>? getStatisticsState}) {
    return StatisticsState(getStatisticsState: getStatisticsState ?? this.getStatisticsState);
  }

  @override
  List<Object> get props => [getStatisticsState];
}
