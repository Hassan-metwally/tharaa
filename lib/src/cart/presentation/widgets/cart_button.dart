import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/di/di.dart';
import '../../../home/presentation/widgets/home_app_bar_icon_button.dart';
import '../cart_page/cart_cubit.dart';
import '../utils/cart_items_count_subscription.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    this.iconColor, // Default icon color
  });
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<CartCubit>()..cartItemsCount(),
      child: BlocSelector<CartCubit, CartState, int>(
        selector: (state) {
          return state.cartItemsCountState.data ?? 0;
        },
        builder: (context, cartItemsCount) {
          return _CartButton(iconColor: iconColor, cartItemsCount: cartItemsCount);
        },
      ),
    );
  }
}

class _CartButton extends StatefulWidget {
  final int cartItemsCount;
  const _CartButton({required this.cartItemsCount, required this.iconColor});

  final Color? iconColor;

  @override
  State<_CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<_CartButton> {
  final _productsSubscriptionObj = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    _productsSubscriptionObj.add(
      CartItemsCountSubscription.stream().listen((params) {
        if (mounted) {
          context.read<CartCubit>().cartItemsCount();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeAppBarIconButton(
      iconColor: widget.iconColor,
      icon: "",
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.cartPage);
      },
      iconBadgeCount: widget.cartItemsCount,
    );
  }
}
