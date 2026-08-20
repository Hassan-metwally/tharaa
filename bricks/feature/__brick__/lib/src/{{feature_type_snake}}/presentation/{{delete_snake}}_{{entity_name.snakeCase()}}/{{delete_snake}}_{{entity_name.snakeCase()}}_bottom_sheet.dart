import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../../../material/toast/app_toast.dart';
{{#with_any_get_presentation}}
import '../{{feature_type_snake}}/utils/{{active_get_snake}}_{{feature_name.snakeCase()}}_subscription.dart';
{{/with_any_get_presentation}}
import '{{delete_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{delete_pascal}}{{entity_name.pascalCase()}}BottomSheet extends StatelessWidget {
  final int id;
  final bool popToIndexPage;
  const {{delete_pascal}}{{entity_name.pascalCase()}}BottomSheet({super.key, required this.id, this.popToIndexPage = false});

  static Future<void> show(BuildContext context, {required int id, bool popToIndexPage = false}) async {
    await showAppModalBottomSheet(
      child: BlocProvider(
        create: (context) => injector<{{delete_pascal}}{{entity_name.pascalCase()}}Cubit>(),
        child: {{delete_pascal}}{{entity_name.pascalCase()}}BottomSheet(id: id, popToIndexPage: popToIndexPage),
      ),
      context: context,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<{{delete_pascal}}{{entity_name.pascalCase()}}Cubit, {{delete_pascal}}{{entity_name.pascalCase()}}State>(
      listener: (context, state) {
        if (state.{{delete_camel}}{{entity_name.pascalCase()}}State.isSuccess) {
          AppToasts.success(context, message: state.{{delete_camel}}{{entity_name.pascalCase()}}State.data!);
          {{#with_any_get_presentation}}
          {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription.pushUpdate(NoParams());
          {{/with_any_get_presentation}}
          AppRouter.pop();
          if (popToIndexPage) {
            AppRouter.pop();
          }
        } else if (state.{{delete_camel}}{{entity_name.pascalCase()}}State.isFailure) {
          AppToasts.error(context, message: state.{{delete_camel}}{{entity_name.pascalCase()}}State.errorMessage ?? appLocalizer.somethingWentWrong);
          AppRouter.pop();
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppSvgIcon(path: ""),
            const SizedBox(height: 8),
            Text("appLocalizer.areYouSureYouWantToDelete{{entity_name.pascalCase()}}", style: TextStyles.regular14),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    isLoading: state.{{delete_camel}}{{entity_name.pascalCase()}}State.isLoading,
                    text: "appLocalizer.delete{{entity_name.pascalCase()}}",
                    buttonColor: AppColors.primary,
                    onPressed: () => context.read<{{delete_pascal}}{{entity_name.pascalCase()}}Cubit>().{{delete_camel}}(id),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: appLocalizer.cancel,
                    buttonColor: AppColors.white,
                    textColor: AppColors.black800,
                    isEnabled: state.{{delete_camel}}{{entity_name.pascalCase()}}State.isLoading == false,
                    onPressed: () => AppRouter.pop(),
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

