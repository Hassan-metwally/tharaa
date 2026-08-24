import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../categories/domain/entities/category_entity.dart';
import '../../../../categories/presentation/main_categories/main_categories_cubit.dart';
import '../../../../categories/presentation/sub_categories/sub_categories_cubit.dart';
import 'products_page_mode.dart';

const Color _kChipFill = Color(0xFFF7F8FA);

class ProductsFilterChips extends StatelessWidget {
  const ProductsFilterChips({
    super.key,
    required this.mode,
    required this.selectedCategory,
    required this.onSelected,
  });

  final ProductsPageMode mode;
  final CategoryEntity? selectedCategory;
  final ValueChanged<CategoryEntity?> onSelected;

  @override
  Widget build(BuildContext context) {
    if (mode == ProductsPageMode.category) {
      return BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        builder: (context, state) {
          final List<CategoryEntity> categories = state.getSubCategoriesState.data ?? const [];
          if (state.getSubCategoriesState.isFailure && categories.isEmpty) {
            return const SizedBox.shrink();
          }
          return _ChipsRow(
            categories: categories,
            selectedId: selectedCategory?.id,
            onSelected: onSelected,
          );
        },
      );
    }

    return BlocBuilder<MainCategoriesCubit, MainCategoriesState>(
      builder: (context, state) {
        final List<CategoryEntity> categories = state.getMainCategoriesState.data ?? const [];
        if (state.getMainCategoriesState.isFailure && categories.isEmpty) {
          return const SizedBox.shrink();
        }
        return _ChipsRow(
          categories: categories,
          selectedId: selectedCategory?.id,
          onSelected: onSelected,
        );
      },
    );
  }
}

class _ChipsRow extends StatelessWidget {
  const _ChipsRow({required this.categories, required this.selectedId, required this.onSelected});

  final List<CategoryEntity> categories;
  final int? selectedId;
  final ValueChanged<CategoryEntity?> onSelected;

  @override
  Widget build(BuildContext context) {
    final bool isAllSelected = selectedId == null;
    final int itemCount = categories.length + 1;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: Dimensions.p12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _Chip(
              label: appLocalizer.all,
              isSelected: isAllSelected,
              onTap: () => onSelected(null),
            );
          }
          final CategoryEntity category = categories[index - 1];
          return _Chip(
            label: category.name,
            isSelected: selectedId == category.id,
            onTap: () => onSelected(category),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.p8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : _kChipFill,
          borderRadius: BorderRadius.circular(Dimensions.r8),
        ),
        child: Text(
          label,
          style: TextStyles.medium14.copyWith(
            color: isSelected ? AppColors.white : AppColors.mutedText,
            height: 1,
          ),
        ),
      ),
    );
  }
}
