import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/toast/app_toast.dart';

const double _kQuantitySelectorWidth = 112;
const double _kQuantitySelectorRadius = 18;
const double _kQuantityButtonSize = 38;
const double _kQuantityIconSize = 24;

class UpdateCartItemQuantityWidget extends StatefulWidget {
  final int? cartQuantity;
  final int? availableQuantity;
  final Function(int quantity) onQuantityChanged;

  const UpdateCartItemQuantityWidget({super.key, this.cartQuantity, this.availableQuantity, required this.onQuantityChanged});

  @override
  State<UpdateCartItemQuantityWidget> createState() => _UpdateCartItemQuantityWidgetState();
}

class _UpdateCartItemQuantityWidgetState extends State<UpdateCartItemQuantityWidget> {
  late int quantity;
  late int availableQuantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartQuantity ?? 1;
    availableQuantity = widget.availableQuantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kQuantitySelectorWidth,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(_kQuantitySelectorRadius)),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuantityIconButton(
            icon: AppIcons.add,
            onTap: () {
              if (quantity >= availableQuantity) {
                AppToasts.error(context, message: appLocalizer.youCannotAddMoreThanTheAvailableQuantity);
                return;
              }
              setState(() {
                quantity += 1;
                widget.onQuantityChanged(quantity);
              });
            },
          ),
          AnimatedFlipCounter(
            value: quantity,
            textStyle: TextStyles.medium18.copyWith(color: AppColors.black900, height: 1),
          ),
          _QuantityIconButton(
            icon: AppIcons.minus,
            onTap: () {
              if (quantity > 1) {
                setState(() {
                  quantity -= 1;
                  widget.onQuantityChanged(quantity);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  const _QuantityIconButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: _kQuantityButtonSize,
        height: _kQuantityButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: AppSvgIcon(path: icon, width: _kQuantityIconSize, height: _kQuantityIconSize, color: AppColors.black900),
      ),
    );
  }
}
