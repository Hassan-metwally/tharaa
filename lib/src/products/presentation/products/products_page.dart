import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_empty_widget.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/domain/usecases/get_sub_categories_usecase.dart';
import '../../../categories/presentation/main_categories/main_categories_cubit.dart';
import '../../../categories/presentation/sub_categories/sub_categories_cubit.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'products_cubit.dart';
import 'utils/get_products_subscription.dart';
import 'widgets/product_grid_card.dart';
import 'widgets/products_app_bar.dart';
import 'widgets/products_filter_chips.dart';
import 'widgets/products_page_mode.dart';
import 'widgets/products_search_field.dart';
import 'widgets/products_sort_offers_row.dart';

class ProductsPage extends StatelessWidget {
  final GetProductsParams params;
  const ProductsPage({super.key, this.params = const GetProductsParams.initial()});

  @override
  Widget build(BuildContext context) {
    final ProductsPageMode mode = productsPageModeOf(params);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<ProductsCubit>()
            ..updateParams(params)
            ..getProducts(),
        ),
        BlocProvider(
          create: (context) {
            final SubCategoriesCubit cubit = injector<SubCategoriesCubit>();
            if (mode == ProductsPageMode.category && params.mainCategory != null) {
              cubit
                ..updateParams(GetSubCategoriesParams.initial(categoryId: params.mainCategory!.id))
                ..getSubCategories();
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final MainCategoriesCubit cubit = injector<MainCategoriesCubit>();
            if (mode != ProductsPageMode.category) {
              cubit.getMainCategories();
            }
            return cubit;
          },
        ),
      ],
      child: _ProductsBody(mode: mode, entryParams: params),
    );
  }
}

class _ProductsBody extends StatefulWidget {
  const _ProductsBody({required this.mode, required this.entryParams});

  final ProductsPageMode mode;
  final GetProductsParams entryParams;

  @override
  State<_ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<_ProductsBody> {
  final CompositeSubscription _productsSubscription = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late final ProductsCubit _cubit;
  Timer? _searchDebounce;
  late ProductsSortOption _sortOption;

  bool get _showSortRow => widget.mode != ProductsPageMode.offers;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductsCubit>();
    _sortOption = widget.mode == ProductsPageMode.mostRequested ? ProductsSortOption.priceHighToLow : ProductsSortOption.mostRequested;
    _searchController.text = widget.entryParams.search ?? '';
    _productsSubscription.add(
      GetProductsSubscription.stream().listen((_) {
        _cubit.getProducts();
      }),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.getMoreProducts();
        }
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    _productsSubscription.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.mode) {
      case ProductsPageMode.offers:
        return appLocalizer.offersTitle;
      case ProductsPageMode.mostRequested:
        return appLocalizer.mostRequestedTitle;
      case ProductsPageMode.category:
        return widget.entryParams.mainCategory?.name ?? '';
    }
  }

  void _applyParams(GetProductsParams params) {
    _cubit.updateParams(params);
    _cubit.getProducts();
  }

  GetProductsParams _buildParams({
    String? search,
    bool? offersProductsOnly,
    CategoryEntity? mainCategory,
    CategoryEntity? subCategory,
    bool clearMainCategory = false,
    bool clearSubCategory = false,
  }) {
    final GetProductsParams current = _cubit.state.params;
    return GetProductsParams(
      page: 1,
      search: search ?? current.search,
      offersProductsOnly: offersProductsOnly ?? current.offersProductsOnly,
      mostRequestedProductsOnly: widget.entryParams.mostRequestedProductsOnly,
      mainCategory: clearMainCategory
          ? (widget.mode == ProductsPageMode.category ? widget.entryParams.mainCategory : null)
          : (mainCategory ?? current.mainCategory),
      subCategory: clearSubCategory ? null : (subCategory ?? current.subCategory),
    );
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _applyParams(_buildParams(search: value.trim().isEmpty ? '' : value.trim()));
    });
  }

  void _onChipSelected(CategoryEntity? category) {
    if (widget.mode == ProductsPageMode.category) {
      _applyParams(_buildParams(subCategory: category, clearSubCategory: category == null));
      return;
    }
    _applyParams(_buildParams(mainCategory: category, clearMainCategory: category == null, clearSubCategory: true));
  }

  List<ProductEntity> _sorted(List<ProductEntity> products) {
    if (_sortOption == ProductsSortOption.mostRequested) {
      return products;
    }
    final List<ProductEntity> sorted = [...products];
    sorted.sort((a, b) {
      final num priceA = a.offerPrice ?? a.price;
      final num priceB = b.offerPrice ?? b.price;
      return _sortOption == ProductsSortOption.priceHighToLow ? priceB.compareTo(priceA) : priceA.compareTo(priceB);
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          ProductsAppBar(title: _title, showBack: widget.mode != ProductsPageMode.offers || Navigator.of(context).canPop()),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                final CategoryEntity? selectedChip = widget.mode == ProductsPageMode.category
                    ? state.params.subCategory
                    : state.params.mainCategory;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
                      child: ProductsSearchField(controller: _searchController, onChanged: _onSearchChanged),
                    ),
                    const SizedBox(height: Dimensions.p24),
                    ProductsFilterChips(mode: widget.mode, selectedCategory: selectedChip, onSelected: _onChipSelected),
                    if (_showSortRow) ...[
                      const SizedBox(height: Dimensions.p24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
                        child: ProductsSortOffersRow(
                          mode: widget.mode,
                          sortOption: _sortOption,
                          offersOnly: state.params.offersProductsOnly == true,
                          onSortChanged: (option) => setState(() => _sortOption = option),
                          onOffersOnlyChanged: (value) => _applyParams(_buildParams(offersProductsOnly: value)),
                        ),
                      ),
                    ],
                    const SizedBox(height: Dimensions.p24),
                    Expanded(child: _buildGridArea(state)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridArea(ProductsState state) {
    if (state.getProductsState.isLoading) {
      return const Center(child: SpinKitLoadingWidget());
    }
    if (state.getProductsState.isFailure) {
      return AppFailWidget(onRetry: _cubit.getProducts);
    }
    if (state.getProductsState.isSuccess) {
      final List<ProductEntity> data = _sorted(state.getProductsState.data ?? []);
      return LiquidPullToRefresh(
        color: AppColors.backgroundColor,
        backgroundColor: AppColors.primary,
        onRefresh: _cubit.getProducts,
        child: data.isEmpty
            ? AppEmptyWidget(
                heightPercentage: 0.48,
                text: appLocalizer.noProductsInThisSection,
                subText: appLocalizer.noProductsInThisSubsection,
                imagePath: AppImages.emptyProducts,
                imageFit: BoxFit.contain,
                imageSize: 200 / 0.7,
                spacing: Dimensions.p32 / 0.7,
                subTextSpacing: Dimensions.p16,
                textStyle: TextStyles.semiBold22.copyWith(color: AppColors.black),
                subTextStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final int crossAxisCount = constraints.maxWidth >= 600 ? 3 : 2;
                  const double spacing = 12;
                  final double itemWidth = (constraints.maxWidth - Dimensions.p16 * 2 - spacing * (crossAxisCount - 1)) / crossAxisCount;
                  const double itemHeight = 228;
                  return Stack(
                    children: [
                      GridView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p96, ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) => ProductGridCard(
                          entity: data[index],
                        ),
                      ),
                      if (state.getProductsState.isPaginationLoading)
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
              ),
      );
    }
    return const SizedBox();
  }
}
