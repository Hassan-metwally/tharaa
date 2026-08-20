import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/delete_cart_item_usecase.dart';

part 'delete_cart_item_state.dart';

@Injectable()
class DeleteCartItemCubit extends Cubit<DeleteCartItemState> {
  final DeleteCartItemUsecase _deleteCartItemUsecase;
  DeleteCartItemCubit(this._deleteCartItemUsecase) : super(DeleteCartItemState.initial());

  Future<void> deleteCartItem(int itemId) async {
    emit(state.copyWith(deleteItemsState: Async.loading()));
    final result = await _deleteCartItemUsecase(itemId);
    result.fold(
      (failure) {
        emit(state.copyWith(deleteItemsState: Async.failure(failure)));
      },
      (success) {
        emit(state.copyWith(deleteItemsState: Async.success(success)));
      },
    );
  }

  @override
  void emit(DeleteCartItemState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
