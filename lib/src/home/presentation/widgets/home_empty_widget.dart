import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../material/media/svg_icon.dart';

class HomeEmptyWidget extends StatelessWidget {
  final String? message;
  final String? iconPath;
  final String? title;
  const HomeEmptyWidget({this.message, super.key, this.iconPath, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: TextStyles.medium16),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            boxShadow: [BoxShadow(color: AppColors.black.withAlpha(25), offset: const Offset(0, 0.6), blurRadius: 4)],
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                AppSvgIcon(path: iconPath ?? "AppIcons.box"),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: Text(
                    message ?? appLocalizer.noResultFound,
                    style: TextStyles.medium14.copyWith(color: AppColors.black500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
