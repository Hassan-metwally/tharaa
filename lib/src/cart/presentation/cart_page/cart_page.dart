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

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<CartCubit>()..getCart(), child: _CartPage());
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
        title: Text(appLocalizer.cart, style: TextStyles.bold16.copyWith(color: AppColors.black)),
        centerTitle: true,
        shadowColor: AppColors.black50,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.getCartState.isLoading) {
            return const Center(child: SpinKitLoadingWidget());
          } else if (state.getCartState.isFailure) {
            return AppFailWidget(onRetry: () => context.read<CartCubit>().getCart());
          } else if (state.getCartState.isSuccess) {
            final cart = state.getCartState.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: LiquidPullToRefresh(
                onRefresh: () => context.read<CartCubit>().getCart(),
                color: AppColors.backgroundColor,
                backgroundColor: AppColors.primary,
                child: cart.items.isEmpty
                    ? AppEmptyWidget(
                        text: appLocalizer.noItemsInCartCurrently,
                        subText: appLocalizer.pleaseComeBackLater,
                        imagePath: AppImages.emptyCart,
                      )
                    : _CartPageBody(cart: cart),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
