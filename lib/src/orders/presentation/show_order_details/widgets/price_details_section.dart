part of '../show_order_details_page.dart';

class _PriceDetailsSection extends StatelessWidget {
  const _PriceDetailsSection({required this.order});

  final OrderDetailsEntity order;

  String _formatAmount(num value) => value % 1 == 0 ? value.toInt().toString() : value.toString();

  String get _paymentMethodLabel {
    if (order.paymentMethod == 'electronic') return appLocalizer.electronicPayment;
    if (order.paymentMethod.trim().isEmpty) return appLocalizer.electronicPayment;
    return order.paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizer.priceDetails,
          style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 28 / 16),
        ),
        const SizedBox(height: Dimensions.p12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.p16),
          decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r24)),
          child: Column(
            spacing: Dimensions.p8,
            children: [
              _PriceDetailRow(
                label: appLocalizer.paymentMethod,
                value: _paymentMethodLabel,
                valueStyle: TextStyles.medium16.copyWith(color: AppColors.primary, height: 1),
              ),
              _PriceDetailRow(label: appLocalizer.productsPriceExcludingTax, amount: _formatAmount(order.productsPrice)),
              _PriceDetailRow(label: appLocalizer.deliveryPrice, amount: _formatAmount(order.deliveryPrice)),
              _PriceDetailRow(label: appLocalizer.vatAmount, amount: _formatAmount(order.vatAmount)),
              Divider(height: 1, thickness: 1, color: AppColors.white),
              Row(
                children: [
                  Expanded(
                    child: Text(appLocalizer.grandTotal, style: TextStyles.regular16.copyWith(color: AppColors.mutedText, height: 1)),
                  ),
                  RiyalPriceText(
                    price: _formatAmount(order.total),
                    priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
                    currencyTextStyle: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceDetailRow extends StatelessWidget {
  const _PriceDetailRow({required this.label, this.amount, this.value, this.valueStyle});

  final String label;
  final String? amount;
  final String? value;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1)),
        ),
        if (amount != null)
          RiyalPriceText(
            price: amount!,
            priceTextStyle: TextStyles.medium16.copyWith(color: AppColors.chipText, height: 1),
            currencyTextStyle: TextStyles.medium14.copyWith(color: AppColors.chipText, height: 1),
          )
        else if (value != null)
          Text(value!, style: valueStyle),
      ],
    );
  }
}
