part of 'coupons_cubit.dart';

class CouponsState extends Equatable {
  final Async<List<CouponEntity>> getCouponsState;

  final GetCouponsParams params;
  final int currentPage;
  final int lastPage;

  const CouponsState({required this.getCouponsState, required this.params, this.currentPage = 1, this.lastPage = 1});

  factory CouponsState.initial() {
    return const CouponsState(getCouponsState: Async.initial(), params: GetCouponsParams.initial());
  }

  CouponsState copyWith({Async<List<CouponEntity>>? getCouponsState, GetCouponsParams? params, int? currentPage, int? lastPage}) {
    return CouponsState(
      getCouponsState: getCouponsState ?? this.getCouponsState,

      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [getCouponsState, params, currentPage, lastPage];
}
