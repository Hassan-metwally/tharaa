part of '../cart_page.dart';

class _CartPaymentSummary extends StatelessWidget {
  const _CartPaymentSummary({required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 28,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              appLocalizer.paymentSummary,
              style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.p12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.p16),
          decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r24)),
          child: Column(
            children: [
              _CartSummaryRow(
                label: appLocalizer.cartTotal,
                price: cart.productsPrice,
                labelStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1),
                priceStyle: TextStyles.medium16.copyWith(color: AppColors.chipText, height: 1),
                currencySize: Dimensions.ic14,
              ),
              const SizedBox(height: Dimensions.p8),
              Divider(height: 1, thickness: 1, color: AppColors.black200),
              const SizedBox(height: Dimensions.p8),
              _CartSummaryRow(
                label: appLocalizer.grandTotal,
                price: cart.totalPrice,
                labelStyle: TextStyles.regular16.copyWith(color: AppColors.mutedText, height: 1),
                priceStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
                currencySize: Dimensions.ic16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartSummaryRow extends StatelessWidget {
  const _CartSummaryRow({
    required this.label,
    required this.price,
    required this.labelStyle,
    required this.priceStyle,
    required this.currencySize,
  });

  final String label;
  final String price;
  final TextStyle labelStyle;
  final TextStyle priceStyle;
  final double currencySize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        RiyalPriceText(
          price: price,
          priceTextStyle: priceStyle,
          currencyTextStyle: priceStyle.copyWith(fontSize: currencySize),
        ),
      ],
    );
  }
}
