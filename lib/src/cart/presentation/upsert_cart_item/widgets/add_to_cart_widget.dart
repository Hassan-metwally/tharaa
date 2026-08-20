import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../core/di/di.dart';
import '../../../../../material/media/svg_icon.dart';
import '../../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../material/toast/app_toast.dart';
import '../../../domain/usecases/upsert_cart_item_usecase.dart';
import '../../utils/cart_items_count_subscription.dart';
import '../upsert_cart_item_cubit.dart';

class AddToCartWidget extends StatelessWidget {
  final int productId;
  final int? cartQuantity;
  const AddToCartWidget({super.key, required this.productId, this.cartQuantity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UpsertCartItemCubit>(),
      child: BlocConsumer<UpsertCartItemCubit, UpsertCartItemState>(
        listenWhen: (previous, current) => previous.upsertCartItemsState != current.upsertCartItemsState,
        listener: (context, state) {
          if (state.upsertCartItemsState.isFailure) {
            showAppTopModalSheet(
              context: context,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSvgIcon(path: ""),
                    const SizedBox(height: 20),
                    Text(state.upsertCartItemsState.failure?.message ?? appLocalizer.somethingWentWrong, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          } else if (state.upsertCartItemsState.isSuccess) {
            AppToasts.success(context, message: appLocalizer.successfullyAddedToCart);
            CartItemsCountSubscription.pushUpdate(NoParams());
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<UpsertCartItemCubit>().updateParams(
                state.params.copyWith(productId: productId, upsertType: UpsertTypeEnum.add, quantity: cartQuantity ?? 1),
              );
              context.read<UpsertCartItemCubit>().upsertCartItem();
            },
            child: BlocBuilder<UpsertCartItemCubit, UpsertCartItemState>(
              builder: (context, state) {
                return Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(12), bottomStart: Radius.circular(20)),
                  ),
                  child: state.upsertCartItemsState.isLoading ? const SpinKitLoadingWidget.small() : AppSvgIcon(path: "", size: 20),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
