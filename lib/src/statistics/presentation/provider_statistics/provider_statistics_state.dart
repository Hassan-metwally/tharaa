part of 'provider_statistics_cubit.dart';

class ProviderStatisticsState extends Equatable {
  final Async<StatisticsEntity> getStatisticsState;
  const ProviderStatisticsState({required this.getStatisticsState});

  factory ProviderStatisticsState.initial() {
    return const ProviderStatisticsState(getStatisticsState: Async.initial());
  }

  ProviderStatisticsState copyWith({Async<StatisticsEntity>? getStatisticsState}) {
    return ProviderStatisticsState(getStatisticsState: getStatisticsState ?? this.getStatisticsState);
  }

  @override
  List<Object> get props => [getStatisticsState];
}
