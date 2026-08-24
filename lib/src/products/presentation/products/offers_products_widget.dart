import 'dart:math' as math;

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
import '../../../main_page/models/client_main_page_tabs_enum.dart';
import '../../../main_page/observer/client_main_page_observer.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../show_product_details/show_product_details_page.dart';
import 'products_cubit.dart';

const Color _kOldPriceColor = Color(0xFF8B9BB2);
const double _kSectionHeaderHeight = 28;
const double _kProductCardWidth = 160;
const double _kProductCardHeight = 223;
const double _kProductImageHeight = 120;
const double _kAddButtonSize = 38;
const double _kAddIconSize = 24;
const double _kArrowHitSize = 28;
const double _kArrowIconSize = 20;
const double _kArrowRotationDeg = 48.31;
const double _kFlameIconSize = 14;
const int _kHomeShimmerCount = 3;

class OffersProductsWidget extends StatelessWidget {
  const OffersProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ProductsCubit>()
        ..updateParams(const GetProductsParams(page: 1, offersProductsOnly: true))
        ..getProducts(),
      child: const _OffersProductsBody(),
    );
  }
}

class _OffersProductsBody extends StatelessWidget {
  const _OffersProductsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.getProductsState.isLoading) {
          return const _OffersSectionFrame(child: _OffersProductsLoading());
        }
        if (state.getProductsState.isFailure) {
          return _OffersSectionFrame(child: _OffersProductsError(onRetry: () => context.read<ProductsCubit>().getProducts()));
        }
        if (state.getProductsState.isSuccess) {
          final List<ProductEntity> products = state.getProductsState.data ?? [];
          if (products.isEmpty) {
            return _OffersSectionFrame(
              child: HomeEmptyWidget(title: appLocalizer.offersList, message: appLocalizer.noProductsFound, iconPath: AppIcons.gift),
            );
          }
          return _OffersSectionFrame(child: _OffersProductsContent(products: products));
        }
        return const SizedBox();
      },
    );
  }
}

class _OffersSectionFrame extends StatelessWidget {
  const _OffersSectionFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: AppColors.primary50, child: child);
  }
}

class _OffersProductsContent extends StatelessWidget {
  const _OffersProductsContent({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OffersProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.only(left: Dimensions.p16, right: Dimensions.p16, bottom: Dimensions.p16),
            separatorBuilder: (context, index) => const SizedBox(width: Dimensions.p12),
            itemBuilder: (context, index) => _OfferProductCard(entity: products[index]),
          ),
        ),
      ],
    );
  }
}

class _OffersProductsHeader extends StatelessWidget {
  const _OffersProductsHeader();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    const double radians = _kArrowRotationDeg * math.pi / 180;

    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.p16, right: Dimensions.p16, top: Dimensions.p16),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ClientMainPageUpdater.notifyOnChangedCallbacks(ClientMainPageTabsEnum.offers);
        },
        child: SizedBox(
          height: _kSectionHeaderHeight,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizer.offersList,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                ),
              ),
              Text(appLocalizer.viewMore, style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1)),
              SizedBox(
                width: _kArrowHitSize,
                height: _kArrowHitSize,
                child: Center(
                  child: Transform.rotate(
                    angle: isRtl ? radians : math.pi - radians,
                    child: AppSvgIcon(path: AppIcons.arrowUpRight, width: _kArrowIconSize, height: _kArrowIconSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferProductCard extends StatelessWidget {
  const _OfferProductCard({required this.entity});

  final ProductEntity entity;

  String get _unitLabel {
    if (entity.amount != null) {
      return '${entity.amount}*${entity.unit}';
    }
    return entity.unit;
  }

  bool get _hasOffer {
    final num? offerPrice = entity.offerPrice;
    return offerPrice != null && offerPrice < entity.price;
  }

  int? get _discountPercent {
    if (!_hasOffer || entity.price == 0) return null;
    return (((entity.price - entity.offerPrice!) / entity.price) * 100).round();
  }

  num get _displayPrice => entity.offerPrice ?? entity.price;

  @override
  Widget build(BuildContext context) {
    final int? discountPercent = _discountPercent;

    return GestureDetector(
      onTap: () {
        AppRouter.pushNamed(
          AppRoutes.showProductDetailsPage,
          arguments: ShowProductDetailsPage(id: entity.id),
        );
      },
      child: Container(
        width: _kProductCardWidth,
        height: _kProductCardHeight,
        padding: const EdgeInsets.all(Dimensions.p8),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r24)),
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
                      bgColor: AppColors.offersCardFill,
                    ),
                  ),
                  if (discountPercent != null && discountPercent > 0)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.p8),
                        child: _OfferDiscountBadge(percent: discountPercent),
                      ),
                    ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.p8),
                      child: _OfferAddToCartButton(productId: entity.id),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RiyalPriceText(
                  price: _displayPrice.toString(),
                  priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                  currencyTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                ),
                const SizedBox(width: Dimensions.p12),
      
                if (_hasOffer) ...[
                  RiyalPriceText(
                    price: entity.price.toString(),
                    priceTextStyle: TextStyles.medium14.copyWith(
                      color: _kOldPriceColor,
                      height: 1,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: _kOldPriceColor,
                    ),
                    currencyTextStyle: TextStyles.medium14.copyWith(
                      color: _kOldPriceColor,
                      height: 1,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: _kOldPriceColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferDiscountBadge extends StatelessWidget {
  const _OfferDiscountBadge({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.p4),
      decoration: BoxDecoration(color: AppColors.warning50, borderRadius: BorderRadius.circular(Dimensions.r8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizer.discountPercent(percent),
            style: TextStyles.semiBold10.copyWith(color: AppColors.warning500, height: 1, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 2),
          AppSvgIcon(path: AppIcons.flame, width: _kFlameIconSize, height: _kFlameIconSize),
        ],
      ),
    );
  }
}

class _OfferAddToCartButton extends StatelessWidget {
  const _OfferAddToCartButton({required this.productId});

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

class _OffersProductsLoading extends StatelessWidget {
  const _OffersProductsLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OffersProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _kHomeShimmerCount,
            padding: const EdgeInsets.only(left: Dimensions.p16, right: Dimensions.p16, bottom: Dimensions.p16),
            separatorBuilder: (context, index) => const SizedBox(width: Dimensions.p12),
            itemBuilder: (context, index) => const _OfferProductCardShimmer(),
          ),
        ),
      ],
    );
  }
}

class _OfferProductCardShimmer extends StatelessWidget {
  const _OfferProductCardShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: _kProductCardWidth,
        height: _kProductCardHeight,
        padding: const EdgeInsets.all(Dimensions.p8),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r24)),
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

class _OffersProductsError extends StatelessWidget {
  const _OffersProductsError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OffersProductsHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kProductCardHeight,
          child: AppFailWidget.mini(onRetry: onRetry),
        ),
      ],
    );
  }
}
