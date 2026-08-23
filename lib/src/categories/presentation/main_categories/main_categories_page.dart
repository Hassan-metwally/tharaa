import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_empty_widget.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/shimmer/shimmer_effect_widget.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_main_categories_usecase.dart';
import 'main_categories_cubit.dart';
import 'utils/get_main_categories_subscription.dart';

part 'widgets/main_categories_filter_bottomsheet.dart';
part 'widgets/main_categories_header.dart';
part 'widgets/main_category_card.dart';

const Color _kCategoryCardFill = Color(0xFFF7F8FA);
const double _kCategoryCardHeight = 56;
const double _kCategoryCardPadding = Dimensions.p4;
const double _kCategoryImageHeight = _kCategoryCardHeight - (_kCategoryCardPadding * 2);
const double _kCategoryItemHeight = 83;
const double _kGridSpacing = Dimensions.p16;
const double _kMinCategoryItemWidth = 74;
const int _kMinGridCrossAxisCount = 4;
const int _kMaxGridCrossAxisCount = 8;
const int _kLoadingPlaceholderCount = 20;

class MainCategoriesPage extends StatelessWidget {
  const MainCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<MainCategoriesCubit>()..getMainCategories(),
      child: const _MainCategoriesBody(),
    );
  }
}

class _MainCategoriesBody extends StatefulWidget {
  const _MainCategoriesBody();

  @override
  State<_MainCategoriesBody> createState() => _MainCategoriesBodyState();
}

class _MainCategoriesBodyState extends State<_MainCategoriesBody> {
  final _mainCategoriesSubscriptionObj = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  late final MainCategoriesCubit _cubit;

  void _mainCategoriesSubsriptionListener() {
    _mainCategoriesSubscriptionObj.add(
      GetMainCategoriesSubscription.stream().listen((params) {
        _cubit.getMainCategories();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MainCategoriesCubit>();
    _mainCategoriesSubsriptionListener();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.getMoreMainCategories();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mainCategoriesSubscriptionObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const _MainCategoriesHeader(),
            Expanded(
              child: BlocBuilder<MainCategoriesCubit, MainCategoriesState>(
                builder: (context, state) {
                  return _MainCategoriesView(state: state, scrollController: _scrollController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainCategoriesView extends StatelessWidget {
  const _MainCategoriesView({required this.state, required this.scrollController});

  final MainCategoriesState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (state.getMainCategoriesState.isLoading) {
      return const _MainCategoriesLoadingGrid();
    }

    if (state.getMainCategoriesState.isFailure) {
      return AppFailWidget(onRetry: () => context.read<MainCategoriesCubit>().getMainCategories());
    }

    if (state.getMainCategoriesState.isSuccess) {
      final List<CategoryEntity> data = state.getMainCategoriesState.data ?? [];
      return LiquidPullToRefresh(
        color: AppColors.backgroundColor,
        backgroundColor: AppColors.primary,
        onRefresh: () {
          return context.read<MainCategoriesCubit>().getMainCategories();
        },
        child: data.isEmpty
            ? const AppEmptyWidget()
            : _MainCategoriesGrid(
                categories: data,
                scrollController: scrollController,
                isPaginationLoading: state.getMainCategoriesState.isPaginationLoading,
              ),
      );
    }

    return const SizedBox();
  }
}

class _MainCategoriesGrid extends StatelessWidget {
  const _MainCategoriesGrid({
    required this.categories,
    required this.scrollController,
    required this.isPaginationLoading,
  });

  final List<CategoryEntity> categories;
  final ScrollController scrollController;
  final bool isPaginationLoading;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            GridView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCountFor(constraints.maxWidth - (Dimensions.p16 * 2)),
                crossAxisSpacing: _kGridSpacing,
                mainAxisSpacing: _kGridSpacing,
                mainAxisExtent: _kCategoryItemHeight,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) => _MainCategoryCard(entity: categories[index]),
            ),
            if (isPaginationLoading)
              const Positioned(
                bottom: -10,
                right: 0,
                left: 0,
                child: Center(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: SpinKitLoadingWidget()),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MainCategoriesLoadingGrid extends StatelessWidget {
  const _MainCategoriesLoadingGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCountFor(constraints.maxWidth - (Dimensions.p16 * 2)),
            crossAxisSpacing: _kGridSpacing,
            mainAxisSpacing: _kGridSpacing,
            mainAxisExtent: _kCategoryItemHeight,
          ),
          itemCount: _kLoadingPlaceholderCount,
          itemBuilder: (context, index) => const _MainCategoryCardShimmer(),
        );
      },
    );
  }
}

int _crossAxisCountFor(double availableWidth) {
  final int count = ((availableWidth + _kGridSpacing) / (_kMinCategoryItemWidth + _kGridSpacing)).floor();
  return count.clamp(_kMinGridCrossAxisCount, _kMaxGridCrossAxisCount);
}
