part of '../add_order_page.dart';

class _CheckoutInvoiceSection extends StatelessWidget {
  const _CheckoutInvoiceSection({required this.preview});

  final CheckoutPreviewEntity preview;

  String _formatAmount(num value) => value % 1 == 0 ? value.toInt().toString() : value.toString();

  @override
  Widget build(BuildContext context) {
    return _CheckoutSection(
      title: appLocalizer.invoiceDetails,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.p16),
        decoration: BoxDecoration(
          color: AppColors.productCardFill,
          borderRadius: BorderRadius.circular(Dimensions.r24),
        ),
        child: Column(
          children: [
            _CheckoutInvoiceRow(
              label: appLocalizer.productsPriceExcludingTax,
              amount: _formatAmount(preview.productsExclTax),
            ),
            const SizedBox(height: Dimensions.p8),
            _CheckoutInvoiceRow(
              label: appLocalizer.deliveryPrice,
              amount: _formatAmount(preview.deliveryFee),
            ),
            const SizedBox(height: Dimensions.p8),
            _CheckoutInvoiceRow(
              label: appLocalizer.vatAmount,
              amount: _formatAmount(preview.vat),
            ),
            const SizedBox(height: Dimensions.p8),
            _CheckoutInvoiceRow(
              label: appLocalizer.discount,
              value: '${_formatAmount(preview.discountPercent)}%',
            ),
            const SizedBox(height: Dimensions.p8),
            Divider(height: 1, thickness: 2, color: AppColors.white),
            const SizedBox(height: Dimensions.p8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    appLocalizer.grandTotal,
                    style: TextStyles.regular16.copyWith(color: AppColors.mutedText, height: 1),
                  ),
                ),
                RiyalPriceText(
                  price: _formatAmount(preview.total),
                  priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
                  currencyTextStyle: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutInvoiceRow extends StatelessWidget {
  const _CheckoutInvoiceRow({required this.label, this.amount, this.value});

  final String label;
  final String? amount;
  final String? value;

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
          Text(value!, style: TextStyles.medium16.copyWith(color: AppColors.chipText, height: 1)),
      ],
    );
  }
}
