part of '../main_categories_page.dart';

class _MainCategoriesFilterBottomSheet extends StatefulWidget {
  const _MainCategoriesFilterBottomSheet();

  // ignore: unused_element
  static Future<void> show({required BuildContext context, required MainCategoriesCubit mainCategoriesCubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: mainCategoriesCubit, child: const _MainCategoriesFilterBottomSheet()),
    );
  }

  @override
  State<_MainCategoriesFilterBottomSheet> createState() => _MainCategoriesFilterBottomSheetState();
}

class _MainCategoriesFilterBottomSheetState extends State<_MainCategoriesFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainCategoriesCubit, MainCategoriesState, GetMainCategoriesParams>(
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
                  child: BlocListener<MainCategoriesCubit, MainCategoriesState>(
                    listenWhen: (previous, current) => previous.getMainCategoriesState != current.getMainCategoriesState,
                    listener: (context, state) {
                      if (state.getMainCategoriesState.isFailure) {
                        AppToasts.error(context, message: state.getMainCategoriesState.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<MainCategoriesCubit, MainCategoriesState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<MainCategoriesCubit>();
                            cubit.updateParams(paramsState);
                            cubit.getMainCategories();
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
                      final cubit = context.read<MainCategoriesCubit>();
                      cubit.resetParams();
                      cubit.getMainCategories();
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
