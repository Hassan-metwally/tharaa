part of 'ads_cubit.dart';

class AdsState extends Equatable {
  final Async<List<AdEntity>> getAllAdsState;

  const AdsState({required this.getAllAdsState});

  factory AdsState.initial() {
    return const AdsState(getAllAdsState: Async.initial());
  }

  AdsState copyWith({Async<List<AdEntity>>? getAllAdsState}) {
    return AdsState(getAllAdsState: getAllAdsState ?? this.getAllAdsState);
  }

  @override
  List<Object> get props => [getAllAdsState];
}
