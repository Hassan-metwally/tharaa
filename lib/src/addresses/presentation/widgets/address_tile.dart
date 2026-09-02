import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../material/media/svg_icon.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../my_addresses/my_addresses_cubit.dart';
import '../upsert_address/upsert_address_page.dart';
import '../widgets/remove_address_bottom_sheet.dart';

const Color kAddressCardFill = Color(0xFFF7F8FA);
const Color kAddressDescriptionColor = Color(0xFF94A3B8);
const double kAddressArrowSize = 32;
const double kAddressArrowIconSize = 16;
const double kAddressArrowRotationDeg = 34.84;
const double kAddressRadioSize = 32;
const double kAddressTileMinHeight = 60;
const int kAddressSelectorMaxVisibleItems = 4;

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.entity,
    this.isSelected = false,
    this.selectable = false,
    this.onSelected,
  });

  final LocationEntity entity;
  final bool isSelected;
  final bool selectable;
  final VoidCallback? onSelected;

  String get _description {
    if (selectable && entity.address.trim().isNotEmpty) return entity.address;
    return entity.description;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: selectable ? onSelected : () => UpssertAddressBottomSheet.show(context, address: entity),
      onLongPress: selectable
          ? null
          : () {
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
        decoration: BoxDecoration(
          color: selectable && isSelected  ? AppColors.primary50 : kAddressCardFill,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          // border: selectable && isSelected ? Border.all(color: AppColors.primary) : null,
        ),
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
                        if (entity.isDefault) ...[const SizedBox(width: Dimensions.p4), const DefaultAddressBadge()],
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.p8),
                  Text(
                    _description,
                    maxLines: selectable ? 2 : null,
                    overflow: selectable ? TextOverflow.ellipsis : null,
                    style: TextStyles.regular12.copyWith(color: kAddressDescriptionColor, height: 1),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.p4),
            if (selectable) AddressSelectionRadio(isSelected: isSelected) else const AddressArrowButton(),
          ],
        ),
      ),
    );
  }
}

class DefaultAddressBadge extends StatelessWidget {
  const DefaultAddressBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8, vertical: Dimensions.p4),
      decoration: BoxDecoration(color: AppColors.success50, borderRadius: BorderRadius.circular(Dimensions.r16)),
      child: Text(appLocalizer.defaultAddress, style: TextStyles.medium10.copyWith(color: AppColors.success500, height: 1)),
    );
  }
}

class AddressArrowButton extends StatelessWidget {
  const AddressArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    const double radians = kAddressArrowRotationDeg * math.pi / 180;

    return Container(
      width: kAddressArrowSize,
      height: kAddressArrowSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
      child: Transform.rotate(
        angle: isRtl ? radians : math.pi - radians,
        child: AppSvgIcon(path: AppIcons.arrowUpRight, width: kAddressArrowIconSize, height: kAddressArrowIconSize),
      ),
    );
  }
}

class AddressSelectionRadio extends StatelessWidget {
  const AddressSelectionRadio({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kAddressRadioSize,
      height: kAddressRadioSize,
      child: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        size: 24,
        color: isSelected ? AppColors.primary : const Color(0xFF8B9BB2),
      ),
    );
  }
}
