part of '../main_categories_page.dart';

class _MainCategoryCard extends StatelessWidget {
  const _MainCategoryCard({required this.entity});

  final CategoryEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppRouter.pushNamed(
          AppRoutes.productsPage,
          arguments: ProductsPage(params: GetProductsParams(mainCategory: entity)),
        );
      },
      child: Column(
        children: [
          Container(
            height: _kCategoryCardHeight,
            width: double.infinity,
            padding: const EdgeInsets.all(_kCategoryCardPadding),
            decoration: BoxDecoration(color: _kCategoryCardFill, borderRadius: BorderRadius.circular(Dimensions.r12)),
            child: AppImage.rounded(
              path: entity.image.path,
              height: _kCategoryImageHeight,
              width: double.infinity,
              radius: Dimensions.r12,
              fit: BoxFit.cover,
              bgColor: _kCategoryCardFill,
            ),
          ),
          const SizedBox(height: Dimensions.p4),
          Text(
            entity.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyles.medium14.copyWith(color: AppColors.black900, height: 1),
          ),
        ],
      ),
    );
  }
}

class _MainCategoryCardShimmer extends StatelessWidget {
  const _MainCategoryCardShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          Container(
            height: _kCategoryCardHeight,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r16)),
          ),
          const SizedBox(height: Dimensions.p4),
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r4)),
          ),
        ],
      ),
    );
  }
}
