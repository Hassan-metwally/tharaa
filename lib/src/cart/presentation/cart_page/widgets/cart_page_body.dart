part of '../cart_page.dart';

class _CartPageBody extends StatefulWidget {
  const _CartPageBody({required this.cart});

  final CartEntity cart;

  @override
  State<_CartPageBody> createState() => __CartPageBodyState();
}

class __CartPageBodyState extends State<_CartPageBody> {
  // PostOrderCubit? _postOrderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(appLocalizer.itemsCount, style: TextStyles.medium14.copyWith(color: AppColors.black900)),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.cart.items.length.toString(),
                            style: TextStyles.medium16.copyWith(color: AppColors.primary),
                          ),
                          const TextSpan(text: ' '),
                          widget.cart.items.length > 2
                              ? TextSpan(
                                  text: appLocalizer.items,
                                  style: TextStyles.medium12.copyWith(color: AppColors.black700),
                                )
                              : TextSpan(
                                  text: appLocalizer.item,
                                  style: TextStyles.medium12.copyWith(color: AppColors.black700),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: AppColors.black50),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: appLocalizer.productsFrom,
                              style: TextStyles.medium14.copyWith(color: AppColors.black),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: '',
                              style: TextStyles.medium14.copyWith(color: AppColors.black400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        itemCount: widget.cart.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = widget.cart.items[index];
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider<UpsertCartItemCubit>(create: (context) => injector<UpsertCartItemCubit>()),
                              BlocProvider<DeleteCartItemCubit>(create: (context) => injector<DeleteCartItemCubit>()),
                            ],
                            child: _CartItemWidget(item: item),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: appLocalizer.total,
                            style: TextStyles.medium14.copyWith(color: AppColors.black),
                          ),
                          TextSpan(
                            text: ' (',
                            style: TextStyles.medium14.copyWith(color: AppColors.black400),
                          ),
                          TextSpan(
                            text: appLocalizer.priceIncludingTax,
                            style: TextStyles.medium14.copyWith(color: AppColors.black400),
                          ),
                          TextSpan(
                            text: ')',
                            style: TextStyles.medium14.copyWith(color: AppColors.black400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RiyalPriceText(
                    price: widget.cart.productsPrice.toString(),
                    priceTextStyle: TextStyles.medium15.copyWith(color: AppColors.black),
                    currencyTextStyle: TextStyles.medium14.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AppButton(
                text: appLocalizer.completeOrder,
                onPressed: () {
                  // AppRouter.pushNamed(AppRoutes.addClientProductOrderPage, arguments: AddClientProductOrderPage(cart: widget.cart));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
