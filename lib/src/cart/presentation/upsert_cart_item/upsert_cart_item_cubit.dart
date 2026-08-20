import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';

part 'upsert_cart_item_state.dart';

@Injectable()
class UpsertCartItemCubit extends Cubit<UpsertCartItemState> {
  final UpsertCartItemUsecase upsertCartItemUsecase;
  UpsertCartItemCubit(this.upsertCartItemUsecase) : super(UpsertCartItemState.initial());

  Future<void> upsertCartItem() async {
    emit(state.copyWith(upsertCartItemsState: Async.loading()));
    final result = await upsertCartItemUsecase(state.params);
    result.fold(
      (failure) {
        emit(state.copyWith(upsertCartItemsState: Async.failure(failure)));
      },
      (cart) {
        emit(state.copyWith(upsertCartItemsState: Async.success(cart)));
      },
    );
  }

  void updateParams(AddToCartParams params) {
    emit(state.copyWith(params: params));
  }

  @override
  void emit(UpsertCartItemState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
