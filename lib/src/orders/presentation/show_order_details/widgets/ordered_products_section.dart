part of '../show_order_details_page.dart';

const double _kOrderedProductsSectionTitleHeight = 28;
const double _kOrderedProductImageSize = 71;

class _OrderedProductsSection extends StatelessWidget {
  const _OrderedProductsSection({required this.items});

  final List<OrderItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _kOrderedProductsSectionTitleHeight,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              appLocalizer.orderedProducts,
              style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.p12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.p16),
          decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
          child: Column(
            spacing: Dimensions.p12,
            children: items.map((item) => _OrderedProductItem(item: item)).toList(),
          ),
        ),
      ],
    );
  }
}

class _OrderedProductItem extends StatelessWidget {
  const _OrderedProductItem({required this.item});

  final OrderItemEntity item;

  String get _priceLabel => item.price % 1 == 0 ? item.price.toInt().toString() : item.price.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimensions.p12, Dimensions.p8, Dimensions.p8, Dimensions.p8),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r24)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.p8,
          children: [
            _OrderedProductImage(path: item.image.path),
            Expanded(child: _OrderedProductDetails(item: item, priceLabel: _priceLabel)),
          ],
        ),
      ),
    );
  }
}

class _OrderedProductDetails extends StatelessWidget {
  const _OrderedProductDetails({required this.item, required this.priceLabel});

  final OrderItemEntity item;
  final String priceLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyles.medium16.copyWith(color: AppColors.black900, height: 1),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              if (item.unitLabel.isNotEmpty)
                Expanded(
                  child: Text(
                    item.unitLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                  ),
                ),
              Expanded(
                child: Text(
                  appLocalizer.quantityCount(item.quantity),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: RiyalPriceText(
              price: priceLabel,
              priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1, fontWeight: FontWeight.w600),
              currencyTextStyle: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderedProductImage extends StatelessWidget {
  const _OrderedProductImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.r16),
      child: SizedBox(
        width: _kOrderedProductImageSize,
        height: _kOrderedProductImageSize,
        child: AppImage(path: path),
      ),
    );
  }
}
