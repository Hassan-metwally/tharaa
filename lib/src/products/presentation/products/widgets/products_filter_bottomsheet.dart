part of '../products_page.dart';

class _ProductsFilterBottomSheet extends StatefulWidget {
  const _ProductsFilterBottomSheet();

  static Future<void> show({required BuildContext context, required ProductsCubit productsCubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: productsCubit, child: const _ProductsFilterBottomSheet()),
    );
  }

  @override
  State<_ProductsFilterBottomSheet> createState() => _ProductsFilterBottomSheetState();
}

class _ProductsFilterBottomSheetState extends State<_ProductsFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductsCubit, ProductsState, GetProductsParams>(
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
                  child: BlocListener<ProductsCubit, ProductsState>(
                    listenWhen: (previous, current) => previous.getProductsState != current.getProductsState,
                    listener: (context, state) {
                      if (state.getProductsState.isFailure) {
                        AppToasts.error(context, message: state.getProductsState.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<ProductsCubit>();
                            cubit.updateParams(paramsState);
                            cubit.getProducts();
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
                      final cubit = context.read<ProductsCubit>();
                      cubit.resetParams();
                      cubit.getProducts();
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
