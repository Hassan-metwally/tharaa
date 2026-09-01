import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/widgets/riyal_price_text.dart';
import '../../../cart/domain/usecases/upsert_cart_item_usecase.dart';
import '../../../cart/presentation/upsert_cart_item/upsert_cart_item_cubit.dart';
import '../../../cart/presentation/utils/cart_items_count_subscription.dart';
import '../../../home/presentation/widgets/home_empty_widget.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../show_product_details/show_product_details_page.dart';
import 'products_cubit.dart';
import 'products_page.dart';

const double _kSectionHeaderHeight = 28;
const double _kProductCardWidth = 156;
const double _kProductCardHeight = 223;
const double _kProductImageHeight = 120;
const double _kAddButtonSize = 38;
const double _kAddIconSize = 24;
const double _kArrowIconSize = 24;
const int _kHomeShimmerCount = 3;

class MostRequestedProductsWidget extends StatelessWidget {
  const MostRequestedProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ProductsCubit>()
        ..updateParams(const GetProductsParams(page: 1, sort: ProductsSortEnum.mostRequested))
        ..getProducts(),
      child: _MostRequestedProductsBody(),
    );
  }
}

class _MostRequestedProductsBody extends StatelessWidget {
  const _MostRequestedProductsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.getProductsState.isLoading) {
          return const _MostRequestedProductsLoading();
        }
        if (state.getProductsState.isFailure) {
          return _MostRequestedProductsError(
            onRetry: () => context.read<ProductsCubit>()
              ..updateParams(const GetProductsParams(page: 1, sort: ProductsSortEnum.mostRequested))
              ..getProducts(),
          );
        }
        if (state.getProductsState.isSuccess) {
          final List<ProductEntity> products = state.getProductsState.data ?? [];
          if (products.isEmpty) {
            return HomeEmptyWidget(
              title: appLocalizer.mostRequestedProducts,
              message: appLocalizer.noProductsFound,
              iconPath: AppIcons.bag1,
            );
          }
          return _MostRequestedProductsContent(products: products);
        }
        return const SizedBox();
      },
    );
  }
}

class _MostRequestedProductsContent extends StatelessWidget {
  const _MostRequestedProductsContent({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MostRequestedProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
            separatorBuilder: (context, index) => const SizedBox(width: Dimensions.p12),
            itemBuilder: (context, index) => _MostRequestedProductCard(entity: products[index]),
          ),
        ),
      ],
    );
  }
}

class _MostRequestedProductsHeader extends StatelessWidget {
  const _MostRequestedProductsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AppRouter.pushNamed(
            AppRoutes.productsPage,
            arguments: const ProductsPage(params: GetProductsParams(page: 1, sort: ProductsSortEnum.mostRequested)),
          );
        },
        child: SizedBox(
          height: _kSectionHeaderHeight,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizer.mostRequestedProducts,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                ),
              ),
              Text(appLocalizer.viewMore, style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1)),
              SizedBox(width: 2),
              AppSvgIcon(path: AppIcons.arrowLeft, width: _kArrowIconSize, height: _kArrowIconSize),
            ],
          ),
        ),
      ),
    );
  }
}

class _MostRequestedProductCard extends StatelessWidget {
  const _MostRequestedProductCard({required this.entity});

  final ProductEntity entity;

  String get _unitLabel {
    if (entity.amount != null) {
      return '${entity.amount}*${entity.unit}';
    }
    return entity.unit;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.pushNamed(AppRoutes.showProductDetailsPage, arguments: ShowProductDetailsPage(id: entity.id));
      },
      child: Container(
        width: _kProductCardWidth,
        height: _kProductCardHeight,
        padding: const EdgeInsets.all(Dimensions.p8),
        decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: _kProductImageHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppImage.rounded(
                      path: entity.image.path,
                      height: _kProductImageHeight,
                      width: double.infinity,
                      radius: Dimensions.r16,
                      fit: BoxFit.cover,
                      bgColor: AppColors.productCardFill,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.p8),
                      child: _MostRequestedAddToCartButton(productId: entity.id),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.p8),
            Text(
              entity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium16.copyWith(color: AppColors.black900, height: 1),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    entity.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                  ),
                ),
                if (_unitLabel.isNotEmpty) Text(_unitLabel, style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1)),
              ],
            ),
            const Spacer(),
            Center(
              child: RiyalPriceText(
                price: entity.price.toString(),
                priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                currencyTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MostRequestedAddToCartButton extends StatelessWidget {
  const _MostRequestedAddToCartButton({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertCartItemCubit>(),
      child: BlocConsumer<UpsertCartItemCubit, UpsertCartItemState>(
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
                      AddToCartParams(productId: productId, quantity: 1, upsertType: UpsertTypeEnum.add),
                    );
                    context.read<UpsertCartItemCubit>().upsertCartItem();
                  },
            child: Container(
              width: _kAddButtonSize,
              height: _kAddButtonSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(Dimensions.r16),
                border: Border.all(color: AppColors.white, width: 0.5),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? SpinKitLoadingWidget.small(color: AppColors.white)
                  : AppSvgIcon(path: AppIcons.add, width: _kAddIconSize, height: _kAddIconSize),
            ),
          );
        },
      ),
    );
  }
}

class _MostRequestedProductsLoading extends StatelessWidget {
  const _MostRequestedProductsLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MostRequestedProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _kHomeShimmerCount,
            separatorBuilder: (context, index) => const SizedBox(width: Dimensions.p12),
            itemBuilder: (context, index) => const _MostRequestedProductCardShimmer(),
          ),
        ),
      ],
    );
  }
}

class _MostRequestedProductCardShimmer extends StatelessWidget {
  const _MostRequestedProductCardShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: _kProductCardWidth,
        height: _kProductCardHeight,
        padding: const EdgeInsets.all(Dimensions.p8),
        decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: _kProductImageHeight,
              decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r16)),
            ),
            const SizedBox(height: Dimensions.p8),
            Container(
              height: 16,
              decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r4)),
            ),
            const SizedBox(height: Dimensions.p4),
            Container(
              height: 12,
              decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r4)),
            ),
            const Spacer(),
            Center(
              child: Container(
                height: 20,
                width: 64,
                decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(Dimensions.r4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MostRequestedProductsError extends StatelessWidget {
  const _MostRequestedProductsError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MostRequestedProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: AppFailWidget.mini(onRetry: onRetry),
        ),
      ],
    );
  }
}
