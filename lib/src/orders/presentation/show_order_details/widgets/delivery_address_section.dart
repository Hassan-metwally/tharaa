part of '../show_order_details_page.dart';

const double _kDeliveryMarkerHaloSize = 40;
const double _kDeliveryMarkerDotSize = 12;
const double _kDeliveryMarkerDotBorder = 2;
const double _kDeliveryMarkerOffsetX = -5.68;
const double _kDeliveryMarkerOffsetY = 12;
const double _kDeliverySectionTitleHeight = 28;

class _DeliveryAddressSection extends StatelessWidget {
  const _DeliveryAddressSection({required this.address});

  final LocationEntity address;

  String get _addressLabel {
    if (address.address.trim().isNotEmpty) return address.address;
    return address.description;
  }

  void _openMapPreview() {
    AppRouter.pushNamed(
      AppRoutes.mapsMainPage,
      arguments: MapsMainPage(
        onlyPreviewAddress: true,
        initialMapAddress: MapAddressEntity(address: _addressLabel, lat: address.lat, lng: address.lng, title: address.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _kDeliverySectionTitleHeight,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              appLocalizer.deliveryAddress,
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
            spacing: Dimensions.p4,
            children: [
              GestureDetector(
                onTap: _openMapPreview,
                behavior: HitTestBehavior.opaque,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.r16),
                  child: SizedBox(
                    height: _kMapHeight,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppImage(
                          path: GoogleMapsConstants.getStaticMapImage(lat: address.lat, long: address.lng),
                          cacheImage: true,
                        ),
                        Align(
                          child: Transform.translate(
                            offset: const Offset(_kDeliveryMarkerOffsetX, _kDeliveryMarkerOffsetY),
                            child: const _DeliveryMapPin(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p12),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r16)),
                child: Row(
                  children: [
                    AppSvgIcon(path: AppIcons.location, width: Dimensions.ic24, height: Dimensions.ic24),
                    const SizedBox(width: Dimensions.p6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            appLocalizer.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _addressLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyles.medium16.copyWith(color: AppColors.black900, height: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeliveryMapPin extends StatelessWidget {
  const _DeliveryMapPin();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDeliveryMarkerHaloSize,
      height: _kDeliveryMarkerHaloSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: _kDeliveryMarkerHaloSize,
            height: _kDeliveryMarkerHaloSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacityPercent(30)),
          ),
          Container(
            width: _kDeliveryMarkerDotSize,
            height: _kDeliveryMarkerDotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.white, width: _kDeliveryMarkerDotBorder),
            ),
          ),
        ],
      ),
    );
  }
}
