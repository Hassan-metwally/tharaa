import 'package:flutter/material.dart';

import '../../../core/config/theme/app_theme.dart';
import '../../../core/core.dart';

class ChatDecorationConstants {
  ChatDecorationConstants._();
  static const double avatarSize = 50.0;
  static const double avatarRadius = 25.0;

  static double getMaxCellWidth(BuildContext context) {
    return context.screenWidth * .75;
  }

  static double get getMinCellWidth => 100;

  static const otherCellRadious = BorderRadiusDirectional.only(
    topStart: Radius.circular(8),
    bottomEnd: Radius.circular(8),
    bottomStart: Radius.circular(8),
  );

  static const ownerCellRadious = BorderRadiusDirectional.only(
    topEnd: Radius.circular(8),
    bottomEnd: Radius.circular(8),
    bottomStart: Radius.circular(8),
  );

  static Color get ownerCellBgColor => getThemeColor(lightColor: AppColors.primary50, darkColor: AppColors.blue400);

  static Color get otherCellBgColor => getThemeColor(lightColor: AppColors.white, darkColor: AppColors.secondary300);

  static const EdgeInsetsGeometry cellPadding = EdgeInsets.all(10);

  static const EdgeInsetsGeometry cellMargin = EdgeInsets.symmetric();

  static Decoration get ownerCellDecoration => BoxDecoration(
    color: ownerCellBgColor,
    borderRadius: ownerCellRadious,
    boxShadow: [BoxShadow(color: Colors.grey.withAlpha(22), blurRadius: 4, spreadRadius: 2, offset: const Offset(0, .5))],
  );

  static Decoration get otherCellDecoration => BoxDecoration(
    color: otherCellBgColor,
    borderRadius: otherCellRadious,
    boxShadow: [BoxShadow(color: Colors.grey.withAlpha(22), blurRadius: 4, spreadRadius: 2, offset: const Offset(0, .5))],
  );
}
