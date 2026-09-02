import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_empty_widget.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../domain/entities/location_entity.dart';
import '../my_addresses/my_addresses_cubit.dart';
import '../upsert_address/upsert_address_page.dart';
import '../utils/products_subscription.dart';
import '../widgets/address_tile.dart';

const double _kAddIconSize = 18;
const double _kScrollbarWidth = 3;
const double _kScrollbarGap = 6;
const double _kScrollbarMinThumbHeight = 24;

class AddressesListSelectorWidget extends StatelessWidget {
  const AddressesListSelectorWidget({super.key, required this.selectedAddressId, required this.onAddressSelected});

  final int? selectedAddressId;
  final ValueChanged<int> onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<MyAddressesCubit>()..getAddresses(),
      child: _AddressesListSelectorBody(selectedAddressId: selectedAddressId, onAddressSelected: onAddressSelected),
    );
  }
}

class _AddressesListSelectorBody extends StatefulWidget {
  const _AddressesListSelectorBody({required this.selectedAddressId, required this.onAddressSelected});

  final int? selectedAddressId;
  final ValueChanged<int> onAddressSelected;

  @override
  State<_AddressesListSelectorBody> createState() => _AddressesListSelectorBodyState();
}

class _AddressesListSelectorBodyState extends State<_AddressesListSelectorBody> {
  final _subscription = CompositeSubscription();
  final _scrollController = ScrollController();
  bool _didAutoSelect = false;

  @override
  void initState() {
    super.initState();
    _subscription.add(
      MyAddressesSubscription.stream().listen((_) {
        if (mounted) {
          context.read<MyAddressesCubit>().getAddresses();
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscription.dispose();
    super.dispose();
  }

  void _autoSelectDefault(List<LocationEntity> addresses) {
    if (_didAutoSelect || widget.selectedAddressId != null || addresses.isEmpty) return;
    _didAutoSelect = true;
    final LocationEntity selected = addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onAddressSelected(selected.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizer.deliveryAddress,
                style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => UpssertAddressBottomSheet.show(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appLocalizer.addNewAddress, style: TextStyles.semiBold16.copyWith(color: AppColors.primary, height: 1)),
                  const SizedBox(width: Dimensions.p4),
                  AppSvgIcon(path: AppIcons.add, width: _kAddIconSize, height: _kAddIconSize, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.p12),
        BlocBuilder<MyAddressesCubit, MyAddressesState>(
          builder: (context, state) {
            if (state.getMyAddressesState.isLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.p16),
                child: SpinKitLoadingWidget(),
              );
            }
            if (state.getMyAddressesState.isFailure) {
              return AppFailWidget(onRetry: () => context.read<MyAddressesCubit>().getAddresses());
            }
            if (!state.getMyAddressesState.isSuccess) {
              return const SizedBox.shrink();
            }

            final addresses = state.getMyAddressesState.data ?? [];
            _autoSelectDefault(addresses);

            if (addresses.isEmpty) {
              return AppEmptyWidget(
                text: appLocalizer.noAddressesYet,
                heightPercentage: 0.15,
                physics: const NeverScrollableScrollPhysics(),
              );
            }

            final bool scrollable = addresses.length > kAddressSelectorMaxVisibleItems;
            final double? listHeight = scrollable
                ? kAddressSelectorMaxVisibleItems * kAddressTileMinHeight + (kAddressSelectorMaxVisibleItems - 1) * Dimensions.p12
                : null;

            final listView = NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis != Axis.vertical) return false;
                return notification.depth == 0 && notification.metrics.maxScrollExtent > 0;
              },
              child: ListView.separated(
                controller: scrollable ? _scrollController : null,
                primary: false,
                shrinkWrap: !scrollable,
                physics: scrollable ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                separatorBuilder: (context, index) => const SizedBox(height: Dimensions.p12),
                itemBuilder: (context, index) {
                  final LocationEntity address = addresses[index];
                  return SizedBox(
                    height: kAddressTileMinHeight,
                    child: AddressTile(
                      entity: address,
                      selectable: true,
                      isSelected: address.id == widget.selectedAddressId,
                      onSelected: () => widget.onAddressSelected(address.id),
                    ),
                  );
                },
              ),
            );

            if (scrollable) {
              return SizedBox(
                height: listHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: listView),
                    const SizedBox(width: _kScrollbarGap),
                    _AddressListScrollbar(controller: _scrollController, height: listHeight!),
                  ],
                ),
              );
            }
            return listView;
          },
        ),
      ],
    );
  }
}

class _AddressListScrollbar extends StatelessWidget {
  const _AddressListScrollbar({required this.controller, required this.height});

  final ScrollController controller;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (!controller.hasClients) {
          return const SizedBox(width: _kScrollbarWidth);
        }

        final position = controller.position;
        if (!position.hasContentDimensions || !position.hasViewportDimension || position.maxScrollExtent <= 0) {
          return const SizedBox(width: _kScrollbarWidth);
        }

        final double viewport = position.viewportDimension;
        final double maxExtent = position.maxScrollExtent;
        final double contentExtent = viewport + maxExtent;
        final double thumbHeight = (viewport / contentExtent * height).clamp(_kScrollbarMinThumbHeight, height);
        final double thumbOffset = (position.pixels / maxExtent) * (height - thumbHeight);

        return SizedBox(
          width: _kScrollbarWidth,
          height: height,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black200.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(_kScrollbarWidth),
                ),
              ),
              Positioned(
                top: thumbOffset,
                left: 0,
                right: 0,
                child: Container(
                  height: thumbHeight,
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(_kScrollbarWidth)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
