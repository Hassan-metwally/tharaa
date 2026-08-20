part of "../maps_main_page.dart";

class _OnlyMapAddressPreviewWidget extends StatelessWidget {
  const _OnlyMapAddressPreviewWidget({required this.addressEntity, required this.onAddressTapped});
  final MapAddressEntity addressEntity;
  final void Function() onAddressTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBar(title: Text(appLocalizer.maps, style: TextStyles.bold16), centerTitle: true),
        InkWell(
          onTap: onAddressTapped,
          child: Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocalizer.addressDetails, style: TextStyles.bold15.copyWith(color: AppColors.black800)),
                  const SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.backgroundColor, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 22, color: AppColors.black800),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            addressEntity.address,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.semiBold14.copyWith(color: AppColors.black800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
