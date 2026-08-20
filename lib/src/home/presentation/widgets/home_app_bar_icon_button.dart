import 'package:flutter/material.dart';

import '../../../../../material/media/svg_icon.dart';
import '../../../../core/core.dart';

class HomeAppBarIconButton extends StatelessWidget {
  const HomeAppBarIconButton({
    required this.onTap,
    required this.icon,
    this.iconBadgeCount = 0,
    this.iconColor = const Color(0xffEC1C23),
    super.key,
  });
  final void Function()? onTap;
  final String icon;
  final int iconBadgeCount;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            width: 32,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.black50),
            child: AppSvgIcon(path: icon, width: 16, height: 16),
          ),
          if (iconBadgeCount > 0)
            Positioned(
              top: 3,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                constraints: BoxConstraints(maxHeight: 18, maxWidth: 15),
                decoration: BoxDecoration(color: AppColors.red600, borderRadius: BorderRadius.circular(4)),
                child: FittedBox(
                  child: Text(
                    iconBadgeCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.regular10.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
