import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/widgets/riyal_price_text.dart';
import '../../../cart/domain/usecases/upsert_cart_item_usecase.dart';
import '../../../cart/presentation/upsert_cart_item/upsert_cart_item_cubit.dart';
import '../../../cart/presentation/utils/cart_items_count_subscription.dart';
import '../../domain/entities/product_details_entity.dart';
import 'show_product_details_cubit.dart';
import 'utils/show_product_details_subscription.dart';

part 'widgets/product_details_bottom_bar.dart';
part 'widgets/product_details_header.dart';
part 'widgets/product_details_image.dart';
part 'widgets/product_details_info.dart';

const double _kHeaderTopPadding = 20;
const double _kHeaderBottomPadding = 24;
const double _kBackButtonSize = 48;
const double _kBackIconSize = 24;
const double _kImageHeight = 246;
const double _kOfferTimerIconSize = 14;
const double _kAddToCartButtonHeight = 50;
const double _kQuantitySelectorWidth = 152;
const double _kQuantitySelectorRadius = 18;
const double _kQuantityButtonSize = 48;
const double _kQuantityIconSize = 24;

class ShowProductDetailsPage extends StatelessWidget {
  final int id;
  const ShowProductDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ShowProductDetailsCubit>()..showProductDetails(id),
      child: _ShowProductDetailsBody(id: id),
    );
  }
}

class _ShowProductDetailsBody extends StatefulWidget {
  final int id;
  const _ShowProductDetailsBody({required this.id});

  @override
  State<_ShowProductDetailsBody> createState() => _ShowProductDetailsBodyState();
}

class _ShowProductDetailsBodyState extends State<_ShowProductDetailsBody> {
  final _productSubscriptionObj = CompositeSubscription();
  late final ShowProductDetailsCubit _productCubit;

  void _productSubsriptionListener() {
    _productSubscriptionObj.add(
      ShowProductDetailSubscription.stream().listen((params) {
        _productCubit.showProductDetails(widget.id);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _productCubit = context.read<ShowProductDetailsCubit>();
    _productSubsriptionListener();
  }

  @override
  void dispose() {
    _productSubscriptionObj.dispose();
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
            const _ProductDetailsHeader(),
            Expanded(
              child: BlocBuilder<ShowProductDetailsCubit, ShowProductDetailsState>(
                builder: (context, state) {
                  if (state.showProductState.isLoading) {
                    return const Center(child: SpinKitLoadingWidget());
                  }
                  if (state.showProductState.isFailure) {
                    return AppFailWidget(onRetry: () => context.read<ShowProductDetailsCubit>().showProductDetails(widget.id));
                  }
                  if (state.showProductState.isSuccess) {
                    final product = state.showProductState.data!;
                    return _ProductDetailsContent(product: product);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent({required this.product});

  final ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProductDetailsImage(product: product),
                const SizedBox(height: Dimensions.p16),
                _ProductDetailsInfo(product: product),
              ],
            ),
          ),
        ),
        _ProductDetailsBottomBar(productId: product.id),
      ],
    );
  }
}
