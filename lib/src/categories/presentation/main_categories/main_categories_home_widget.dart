import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../home/presentation/widgets/home_empty_widget.dart';
import '../../domain/entities/category_entity.dart';
import '../sub_categories/sub_categories_page.dart';
import 'main_categories_cubit.dart';
import 'main_categories_page.dart';

const Color _kCategoryCardFill = Color(0xFFF7F8FA);
const double _kSectionHeaderHeight = 28;
const double _kCategoryCardHeight = 56;
const double _kCategoryCardPadding = Dimensions.p4;
const double _kCategoryImageHeight = _kCategoryCardHeight - (_kCategoryCardPadding * 2);
const double _kArrowHitSize = 28;
const double _kArrowIconSize = 20;
const double _kArrowRotationDeg = 48.31;
const int _kHomePreviewCount = 4;

class MainCategoriesHomeWidget extends StatelessWidget {
  const MainCategoriesHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<MainCategoriesCubit>()..getMainCategories(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.p16),
        child: _MainCategoriesHomeBody(),
      ),
    );
  }
}

class _MainCategoriesHomeBody extends StatelessWidget {
  const _MainCategoriesHomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCategoriesCubit, MainCategoriesState>(
      builder: (context, state) {
        if (state.getMainCategoriesState.isLoading) {
          return const _MainCategoriesHomeLoading();
        }
        if (state.getMainCategoriesState.isFailure) {
          return _MainCategoriesHomeError(
            onRetry: () => context.read<MainCategoriesCubit>().getMainCategories(),
          );
        }
        if (state.getMainCategoriesState.isSuccess) {
          final List<CategoryEntity> categories = state.getMainCategoriesState.data ?? [];
          if (categories.isEmpty) {
            return HomeEmptyWidget(
              title: appLocalizer.mainCategories,
              message: appLocalizer.noResultFound,
              iconPath: AppIcons.elementEqual,
            );
          }
          return _MainCategoriesHomeContent(categories: categories.take(_kHomePreviewCount).toList());
        }
        return const SizedBox();
      },
    );
  }
}

class _MainCategoriesHomeContent extends StatelessWidget {
  const _MainCategoriesHomeContent({required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MainCategoriesHomeHeader(),
        const SizedBox(height: Dimensions.p12),
        Row(
          children: [
            for (int index = 0; index < categories.length; index++) ...[
              if (index > 0) const SizedBox(width: Dimensions.p16),
              Expanded(child: _MainCategoryHomeItem(entity: categories[index])),
            ],
          ],
        ),
      ],
    );
  }
}

class _MainCategoriesHomeHeader extends StatelessWidget {
  const _MainCategoriesHomeHeader();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    const double radians = _kArrowRotationDeg * math.pi / 180;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.mainCategoriesPage, arguments: const MainCategoriesPage());
      },
      child: SizedBox(
        height: _kSectionHeaderHeight,
        child: Row(
          children: [
            Expanded(
              child: Text(
                appLocalizer.mainCategories,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              appLocalizer.viewMore,
              style: TextStyles.medium14.copyWith(color: AppColors.mutedText, height: 1),
            ),
            SizedBox(
              width: _kArrowHitSize,
              height: _kArrowHitSize,
              child: Center(
                child: Transform.rotate(
                  angle: isRtl ? radians : math.pi - radians,
                  child: AppSvgIcon(path: AppIcons.arrowUpRight, width: _kArrowIconSize, height: _kArrowIconSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainCategoryHomeItem extends StatelessWidget {
  const _MainCategoryHomeItem({required this.entity});

  final CategoryEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.subCategoriesPage, arguments: SubCategoriesPage(categoryId: entity.id));
      },
      child: Column(
        children: [
          Container(
            height: _kCategoryCardHeight,
            width: double.infinity,
            padding: const EdgeInsets.all(_kCategoryCardPadding),
            decoration: BoxDecoration(
              color: _kCategoryCardFill,
              borderRadius: BorderRadius.circular(Dimensions.r16),
            ),
            child: AppImage.rounded(
              path: entity.image.path,
              height: _kCategoryImageHeight,
              width: double.infinity,
              radius: Dimensions.r4,
              fit: BoxFit.cover,
              bgColor: _kCategoryCardFill,
            ),
          ),
          const SizedBox(height: Dimensions.p4),
          Text(
            entity.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyles.medium14.copyWith(color: AppColors.black900, height: 1),
          ),
        ],
      ),
    );
  }
}

class _MainCategoriesHomeLoading extends StatelessWidget {
  const _MainCategoriesHomeLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MainCategoriesHomeHeader(),
        const SizedBox(height: Dimensions.p12),
        Row(
          children: [
            for (int index = 0; index < _kHomePreviewCount; index++) ...[
              if (index > 0) const SizedBox(width: Dimensions.p16),
              const Expanded(child: _MainCategoryHomeItemShimmer()),
            ],
          ],
        ),
      ],
    );
  }
}

class _MainCategoryHomeItemShimmer extends StatelessWidget {
  const _MainCategoryHomeItemShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          Container(
            height: _kCategoryCardHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(Dimensions.r16),
            ),
          ),
          const SizedBox(height: Dimensions.p4),
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(Dimensions.r4),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainCategoriesHomeError extends StatelessWidget {
  const _MainCategoriesHomeError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MainCategoriesHomeHeader(),
        const SizedBox(height: Dimensions.p12),
        SizedBox(
          height: _kCategoryCardHeight + Dimensions.p4 + 14,
          child: AppFailWidget.mini(onRetry: onRetry),
        ),
      ],
    );
  }
}
