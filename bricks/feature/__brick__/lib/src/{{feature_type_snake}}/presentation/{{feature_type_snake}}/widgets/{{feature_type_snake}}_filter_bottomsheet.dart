part of '../{{feature_type_snake}}_page.dart';

class _{{feature_type_pascal}}FilterBottomSheet extends StatefulWidget {
  const _{{feature_type_pascal}}FilterBottomSheet();

  static Future<void> show({required BuildContext context, required {{feature_type_pascal}}Cubit {{feature_type_pascal.camelCase()}}Cubit}) async {
    await showAppModalBottomSheet<void>(
      context: context,
      hasTopInductor: false,
      child: BlocProvider.value(value: {{feature_type_pascal.camelCase()}}Cubit, child: const _{{feature_type_pascal}}FilterBottomSheet()),
    );
  }

  @override
  State<_{{feature_type_pascal}}FilterBottomSheet> createState() => _{{feature_type_pascal}}FilterBottomSheetState();
}

class _{{feature_type_pascal}}FilterBottomSheetState extends State<_{{feature_type_pascal}}FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<{{feature_type_pascal}}Cubit,{{feature_type_pascal}}State , {{get_pascal}}{{feature_name.pascalCase()}}Params>(
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
                  child: BlocListener<{{feature_type_pascal}}Cubit, {{feature_type_pascal}}State>(
                    listenWhen: (previous, current) => previous.{{get_camel}}{{feature_name.pascalCase()}}State != current.{{get_camel}}{{feature_name.pascalCase()}}State,
                    listener: (context, state) {
                      if (state.{{get_camel}}{{feature_name.pascalCase()}}State.isFailure) {
                        AppToasts.error(context, message: state.{{get_camel}}{{feature_name.pascalCase()}}State.failure?.message ?? appLocalizer.somethingWentWrong);
                      }
                    },
                    child: BlocBuilder<{{feature_type_pascal}}Cubit, {{feature_type_pascal}}State>(
                      builder: (context, state) {
                        return AppButton(
                          text: "appLocalizer.filtering",
                          buttonColor: AppColors.primary,
                          onPressed: () {
                            final cubit = context.read<{{feature_type_pascal}}Cubit>();
                            cubit.updateParams(paramsState);
                            cubit.{{get_camel}}{{feature_name.pascalCase()}}();
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
                      final cubit = context.read<{{feature_type_pascal}}Cubit>();
                      cubit.resetParams();
                      cubit.{{get_camel}}{{feature_name.pascalCase()}}();
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

