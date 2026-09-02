part of '../cart_page.dart';

class _CartPageBody extends StatelessWidget {
  const _CartPageBody({required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = _kCartBottomNavClearance + MediaQuery.paddingOf(context).bottom;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, bottomPadding),
      children: [
        for (int index = 0; index < cart.items.length; index++) ...[
          MultiBlocProvider(
            key: ValueKey(cart.items[index].id),
            providers: [
              BlocProvider<UpsertCartItemCubit>(create: (context) => injector<UpsertCartItemCubit>()),
              BlocProvider<DeleteCartItemCubit>(create: (context) => injector<DeleteCartItemCubit>()),
            ],
            child: _CartItemWidget(item: cart.items[index]),
          ),
          if (index < cart.items.length - 1) const SizedBox(height: Dimensions.p16),
        ],
        const SizedBox(height: Dimensions.p24),
        _CartPaymentSummary(cart: cart),
        const SizedBox(height: Dimensions.p32),
        AppButton(
          text: appLocalizer.completeOrder,
          textStyle: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
          onPressed: () {
            // AppRouter.pushNamed(AppRoutes.addClientProductOrderPage, arguments: AddClientProductOrderPage(cart: widget.cart));
          },
        ),
      ],
    );
  }
}
