import 'dart:async';

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
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/widgets/riyal_price_text.dart';
import '../../../main_page/models/client_main_page_tabs_enum.dart';
import '../../../main_page/observer/client_main_page_observer.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/upsert_cart_item_usecase.dart';
import '../delete_cart_item/delete_cart_item_cubit.dart';
import '../upsert_cart_item/upsert_cart_item_cubit.dart';
import '../upsert_cart_item/widgets/update_quantity_widget.dart';
import '../utils/cart_items_count_subscription.dart';
import '../utils/cart_subscription.dart';
import 'cart_cubit.dart';

part 'widgets/cart_item_widget.dart';
part 'widgets/cart_page_body.dart';
part 'widgets/cart_payment_summary.dart';

const double _kCartActionSize = 48;
const double _kCartItemHeight = 112;
const double _kCartItemImageWidth = 104;
const double _kCartBottomNavClearance = 96;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<CartCubit>()..getCart(), child: const _CartPage());
  }
}

class _CartPage extends StatefulWidget {
  const _CartPage();

  @override
  State<_CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<_CartPage> {
  final _cartSubscriptionObj = CompositeSubscription();
  late final CartCubit _cubit;

  void _cartSubsriptionListener() {
    _cartSubscriptionObj.add(
      CartSubscription.stream().listen((params) {
        _cubit.getCart();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CartCubit>();
    _cartSubsriptionListener();
  }

  @override
  void dispose() {
    _cartSubscriptionObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizer.cart),
      ),
      backgroundColor: AppColors.white,
      body: BlocBuilder<CartCubit, CartState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.getCartState.isLoading) {
            return const Center(child: SpinKitLoadingWidget());
          } else if (state.getCartState.isFailure) {
            return AppFailWidget(onRetry: () => context.read<CartCubit>().getCart());
          } else if (state.getCartState.isSuccess) {
            final cart = state.getCartState.data!;
            return LiquidPullToRefresh(
              onRefresh: () => context.read<CartCubit>().getCart(),
              color: AppColors.backgroundColor,
              backgroundColor: AppColors.primary,
              child: cart.items.isEmpty
                  ? AppEmptyWidget(
                    heightPercentage: 0.5,
                      text: appLocalizer.emptyCartTitle,
                      subText: appLocalizer.emptyCartSubtitle,
                      imagePath: AppImages.emptyCart,
                      imageFit: BoxFit.contain,
                      imageSize: 200 / 0.5,
                      spacing: Dimensions.p32 / 0.5,
                      subTextSpacing: Dimensions.p16,
                      textStyle: TextStyles.semiBold22.copyWith(color: AppColors.black, height: 1, fontWeight: FontWeight.w600),
                      subTextStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText, height: 1.4),
                    )
                  : _CartPageBody(cart: cart),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
