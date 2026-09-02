part of '../show_product_details_page.dart';

class _ProductDetailsInfo extends StatelessWidget {
  const _ProductDetailsInfo({required this.product});

  final ProductDetailsEntity product;

  bool get _hasOffer {
    final num? offerPrice = product.offerPrice;
    return offerPrice != null && offerPrice < product.price;
  }

  num get _displayPrice => _hasOffer ? product.offerPrice! : product.price;

  String get _unitLabel => product.unitLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductDetailsChips(categoryName: product.category.name, subCategoryName: product.subCategory.name),
            const SizedBox(height: Dimensions.p8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
            if (_unitLabel.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(_unitLabel, style: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1)),
            ],
          ],
        ),
        if (product.description.isNotEmpty) ...[
          const SizedBox(height: Dimensions.p12),
          Text(product.description, style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1.4)),
        ],
        const SizedBox(height: Dimensions.p12),
        _ProductDetailsPriceRow(
          label: appLocalizer.productPrice,
          displayPrice: _displayPrice,
          originalPrice: product.price,
          hasOffer: _hasOffer,
        ),
      ],
    );
  }
}

class _ProductDetailsChips extends StatelessWidget {
  const _ProductDetailsChips({required this.categoryName, required this.subCategoryName});

  final String categoryName;
  final String subCategoryName;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimensions.p4,
      runSpacing: Dimensions.p4,
      children: [
        if (categoryName.isNotEmpty) _ProductDetailsChip(label: categoryName),
        if (subCategoryName.isNotEmpty) _ProductDetailsChip(label: subCategoryName),
      ],
    );
  }
}

class _ProductDetailsChip extends StatelessWidget {
  const _ProductDetailsChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.p8),
      decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r8)),
      child: Text(label, style: TextStyles.medium14.copyWith(color: AppColors.chipText, height: 1)),
    );
  }
}

class _ProductDetailsPriceRow extends StatelessWidget {
  const _ProductDetailsPriceRow({required this.label, required this.displayPrice, required this.originalPrice, required this.hasOffer});

  final String label;
  final num displayPrice;
  final num originalPrice;
  final bool hasOffer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1)),
        ),
        RiyalPriceText(
          price: displayPrice.toString(),
          priceTextStyle: TextStyles.semiBold24.copyWith(color: AppColors.primary, fontSize: 26, height: 1, fontWeight: FontWeight.w600),
          currencyTextStyle: TextStyles.semiBold24.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
        ),
        if (hasOffer) ...[
          const SizedBox(width: Dimensions.p8),
          RiyalPriceText(
            price: originalPrice.toString(),
            priceTextStyle: TextStyles.medium18.copyWith(
              color: AppColors.oldPriceColor,
              height: 1,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.oldPriceColor,
            ),
            currencyTextStyle: TextStyles.medium18.copyWith(
              color: AppColors.oldPriceColor,
              height: 1,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.oldPriceColor,
            ),
          ),
        ],
      ],
    );
  }
}
