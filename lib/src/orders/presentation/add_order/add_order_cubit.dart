import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/checkout_preview_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/add_order_usecase.dart';
import '../../domain/usecases/apply_checkout_coupon_usecase.dart';
import '../../domain/usecases/preview_checkout_usecase.dart';

part 'add_order_state.dart';

@injectable
class AddOrderCubit extends Cubit<AddOrderState> {
  final AddOrderUsecase _addOrderUsecase;
  final PreviewCheckoutUsecase _previewCheckoutUsecase;
  final ApplyCheckoutCouponUsecase _applyCheckoutCouponUsecase;

  AddOrderCubit(
    this._addOrderUsecase,
    this._previewCheckoutUsecase,
    this._applyCheckoutCouponUsecase,
  ) : super(AddOrderState.initial());

  void updateParams(UpsertOrderParams params) {
    emit(state.copyWith(params: params));
  }

  Future<void> previewCheckout() async {
    emit(state.copyWith(previewState: const Async.loading()));
    final coupon = state.params.couponCode.text.trim();
    final result = await _previewCheckoutUsecase(
      PreviewCheckoutParams(
        deliveryMethod: state.params.deliveryMethod,
        couponCode: coupon.isEmpty ? null : coupon,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(previewState: Async.failure(failure))),
      (data) => emit(state.copyWith(previewState: Async.success(data))),
    );
  }

  Future<void> applyCoupon() async {
    final code = state.params.couponCode.text.trim();
    if (code.isEmpty) return;

    emit(state.copyWith(applyCouponState: const Async.loading()));
    final result = await _applyCheckoutCouponUsecase(
      ApplyCheckoutCouponParams(deliveryMethod: state.params.deliveryMethod, couponCode: code),
    );
    result.fold(
      (failure) => emit(state.copyWith(applyCouponState: Async.failure(failure))),
      (data) => emit(state.copyWith(applyCouponState: Async.success(data), previewState: Async.success(data))),
    );
  }

  void setDeliveryMethod(String method) {
    final params = state.params.copyWith(
      deliveryMethod: method,
      clearAddressId: method == 'pickup',
    );
    emit(state.copyWith(params: params));
    previewCheckout();
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(params: state.params.copyWith(paymentMethod: method)));
  }

  void setAddressId(int addressId) {
    emit(state.copyWith(params: state.params.copyWith(addressId: addressId)));
  }

  Future<void> addOrder() async {
    emit(state.copyWith(addOrderState: const Async.loading()));
    final result = await _addOrderUsecase(state.params);
    result.fold(
      (failure) => emit(state.copyWith(addOrderState: Async.failure(failure))),
      (data) => emit(state.copyWith(addOrderState: Async.success(data))),
    );
  }

  @override
  void emit(AddOrderState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
