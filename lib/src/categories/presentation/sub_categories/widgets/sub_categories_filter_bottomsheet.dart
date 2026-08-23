part of '../sub_categories_page.dart';

class _SubCategoriesFilterBottomSheet extends StatefulWidget {
  const _SubCategoriesFilterBottomSheet();

  static Future<void> show({required BuildContext context, required SubCategoriesCubit subCategoriesCubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: subCategoriesCubit, child: const _SubCategoriesFilterBottomSheet()),
    );
  }

  @override
  State<_SubCategoriesFilterBottomSheet> createState() => _SubCategoriesFilterBottomSheetState();
}

class _SubCategoriesFilterBottomSheetState extends State<_SubCategoriesFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<SubCategoriesCubit, SubCategoriesState, GetSubCategoriesParams>(
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
                  child: BlocListener<SubCategoriesCubit, SubCategoriesState>(
                    listenWhen: (previous, current) => previous.getSubCategoriesState != current.getSubCategoriesState,
                    listener: (context, state) {
                      if (state.getSubCategoriesState.isFailure) {
                        AppToasts.error(context, message: state.getSubCategoriesState.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<SubCategoriesCubit>();
                            cubit.updateParams(paramsState);
                            cubit.getSubCategories();
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
                      final cubit = context.read<SubCategoriesCubit>();
                      cubit.resetParams();
                      cubit.getSubCategories();
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
