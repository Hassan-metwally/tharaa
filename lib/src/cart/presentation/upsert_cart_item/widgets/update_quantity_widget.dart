import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/toast/app_toast.dart';

class UpdateCartItemQuantityWidget extends StatefulWidget {
  final int? cartQuantity;
  final int? availableQuantity;
  final Function(int quantity) onQuantityChanged;
  final double? radius;
  final double? iconSize;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const UpdateCartItemQuantityWidget({
    super.key,
    this.cartQuantity,
    this.availableQuantity,
    required this.onQuantityChanged,
    this.iconSize,
    this.textStyle,
    this.padding,
    this.radius,
  });

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
    const double defaultIconSize = 20;

    return Container(
      decoration: BoxDecoration(color: AppColors.white100, borderRadius: BorderRadius.circular(widget.radius ?? 12)),
      child: Padding(
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (quantity >= availableQuantity) {
                  AppToasts.error(context, message: appLocalizer.youCannotAddMoreThanTheAvailableQuantity);
                  return;
                } else {
                  setState(() {
                    quantity += 1;
                    widget.onQuantityChanged(quantity);
                  });
                }
              },
              child: AppSvgIcon(path: "", width: widget.iconSize ?? defaultIconSize, height: widget.iconSize ?? defaultIconSize),
            ),
            SizedBox(width: 6),
            AnimatedFlipCounter(
              value: quantity,
              textStyle: widget.textStyle ?? TextStyles.medium16.copyWith(color: AppColors.black900),
            ),
            SizedBox(width: 6),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (quantity > 1) {
                  setState(() {
                    quantity -= 1;
                    widget.onQuantityChanged(quantity);
                  });
                }
              },
              child: AppSvgIcon(path: "", width: widget.iconSize ?? defaultIconSize, height: widget.iconSize ?? defaultIconSize),
            ),
          ],
        ),
      ),
    );
  }
}
