import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/router/app_routes.dart';
import '../../../../../core/core.dart';
import '../../../../../core/di/di.dart';
import '../../../../../material/auth_states/guest_bottom_sheet.dart';
import '../../../../../material/auth_states/guest_checker_widget.dart';
import '../../../../../material/media/app_image.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../material/toast/app_toast.dart';
import '../../../../../material/widgets/riyal_price_text.dart';
import '../../../../cart/domain/usecases/upsert_cart_item_usecase.dart';
import '../../../../cart/presentation/upsert_cart_item/upsert_cart_item_cubit.dart';
import '../../../../cart/presentation/utils/cart_items_count_subscription.dart';
import '../../../domain/entities/product_entity.dart';
import '../../show_product_details/show_product_details_page.dart';

const double _kImageHeight = 120;
const double _kAddButtonSize = 38;
const double _kAddIconSize = 24;

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({super.key, required this.entity});

  final ProductEntity entity;

  String get _unitLabel => entity.unitLabel;

  bool get _hasOffer {
    final num? offerPrice = entity.offerPrice;
    return offerPrice != null && offerPrice != entity.price;
  }

  num get _displayPrice => entity.offerPrice ?? entity.price;

  Color get _cardFill => AppColors.productCardFill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.pushNamed(AppRoutes.showProductDetailsPage, arguments: ShowProductDetailsPage(id: entity.id));
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.p8),
        decoration: BoxDecoration(color: _cardFill, borderRadius: BorderRadius.circular(Dimensions.r24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: _kImageHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppImage.rounded(
                      path: entity.image.path,
                      height: _kImageHeight,
                      width: double.infinity,
                      radius: Dimensions.r16,
                      fit: BoxFit.cover,
                      bgColor: _cardFill,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.p8),
                      child: _ProductCartControl(productId: entity.id),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.p8),
            Text(
              entity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium16.copyWith(color: AppColors.black900, height: 1),
            ),
            SizedBox(height: Dimensions.p6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    entity.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1),
                  ),
                ),
                if (_unitLabel.isNotEmpty) Text(_unitLabel, style: TextStyles.regular12.copyWith(color: AppColors.mutedText, height: 1)),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RiyalPriceText(
                  price: _displayPrice.toString(),
                  priceTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                  currencyTextStyle: TextStyles.semiBold20.copyWith(color: AppColors.primary, height: 1),
                  textAlign: TextAlign.center,
                ),
                if (_hasOffer) ...[
                  const SizedBox(width: Dimensions.p12),
                  RiyalPriceText(
                    price: entity.price.toString(),
                    priceTextStyle: TextStyles.medium14.copyWith(
                      color: AppColors.oldPriceColor,
                      height: 1,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.oldPriceColor,
                    ),
                    currencyTextStyle: TextStyles.medium14.copyWith(
                      color: AppColors.oldPriceColor,
                      height: 1,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.oldPriceColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCartControl extends StatefulWidget {
  const _ProductCartControl({required this.productId});

  final int productId;

  @override
  State<_ProductCartControl> createState() => _ProductCartControlState();
}

class _ProductCartControlState extends State<_ProductCartControl> {
  int _quantity = 0;
  int _pendingQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertCartItemCubit>(),
      child: BlocConsumer<UpsertCartItemCubit, UpsertCartItemState>(
        listenWhen: (previous, current) => previous.upsertCartItemsState != current.upsertCartItemsState,
        listener: (context, state) {
          if (state.upsertCartItemsState.isFailure) {
            AppToasts.error(context, message: state.upsertCartItemsState.errorMessage ?? appLocalizer.somethingWentWrong);
          } else if (state.upsertCartItemsState.isSuccess) {
            final int previousQuantity = _quantity;
            setState(() => _quantity = _pendingQuantity);
            if (_pendingQuantity > previousQuantity) {
              AppToasts.success(context, message: appLocalizer.successfullyAddedToCart);
            }
            CartItemsCountSubscription.pushUpdate(NoParams());
          }
        },
        builder: (context, state) {
          final bool isLoading = state.upsertCartItemsState.isLoading;
          if (_quantity > 0) {
            return _QuantityStepper(
              quantity: _quantity,
              isLoading: isLoading,
              onIncrement: () => _submit(context, _quantity + 1, UpsertTypeEnum.add),
              onDecrement: () {
                if (_quantity <= 1) {
                  setState(() => _quantity = 0);
                  return;
                }
                _submit(context, _quantity - 1, UpsertTypeEnum.update);
              },
            );
          }
          return _AddButton(isLoading: isLoading, onTap: () => _submit(context, 1, UpsertTypeEnum.add));
        },
      ),
    );
  }

  void _submit(BuildContext context, int quantity, UpsertTypeEnum type) {
    _pendingQuantity = quantity;
    context.read<UpsertCartItemCubit>().updateParams(AddToCartParams(productId: widget.productId, quantity: quantity, upsertType: type));
    context.read<UpsertCartItemCubit>().upsertCartItem();
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isLoading ? null : GuestCheckerWidget.check(context, caseGuest: () => GuestBottomSheet.show(context), elseCase: onTap);
      },
      child: Container(
        width: _kAddButtonSize,
        height: _kAddButtonSize,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Dimensions.r16),
          border: Border.all(color: AppColors.white, width: 0.5),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SpinKitLoadingWidget.small(color: AppColors.white)
            : AppSvgIcon(path: AppIcons.add, width: _kAddIconSize, height: _kAddIconSize),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({required this.quantity, required this.isLoading, required this.onIncrement, required this.onDecrement});

  final int quantity;
  final bool isLoading;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kAddButtonSize,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: AppColors.productCardFill, borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperIconButton(icon: AppIcons.add, color: AppColors.black900, onTap: isLoading ? null : onIncrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.p8),
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyles.medium18.copyWith(color: AppColors.black900, height: 1),
            ),
          ),
          _StepperIconButton(icon: AppIcons.minus, color: AppColors.black900, onTap: isLoading ? null : onDecrement),
        ],
      ),
    );
  }
}

class _StepperIconButton extends StatelessWidget {
  const _StepperIconButton({required this.icon, required this.onTap, this.color});

  final String icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _kAddButtonSize,
        height: _kAddButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(Dimensions.r16)),
        child: AppSvgIcon(path: icon, width: _kAddIconSize, height: _kAddIconSize, color: color),
      ),
    );
  }
}
