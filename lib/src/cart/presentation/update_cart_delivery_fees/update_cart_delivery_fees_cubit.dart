import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/update_cart_delivery_fees_usecase.dart';

part 'update_cart_delivery_fees_state.dart';

@Injectable()
class UpdateCartDeliveryFeesCubit extends Cubit<UpdateCartDeliveryFeesState> {
  final UpdateCartDeliveryFeesUsecase updateCartDeliveryFeesUsecase;
  UpdateCartDeliveryFeesCubit(this.updateCartDeliveryFeesUsecase) : super(UpdateCartDeliveryFeesState.initial());

  Future<void> updateCartDeliveryFees() async {
    emit(state.copyWith(updateCartDeliveryFeesState: Async.loading()));
    final result = await updateCartDeliveryFeesUsecase(state.params);
    result.fold(
      (failure) {
        emit(state.copyWith(updateCartDeliveryFeesState: Async.failure(failure)));
      },
      (cart) {
        emit(state.copyWith(updateCartDeliveryFeesState: Async.success(cart)));
      },
    );
  }

  void updateParams(UpdateCartDeliveryFeesParams params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit(UpdateCartDeliveryFeesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
