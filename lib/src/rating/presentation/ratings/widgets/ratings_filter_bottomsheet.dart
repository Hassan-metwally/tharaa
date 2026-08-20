part of '../ratings_page.dart';

class _RatingsFilterBottomSheet extends StatefulWidget {
  const _RatingsFilterBottomSheet();

  static Future<void> show({required BuildContext context, required RatingsCubit ratingCubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: ratingCubit, child: const _RatingsFilterBottomSheet()),
    );
  }

  @override
  State<_RatingsFilterBottomSheet> createState() => _RatingsFilterBottomSheetState();
}

class _RatingsFilterBottomSheetState extends State<_RatingsFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RatingsCubit, RatingsState, GetRatingsParams>(
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
                  child: BlocListener<RatingsCubit, RatingsState>(
                    listenWhen: (previous, current) => previous.getRatingState != current.getRatingState,
                    listener: (context, state) {
                      if (state.getRatingState.isFailure) {
                        AppToasts.error(context, message: state.getRatingState.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<RatingsCubit, RatingsState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<RatingsCubit>();
                            cubit.updateParams(paramsState);
                            cubit.getRating();
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
                      final cubit = context.read<RatingsCubit>();
                      cubit.resetParams();
                      cubit.getRating();
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
