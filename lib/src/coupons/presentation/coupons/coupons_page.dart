import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_empty_widget.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/app_loading_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/widgets/riyal_price_text.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/usecases/get_coupons_usecase.dart';
import 'coupons_cubit.dart';
import 'utils/get_coupons_subscription.dart';

part 'widgets/coupon_card.dart';
part 'widgets/coupons_filter_bottomsheet.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<CouponsCubit>()..getCoupons(), child: const _CouponsBody());
  }
}

class _CouponsBody extends StatefulWidget {
  const _CouponsBody();

  @override
  State<_CouponsBody> createState() => _CouponsBodyState();
}

class _CouponsBodyState extends State<_CouponsBody> {
  final CompositeSubscription _couponsSubscription = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  late final CouponsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CouponsCubit>();
    _couponsSubscription.add(
      GetCouponsSubscription.stream().listen((_) {
        _cubit.getCoupons();
      }),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.getMoreCoupons();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _couponsSubscription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text(appLocalizer.discountCoupons)),
      body: BlocBuilder<CouponsCubit, CouponsState>(
        builder: (context, state) {
          if (state.getCouponsState.isLoading) {
            return const Center(child: AppLoadingWidget());
          }
          if (state.getCouponsState.isFailure) {
            return AppFailWidget(onRetry: _cubit.getCoupons);
          }
          if (state.getCouponsState.isSuccess) {
            final List<CouponEntity> data = state.getCouponsState.data ?? [];
            return LiquidPullToRefresh(
              color: AppColors.backgroundColor,
              backgroundColor: AppColors.primary,
              onRefresh: _cubit.getCoupons,
              child: data.isEmpty
                  ? AppEmptyWidget(
                      // heightPercentage: 0.48,
                      text: appLocalizer.noCouponsFound,
                      subText: appLocalizer.noCouponsFoundSub,
                      imagePath: AppImages.emptyCart,
                      imageFit: BoxFit.contain,
                      imageSize: 200 / 0.7,
                      spacing: Dimensions.p32 / 0.7,
                      subTextSpacing: Dimensions.p16,
                      textStyle: TextStyles.semiBold22.copyWith(color: AppColors.black),
                      subTextStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText),
                    )
                  : Stack(
                      children: [
                        ListView.separated(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p16, Dimensions.p16, Dimensions.p24),
                          itemCount: data.length,
                          separatorBuilder: (_, _) => const SizedBox(height: Dimensions.p16),
                          itemBuilder: (context, index) => _CouponCard(entity: data[index], index: index),
                        ),
                        if (state.getCouponsState.isPaginationLoading)
                          const Positioned(
                            bottom: -10,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: AppLoadingWidget()),
                            ),
                          ),
                      ],
                    ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
