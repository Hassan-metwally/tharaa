part of 'show_product_details_cubit.dart';

class ShowProductDetailsState extends Equatable {
  final Async<ProductDetailsEntity> showProductState;
  const ShowProductDetailsState({required this.showProductState});

  factory ShowProductDetailsState.initial() {
    return const ShowProductDetailsState(showProductState: Async.initial());
  }

  ShowProductDetailsState copyWith({Async<ProductDetailsEntity>? showProductState}) {
    return ShowProductDetailsState(showProductState: showProductState ?? this.showProductState);
  }

  @override
  List<Object> get props => [showProductState];
}
