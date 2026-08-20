part of '../my_addresses_page.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.entity});

  final LocationEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.black.withAlpha(25), blurRadius: 4, offset: const Offset(0, 0.6))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(appLocalizer.addressDetails, style: TextStyles.regular14.copyWith(color: AppColors.black900)),
              ),
              Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      UpssertAddressBottomSheet.show(context, address: entity);
                    },
                    child: AppSvgIcon(path: ""),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _RemoveAddressBottomSheet.show(
                        context,
                        location: DeleteLocationParams(id: entity.id),
                        onLocationRemoved: () {
                          context.read<MyAddressesCubit>().getAddresses();
                        },
                      );
                    },
                    child: AppSvgIcon(path: ""),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 12, color: AppColors.black50),

          const SizedBox(height: 12),
          Row(
            children: [
              AppSvgIcon(path: ""),
              const SizedBox(width: 8),
              Text(appLocalizer.district, style: TextStyles.regular14.copyWith(color: AppColors.black700)),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  entity.district,
                  style: TextStyles.regular14.copyWith(color: AppColors.black900),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              AppSvgIcon(path: ""),
              const SizedBox(width: 8),
              Text(appLocalizer.building, style: TextStyles.regular14.copyWith(color: AppColors.black700)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  entity.building,
                  style: TextStyles.medium14.copyWith(color: AppColors.black900),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AppSvgIcon(path: ""),
              const SizedBox(width: 16),
              Expanded(
                child: Text(appLocalizer.locationOnMap, style: TextStyles.regular14.copyWith(color: AppColors.black700)),
              ),
              SizedBox(width: 8),
              AppSvgIcon(path: ""),
            ],
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              AppRouter.pushNamed(
                AppRoutes.mapsMainPage,
                arguments: MapsMainPage(
                  onlyPreviewAddress: true,
                  initialMapAddress: MapAddressEntity(address: entity.address, lat: entity.lat, lng: entity.lng),
                ),
              );
            },
            child: AppImage.rounded(
              fit: BoxFit.cover,
              radius: 8,
              height: 140,
              width: double.infinity,
              path: GoogleMapsConstants.getStaticMapImage(lat: entity.lat, long: entity.lng),
            ),
          ),
        ],
      ),
    );
  }
}
