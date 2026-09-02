part of '../cart_page.dart';

class _CartItemWidget extends StatefulWidget {
  final CartItemEntity item;
  const _CartItemWidget({required this.item});

  @override
  State<_CartItemWidget> createState() => __CartItemWidgetState();
}

class __CartItemWidgetState extends State<_CartItemWidget> {
  Timer? _debounceTimer;
  bool _exceededAvailableQuantity = false;

  bool get _isUnavailable =>
      widget.item.unavailable ||
      (widget.item.availableQuantity != null && widget.item.availableQuantity! <= 0) ||
      _exceededAvailableQuantity;

  void _onQuantityChanged(BuildContext context, int newQuantity) async {
    final delta = newQuantity - widget.item.cartQuantity;
    if (delta == 0) return;

    _debounceTimer?.cancel();
    _debounceTimer = null;
    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      final upsertType = delta > 0 ? UpsertTypeEnum.increase : UpsertTypeEnum.decrease;
      context.read<UpsertCartItemCubit>().updateParams(
        AddToCartParams(
          productId: widget.item.productId,
          cartItemId: widget.item.id,
          quantity: delta.abs(),
          upsertType: upsertType,
        ),
      );
      context.read<UpsertCartItemCubit>().upsertCartItem();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
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
      child: Column(
        children: [
          _CartItemCard(
            item: widget.item,
            onQuantityChanged: (quantity) {
              if (_exceededAvailableQuantity) {
                setState(() => _exceededAvailableQuantity = false);
              }
              _onQuantityChanged(context, quantity);
            },
            onExceededAvailableQuantity: () {
              if (!_exceededAvailableQuantity) {
                setState(() => _exceededAvailableQuantity = true);
              }
            },
          ),
          if (_isUnavailable) ...[const SizedBox(height: Dimensions.p16), const _CartUnavailableNotice()],
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item, required this.onQuantityChanged, this.onExceededAvailableQuantity});

  final CartItemEntity item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback? onExceededAvailableQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kCartItemHeight,
      padding: const EdgeInsetsDirectional.only(start: Dimensions.p8, end: Dimensions.p12, top: Dimensions.p8, bottom: Dimensions.p8),
      decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r24)),
      child: Row(
        children: [
          AppImage.rounded(
            path: item.productImage.path,
            width: _kCartItemImageWidth,
            height: _kCartItemHeight - Dimensions.p16,
            fit: BoxFit.cover,
            radius: Dimensions.r16,
          ),
          const SizedBox(width: Dimensions.p8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.medium16.copyWith(color: AppColors.black900, height: 1),
                      ),
                    ),
                    const SizedBox(width: Dimensions.p8),
                    BlocBuilder<DeleteCartItemCubit, DeleteCartItemState>(
                      builder: (context, state) {
                        if (state.deleteItemsState.isLoading) {
                          return const SizedBox(width: Dimensions.ic20, height: Dimensions.ic20, child: SpinKitLoadingWidget(size: 12));
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<DeleteCartItemCubit>().deleteCartItem(item.id);
                            CartItemsCountSubscription.pushUpdate(NoParams());
                          },
                          child: AppSvgIcon(path: AppIcons.trash, width: Dimensions.ic20, height: Dimensions.ic20),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: RiyalPriceText(
                        price: item.price.toString(),
                        priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
                        currencyTextStyle: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1),
                      ),
                    ),
                    const SizedBox(width: Dimensions.p12),
                    UpdateCartItemQuantityWidget(
                      availableQuantity: item.availableQuantity,
                      cartQuantity: item.cartQuantity,
                      onQuantityChanged: onQuantityChanged,
                      onExceededAvailableQuantity: onExceededAvailableQuantity,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartUnavailableNotice extends StatelessWidget {
  const _CartUnavailableNotice();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSvgIcon(path: AppIcons.infoCircleSolid, width: Dimensions.ic14, height: Dimensions.ic14, color: AppColors.warning500),
        const SizedBox(width: Dimensions.p4 / 2),
        Flexible(
          child: Text(
            appLocalizer.productNoLongerAvailable,
            textAlign: TextAlign.center,
            style: TextStyles.regular12.copyWith(color: AppColors.warning500, height: 1),
          ),
        ),
      ],
    );
  }
}
