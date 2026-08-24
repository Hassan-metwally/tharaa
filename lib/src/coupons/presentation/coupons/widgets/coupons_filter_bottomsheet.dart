part of '../coupons_page.dart';

class _CouponsFilterBottomSheet extends StatefulWidget {
  const _CouponsFilterBottomSheet();

  static Future<void> show({required BuildContext context, required CouponsCubit couponsCubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: couponsCubit, child: const _CouponsFilterBottomSheet()),
    );
  }

  @override
  State<_CouponsFilterBottomSheet> createState() => _CouponsFilterBottomSheetState();
}

class _CouponsFilterBottomSheetState extends State<_CouponsFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CouponsCubit, CouponsState, GetCouponsParams>(
      selector: (state) {
        return state.params;
      },
      builder: (context, paramsState) {
        return Column(
          children: [
            SizedBox(height: 20),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BlocListener<CouponsCubit, CouponsState>(
                    listenWhen: (previous, current) => previous.getCouponsState != current.getCouponsState,
                    listener: (context, state) {
                      if (state.getCouponsState.isFailure) {
                        AppToasts.error(context, message: state.getCouponsState.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<CouponsCubit, CouponsState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<CouponsCubit>();
                            cubit.updateParams(paramsState);
                            cubit.getCoupons();
                            AppRouter.pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: appLocalizer.cancel,
                    onPressed: () {
                      final cubit = context.read<CouponsCubit>();
                      cubit.resetParams();
                      cubit.getCoupons();
                      AppRouter.pop();
                    },
                    buttonColor: AppColors.primary50,
                    textStyle: TextStyles.medium16.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
