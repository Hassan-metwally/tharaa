part of "../maps_main_page.dart";

class _SelectableMapWidgets extends StatefulWidget {
  const _SelectableMapWidgets({required this.canAddTittleForAddress});
  final bool canAddTittleForAddress;

  @override
  State<_SelectableMapWidgets> createState() => _SelectableMapWidgetsState();
}

class _SelectableMapWidgetsState extends State<_SelectableMapWidgets> {
  final _titleController = TextEditingController();

  @override
  void initState() {
    _titleController.text = context.read<MapsMainCubit>().state.locationState.data?.title ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MapsAppBarWidget(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                if (widget.canAddTittleForAddress)
                  AppTextFormField(
                    controller: _titleController,
                    label: appLocalizer.addressTitle,
                    // isRequired: true,
                  ),
                if (widget.canAddTittleForAddress) const SizedBox(height: 10),
                BlocBuilder<MapsMainCubit, MapsMainState>(
                  buildWhen: (previous, current) => previous.locationState != current.locationState,
                  builder: (context, state) {
                    final locationData = state.locationState.data;

                    if (widget.canAddTittleForAddress == false) {
                      return AppButton(
                        text: appLocalizer.done,
                        onPressed: locationData != null
                            ? () {
                                context.read<MapsMainCubit>().updateAddress(locationData);
                                Navigator.of(context).pop(locationData);
                              }
                            : null,
                      );
                    }
                    return AppButton(
                      text: appLocalizer.confirm,
                      onPressed: locationData != null && _titleController.text.isNotEmpty
                          ? () {
                              final address = MapAddressEntity(
                                title: _titleController.text,
                                address: locationData.address,
                                lat: locationData.lat,
                                lng: locationData.lng,
                              );
                              context.read<MapsMainCubit>().updateAddress(address);
                              Navigator.of(context).pop(address);
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
