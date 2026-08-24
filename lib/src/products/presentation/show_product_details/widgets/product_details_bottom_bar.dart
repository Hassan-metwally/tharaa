part of '../show_product_details_page.dart';

class _ProductDetailsBottomBar extends StatelessWidget {
  const _ProductDetailsBottomBar({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertCartItemCubit>(),
      child: _ProductDetailsBottomBarBody(productId: productId),
    );
  }
}

class _ProductDetailsBottomBarBody extends StatefulWidget {
  const _ProductDetailsBottomBarBody({required this.productId});

  final int productId;

  @override
  State<_ProductDetailsBottomBarBody> createState() => _ProductDetailsBottomBarBodyState();
}

class _ProductDetailsBottomBarBodyState extends State<_ProductDetailsBottomBarBody> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, 0),
        child: Row(
          children: [
            _ProductDetailsQuantitySelector(
              quantity: _quantity,
              onIncrement: () => setState(() => _quantity += 1),
              onDecrement: () {
                if (_quantity > 1) {
                  setState(() => _quantity -= 1);
                }
              },
            ),
            const SizedBox(width: Dimensions.p16),
            Expanded(
              child: _ProductDetailsAddToCartButton(productId: widget.productId, quantity: _quantity),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailsQuantitySelector extends StatelessWidget {
  const _ProductDetailsQuantitySelector({required this.quantity, required this.onIncrement, required this.onDecrement});

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kQuantitySelectorWidth,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(_kQuantitySelectorRadius)),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuantityIconButton(icon: AppIcons.add, onTap: onIncrement),
          Text('$quantity', style: TextStyles.medium18.copyWith(color: AppColors.black900, height: 1)),
          _QuantityIconButton(icon: AppIcons.minus, onTap: onDecrement),
        ],
      ),
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  const _QuantityIconButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: _kQuantityButtonSize,
        height: _kQuantityButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: AppSvgIcon(path: icon, width: _kQuantityIconSize, height: _kQuantityIconSize, color: AppColors.primary),
      ),
    );
  }
}

class _ProductDetailsAddToCartButton extends StatelessWidget {
  const _ProductDetailsAddToCartButton({required this.productId, required this.quantity});

  final int productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpsertCartItemCubit, UpsertCartItemState>(
      listenWhen: (previous, current) => previous.upsertCartItemsState != current.upsertCartItemsState,
      listener: (context, state) {
        if (state.upsertCartItemsState.isFailure) {
          AppToasts.error(context, message: state.upsertCartItemsState.errorMessage ?? appLocalizer.somethingWentWrong);
        } else if (state.upsertCartItemsState.isSuccess) {
          AppToasts.success(context, message: appLocalizer.successfullyAddedToCart);
          CartItemsCountSubscription.pushUpdate(NoParams());
        }
      },
      builder: (context, state) {
        final bool isLoading = state.upsertCartItemsState.isLoading;
        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  context.read<UpsertCartItemCubit>().updateParams(
                    AddToCartParams(productId: productId, quantity: quantity, upsertType: UpsertTypeEnum.add),
                  );
                  context.read<UpsertCartItemCubit>().upsertCartItem();
                },
          child: Container(
            height: _kAddToCartButtonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Dimensions.r16)),
            child: isLoading
                ? SpinKitLoadingWidget.small(color: AppColors.white)
                : Text(
                    appLocalizer.addToCart,
                    style: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                  ),
          ),
        );
      },
    );
  }
}
