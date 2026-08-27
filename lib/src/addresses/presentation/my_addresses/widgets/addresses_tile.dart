part of '../my_addresses_page.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.entity});

  final LocationEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => UpssertAddressBottomSheet.show(context, address: entity),
      onLongPress: () {
        RemoveAddressBottomSheet.show(
          context,
          location: DeleteLocationParams(id: entity.id),
          onLocationRemoved: () {
            context.read<MyAddressesCubit>().getAddresses();
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p8),
        decoration: BoxDecoration(color: _kAddressCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            entity.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.medium12.copyWith(color: AppColors.black900, height: 1),
                          ),
                        ),
                        if (entity.isDefault) ...[const SizedBox(width: Dimensions.p4), const _DefaultAddressBadge()],
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.p8),
                  Text(entity.description, style: TextStyles.regular12.copyWith(color: _kAddressDescriptionColor, height: 1)),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.p4),
            const _AddressArrowButton(),
          ],
        ),
      ),
    );
  }
}

class _DefaultAddressBadge extends StatelessWidget {
  const _DefaultAddressBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p4),
      decoration: BoxDecoration(color: AppColors.success50, borderRadius: BorderRadius.circular(Dimensions.r16)),
      child: Text(appLocalizer.defaultAddress, style: TextStyles.medium10.copyWith(color: AppColors.success500, height: 1)),
    );
  }
}

class _AddressArrowButton extends StatelessWidget {
  const _AddressArrowButton();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    const double radians = _kAddressArrowRotationDeg * math.pi / 180;

    return Container(
      width: _kAddressArrowSize,
      height: _kAddressArrowSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
      child: Transform.rotate(
        angle: isRtl ? radians : math.pi - radians,
        child: AppSvgIcon(path: AppIcons.arrowUpRight, width: _kAddressArrowIconSize, height: _kAddressArrowIconSize),
      ),
    );
  }
}
