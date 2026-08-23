import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/usecases/show_product_details_usecase.dart';

part 'show_product_details_state.dart';

@injectable
class ShowProductDetailsCubit extends Cubit<ShowProductDetailsState> {
  final ShowProductDetailsUsecase _showProductDetailsUsecase;
  ShowProductDetailsCubit(this._showProductDetailsUsecase) : super(ShowProductDetailsState.initial());

  Future<void> showProductDetails(int id) async {
    emit(state.copyWith(showProductState: const Async.loading()));
    final result = await _showProductDetailsUsecase(id);
    result.fold(
      (failure) => emit(state.copyWith(showProductState: Async.failure(failure))),
      (data) => emit(state.copyWith(showProductState: Async.success(data))),
    );
  }

  void changeProductLocally() {
    final product = state.showProductState.data;
    if (product != null) {
      emit(state.copyWith(showProductState: Async.success(product.copyWith())));
    }
  }

  @override
  void emit(ShowProductDetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
