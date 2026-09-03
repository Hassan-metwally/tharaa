import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/config/router/app_routes.dart';
import '../../../../../core/core.dart';
import '../../../../../core/di/di.dart';
import '../../../../../material/auth_states/guest_checker_widget.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../cart/presentation/cart_page/cart_cubit.dart';
import '../../../../cart/presentation/utils/cart_items_count_subscription.dart';

const Color _kActionFill = Color(0xFFF7F8FA);
const double _kActionSize = 48;
const double _kBadgeSize = 18;

class ProductsAppBar extends StatelessWidget {
  const ProductsAppBar({super.key, required this.title, required this.showBack});

  final String title;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p8, Dimensions.p16, Dimensions.p24),
          child: SizedBox(
            height: _kActionSize,
            child: Row(
              children: [
                if (showBack)
                  _CircleActionButton(
                    onTap: () => AppRouter.pop(),
                    child: Transform.flip(
                      flipX: isRtl,
                      child: AppSvgIcon(path: AppIcons.arrowBack, width: Dimensions.ic24, height: Dimensions.ic24),
                    ),
                  )
                else
                  const SizedBox(width: _kActionSize),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold20.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
                  ),
                ),
                const GuestCheckerWidget(
                  guestWidget: SizedBox(width: _kActionSize),
                  child: _ProductsCartButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _kActionSize,
        height: _kActionSize,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: _kActionFill, shape: BoxShape.circle),
        child: child,
      ),
    );
  }
}

class _ProductsCartButton extends StatelessWidget {
  const _ProductsCartButton();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<CartCubit>()..cartItemsCount(),
      child: BlocSelector<CartCubit, CartState, int>(
        selector: (state) => state.cartItemsCountState.data ?? 0,
        builder: (context, cartItemsCount) {
          return _ProductsCartButtonBody(cartItemsCount: cartItemsCount);
        },
      ),
    );
  }
}

class _ProductsCartButtonBody extends StatefulWidget {
  const _ProductsCartButtonBody({required this.cartItemsCount});

  final int cartItemsCount;

  @override
  State<_ProductsCartButtonBody> createState() => _ProductsCartButtonBodyState();
}

class _ProductsCartButtonBodyState extends State<_ProductsCartButtonBody> {
  final CompositeSubscription _subscription = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    _subscription.add(
      CartItemsCountSubscription.stream().listen((_) {
        if (mounted) {
          context.read<CartCubit>().cartItemsCount();
        }
      }),
    );
  }

  @override
  void dispose() {
    _subscription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.cartPage),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _kActionSize,
        height: _kActionSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: _kActionFill, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.p10),
                  child: AppSvgIcon(path: AppIcons.bag2, width: Dimensions.ic24, height: Dimensions.ic24),
                ),
              ),
            ),
            if (widget.cartItemsCount > 0)
              PositionedDirectional(
                top: 3,
                start: 0,
                child: Container(
                  width: _kBadgeSize,
                  height: _kBadgeSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.red500, borderRadius: BorderRadius.circular(Dimensions.r8)),
                  child: FittedBox(
                    child: Text(
                      widget.cartItemsCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyles.semiBold12.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
