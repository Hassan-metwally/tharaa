part of '../cart_page.dart';

class _CartItemWidget extends StatefulWidget {
  final CartItemEntity item;
  const _CartItemWidget({required this.item});

  @override
  State<_CartItemWidget> createState() => __CartItemWidgetState();
}

class __CartItemWidgetState extends State<_CartItemWidget> {
  Timer? _debounceTimer;

  void _onQuantityChanged(BuildContext context, CartItemEntity updatedItem) async {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      context.read<UpsertCartItemCubit>().updateParams(
        AddToCartParams(productId: updatedItem.productId, quantity: updatedItem.cartQuantity, upsertType: UpsertTypeEnum.update),
      );
      context.read<UpsertCartItemCubit>().upsertCartItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpsertCartItemCubit, UpsertCartItemState>(
          listenWhen: (previous, current) => previous.upsertCartItemsState != current.upsertCartItemsState,
          listener: (context, state) {
            if (state.upsertCartItemsState.isSuccess) {
              context.read<CartCubit>().updateLocalCartItems(cart: state.upsertCartItemsState.data!);
            } else if (state.upsertCartItemsState.isFailure) {
              AppToasts.error(context, message: state.upsertCartItemsState.errorMessage ?? appLocalizer.somethingWentWrong);
            }
          },
        ),
        BlocListener<DeleteCartItemCubit, DeleteCartItemState>(
          listenWhen: (previous, current) => previous.deleteItemsState != current.deleteItemsState,
          listener: (context, state) {
            if (state.deleteItemsState.isSuccess) {
              context.read<CartCubit>().updateLocalCartItems(cart: state.deleteItemsState.data!);
            } else if (state.deleteItemsState.isFailure) {
              AppToasts.error(context, message: state.deleteItemsState.errorMessage ?? appLocalizer.somethingWentWrong);
            }
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            AppImage.rounded(path: widget.item.productImage.path, width: 70, height: 60, fit: BoxFit.cover, radius: 6),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.item.productName, style: TextStyles.regular14.copyWith(color: AppColors.black900)),
                      ),

                      BlocBuilder<DeleteCartItemCubit, DeleteCartItemState>(
                        builder: (context, state) {
                          if (state.deleteItemsState.isLoading) return const SpinKitLoadingWidget(size: 8);
                          return GestureDetector(
                            onTap: () {
                              context.read<DeleteCartItemCubit>().deleteCartItem(widget.item.productId);
                              CartItemsCountSubscription.pushUpdate(NoParams());
                            },
                            child: AppSvgIcon(path: ""),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UpdateCartItemQuantityWidget(
                        iconSize: 16,
                        radius: 4,
                        textStyle: TextStyles.regular14.copyWith(color: AppColors.black900),
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        availableQuantity: widget.item.availableQuantity,
                        cartQuantity: widget.item.cartQuantity,
                        onQuantityChanged: (quantity) {
                          final updatedItem = widget.item.copyWith(cartQuantity: quantity);
                          _onQuantityChanged(context, updatedItem);
                        },
                      ),
                      RiyalPriceText(
                        price: widget.item.price.toString(),
                        priceTextStyle: TextStyles.medium14.copyWith(color: AppColors.black800),
                        currencyTextStyle: TextStyles.medium14.copyWith(color: AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
