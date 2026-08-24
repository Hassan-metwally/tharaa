import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/usecases/get_coupons_usecase.dart';

part 'coupons_state.dart';

@injectable
class CouponsCubit extends Cubit<CouponsState> {
  final GetCouponsUsecase _getCouponsUsecase;
  CouponsCubit(this._getCouponsUsecase) : super(CouponsState.initial());

  Future<void> getCoupons() async {
    emit(state.copyWith(getCouponsState: const Async.loading(), currentPage: 1));
    final result = await _getCouponsUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(getCouponsState: Async.failure(failure))),
      (data) => emit(state.copyWith(getCouponsState: Async.success(data.items), lastPage: data.pageInfo.lastPage)),
    );
  }

  Future<void> getMoreCoupons() async {
    if (state.currentPage == state.lastPage) return;
    emit(state.copyWith(getCouponsState: Async.paginationLoading(state.getCouponsState.data ?? []), currentPage: state.currentPage + 1));
    final result = await _getCouponsUsecase(state.params.copyWith(page: state.currentPage));
    result.fold(
      (failure) => emit(state.copyWith(getCouponsState: Async.failure(failure), currentPage: state.currentPage - 1)),
      (data) => emit(state.copyWith(getCouponsState: Async.success([...state.getCouponsState.data ?? [], ...data.items]))),
    );
  }

  void updateParams(GetCouponsParams params) {
    emit(state.copyWith(params: params));
  }

  void resetParams() => emit(state.copyWith(params: GetCouponsParams.initial()));

  void search() {
    emit(state.copyWith(params: state.params));
    getCoupons();
  }

  @override
  void emit(CouponsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
