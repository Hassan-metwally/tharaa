import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/config/router/app_routes.dart';
import '../../../../../../../core/core.dart';
import '../../../../../../../material/app_fail_widget.dart';
import '../../../../../../../material/auth_states/guest_bottom_sheet.dart';
import '../../../../../../../material/auth_states/guest_checker_widget.dart';
import '../../../../../../../material/media/app_image.dart';
import '../../../../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../../categories/domain/entities/category_entity.dart';
import '../../../../products/domain/usecases/get_products_usecase.dart';
import '../../../../products/presentation/products/products_page.dart';
import '../../../../products/presentation/show_product_details/show_product_details_page.dart';
import '../../../domain/entities/ad_entity.dart';

const double _kBannerHeight = 140;
const double _kBannerRadius = 16;
const double _kBannerItemPadding = Dimensions.p8;
const double _kIndicatorGap = 12;
const double _kIndicatorHeight = 4;
const double _kIndicatorActiveWidth = 30;
const double _kIndicatorInactiveWidth = 20;
const double _kIndicatorSpacing = 4;
const Color _kIndicatorInactive = Color(0xFFBCC6D3);

class AdsSliderWidget extends StatefulWidget {
  const AdsSliderWidget({required this.sliders, super.key});

  final List<AdEntity> sliders;

  @override
  State<AdsSliderWidget> createState() => _AdsSliderWidgetState();
}

class _AdsSliderWidgetState extends State<AdsSliderWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  int get _totalCount => widget.sliders.length;

  @override
  Widget build(BuildContext context) {
    if (widget.sliders.isEmpty) {
      return const SizedBox();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool hasMultipleAds = _totalCount > 1;
        final double viewportFraction = _bannerViewportFraction(constraints.maxWidth);

        return Column(
          children: [
            SizedBox(
              height: _kBannerHeight,
              width: double.infinity,
              child: CarouselSlider.builder(
                carouselController: _controller,
                itemCount: _totalCount,
                itemBuilder: (context, index, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _kBannerItemPadding),
                    child: _AdsBannerCard(ad: widget.sliders[index]),
                  );
                },
                options: CarouselOptions(
                  height: _kBannerHeight,
                  viewportFraction: viewportFraction,
                  disableCenter: true,
                  autoPlay: hasMultipleAds,
                  enableInfiniteScroll: hasMultipleAds,
                  clipBehavior: Clip.none,
                  scrollPhysics: const ClampingScrollPhysics(),
                  onPageChanged: (index, _) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),
            ),
            const SizedBox(height: _kIndicatorGap),
            _AdsPageIndicator(count: _totalCount, currentIndex: _currentIndex),
          ],
        );
      },
    );
  }
}

double _bannerViewportFraction(double maxWidth) {
  if (maxWidth <= 0) {
    return 1;
  }
  final double pageGutter = (Dimensions.p16 - _kBannerItemPadding) * 2;
  return ((maxWidth - pageGutter) / maxWidth).clamp(0.0, 1.0);
}

class _AdsBannerCard extends StatelessWidget {
  const _AdsBannerCard({required this.ad});

  final AdEntity ad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ad.canOpen ? () => _openAd(context, ad) : null,
      child: AppImage.rounded(
        path: ad.image.path,
        height: _kBannerHeight,
        width: double.infinity,
        radius: _kBannerRadius,
        bgColor: AppColors.black800,
        fit: BoxFit.cover,
      ),
    );
  }
}

void _openAd(BuildContext context, AdEntity ad) {
  GuestCheckerWidget.check(
    context,
    caseGuest: () => GuestBottomSheet.show(context),
    elseCase: () {
      switch (ad.type) {
        case AdType.product:
          final int? productId = ad.linkableId;
          if (productId == null || productId <= 0) {
            return;
          }
          AppRouter.pushNamed(AppRoutes.showProductDetailsPage, arguments: ShowProductDetailsPage(id: productId));
        case AdType.category:
          final int? categoryId = ad.linkableId;
          if (categoryId == null || categoryId <= 0) {
            return;
          }
          AppRouter.pushNamed(
            AppRoutes.productsPage,
            arguments: ProductsPage(
              params: GetProductsParams(mainCategory: CategoryEntity(id: categoryId, name: ad.name, image: const AttachmentEntity.empty())),
            ),
          );
        case AdType.offer:
          final int? offerProductId = ad.linkableId;
          if (offerProductId != null && offerProductId > 0) {
            AppRouter.pushNamed(AppRoutes.showProductDetailsPage, arguments: ShowProductDetailsPage(id: offerProductId));
            return;
          }
          AppRouter.pushNamed(
            AppRoutes.productsPage,
            arguments: const ProductsPage(params: GetProductsParams(page: 1, offersProductsOnly: true)),
          );
        case AdType.external:
          final String? url = ad.externalUrl?.trim();
          if (url == null || url.isEmpty) {
            return;
          }
          LaunchUrlUtils.openUrl(url: url);
        case AdType.none:
        case AdType.unknown:
          return;
      }
    },
  );
}

class _AdsPageIndicator extends StatelessWidget {
  const _AdsPageIndicator({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final bool isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: Durations.medium2,
          height: _kIndicatorHeight,
          width: isSelected ? _kIndicatorActiveWidth : _kIndicatorInactiveWidth,
          margin: EdgeInsetsDirectional.only(start: index == 0 ? 0 : _kIndicatorSpacing),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? AppColors.primary500 : _kIndicatorInactive,
          ),
        );
      }),
    );
  }
}

class AdsSliderLoadingWidget extends StatelessWidget {
  const AdsSliderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
      child: Column(
        children: [
          ShimmerWidget(
            child: Container(
              height: _kBannerHeight,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.primary100, borderRadius: BorderRadius.circular(_kBannerRadius)),
            ),
          ),
          const SizedBox(height: _kIndicatorGap),
          const SizedBox(height: _kIndicatorHeight),
        ],
      ),
    );
  }
}

class AdsSliderErrorWidget extends StatelessWidget {
  final void Function() onRetry;

  const AdsSliderErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
      child: Column(
        children: [
          Container(
            height: _kBannerHeight,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.black100, borderRadius: BorderRadius.circular(_kBannerRadius)),
            child: AppFailWidget(isMini: true, onRetry: onRetry),
          ),
          const SizedBox(height: _kIndicatorGap),
          const SizedBox(height: _kIndicatorHeight),
        ],
      ),
    );
  }
}
