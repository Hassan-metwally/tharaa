import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'products_cubit.dart';
import 'utils/get_products_subscription.dart';
import 'widgets/product_grid_card.dart';
import 'widgets/products_search_field.dart';
import 'widgets/search_products_empty.dart';

class SearchProductsPage extends StatelessWidget {
  const SearchProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ProductsCubit>(),
      child: const _SearchProductsBody(),
    );
  }
}

class _SearchProductsBody extends StatefulWidget {
  const _SearchProductsBody();

  @override
  State<_SearchProductsBody> createState() => _SearchProductsBodyState();
}

class _SearchProductsBodyState extends State<_SearchProductsBody> {
  final CompositeSubscription _productsSubscription = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late final ProductsCubit _cubit;
  Timer? _searchDebounce;
  String _submittedQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductsCubit>();
    _productsSubscription.add(
      GetProductsSubscription.stream().listen((_) {
        if (_submittedQuery.isNotEmpty) {
          _cubit.getProducts();
        }
      }),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted && _submittedQuery.isNotEmpty) {
          _cubit.getMoreProducts();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _productsSubscription.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    final String query = value.trim();
    _searchDebounce?.cancel();
    if (query.isEmpty) {
      if (_submittedQuery.isNotEmpty) {
        setState(() => _submittedQuery = '');
      }
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _submittedQuery = query);
      _cubit.updateParams(GetProductsParams(page: 1, search: query));
      _cubit.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text(appLocalizer.searchTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
            child: ProductsSearchField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) => _buildContent(state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ProductsState state) {
    if (_submittedQuery.isEmpty) {
      return const SearchProductsEmpty(isIdle: true);
    }
    if (state.getProductsState.isLoading || state.getProductsState.isInitial) {
      return const Center(child: SpinKitLoadingWidget());
    }
    if (state.getProductsState.isFailure) {
      return AppFailWidget(onRetry: _cubit.getProducts);
    }
    if (state.getProductsState.isSuccess) {
      final List<ProductEntity> data = state.getProductsState.data ?? [];
      if (data.isEmpty) {
        return const SearchProductsEmpty(isIdle: false);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimensions.p24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
            child: Text(
              appLocalizer.searchResults,
              textAlign: TextAlign.start,
              style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: Dimensions.p12),
          Expanded(child: _buildGrid(state, data)),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildGrid(ProductsState state, List<ProductEntity> data) {
    return LayoutBuilder(
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
              padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p96),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => ProductGridCard(entity: data[index]),
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
    );
  }
}
