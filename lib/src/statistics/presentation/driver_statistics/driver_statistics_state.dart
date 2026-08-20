part of 'driver_statistics_cubit.dart';

class DriverStatisticsState extends Equatable {
  final Async<StatisticsEntity> getStatisticsState;
  const DriverStatisticsState({required this.getStatisticsState});

  factory DriverStatisticsState.initial() {
    return const DriverStatisticsState(getStatisticsState: Async.initial());
  }

  DriverStatisticsState copyWith({Async<StatisticsEntity>? getStatisticsState}) {
    return DriverStatisticsState(getStatisticsState: getStatisticsState ?? this.getStatisticsState);
  }

  @override
  List<Object> get props => [getStatisticsState];
}
