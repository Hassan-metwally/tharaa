import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../material/app_empty_widget.dart';

class SearchProductsEmpty extends StatelessWidget {
  const SearchProductsEmpty({super.key, required this.isIdle});

  final bool isIdle;

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      text: isIdle ? appLocalizer.whatAreYouLookingFor : appLocalizer.noSearchResults,
      subText: isIdle ? appLocalizer.searchIdleSubtitle : appLocalizer.noSearchResultsSubtitle,
      imagePath: AppImages.emptySearch,
      imageFit: BoxFit.contain,
      imageSize: 207 / 0.7,
      spacing: Dimensions.p32 / 0.48,
      subTextSpacing: Dimensions.p4,
      textStyle: TextStyles.semiBold22.copyWith(color: AppColors.black),
      subTextStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText),
    );
  }
}
