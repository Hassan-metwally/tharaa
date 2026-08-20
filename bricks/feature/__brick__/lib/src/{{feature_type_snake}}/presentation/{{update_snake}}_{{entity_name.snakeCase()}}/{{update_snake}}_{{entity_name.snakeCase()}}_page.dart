import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/inputs/media_field.dart';
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{#with_any_get_presentation}}
import '../{{feature_type_snake}}/utils/{{active_get_snake}}_{{feature_name.snakeCase()}}_subscription.dart';
{{/with_any_get_presentation}}
{{#with_show}}
import '../{{show_snake}}_{{entity_name.snakeCase()}}_details/utils/{{show_snake}}_{{entity_name.snakeCase()}}_details_subscription.dart';
{{/with_show}}
import '{{update_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{update_pascal}}{{entity_name.pascalCase()}}Page extends StatelessWidget {
  final {{entity_type_pascal}}Entity? {{entity_name.camelCase()}}Entity;
  const {{update_pascal}}{{entity_name.pascalCase()}}Page({super.key, this.{{entity_name.camelCase()}}Entity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<{{update_pascal}}{{entity_name.pascalCase()}}Cubit>()..setInitialParams({{entity_name.camelCase()}}Entity),
      child: _{{update_pascal}}{{entity_name.pascalCase()}}Body({{entity_name.camelCase()}}Entity: {{entity_name.camelCase()}}Entity),
    );
  }
}

class _{{update_pascal}}{{entity_name.pascalCase()}}Body extends StatefulWidget {
  final {{entity_type_pascal}}Entity? {{entity_name.camelCase()}}Entity;
  const _{{update_pascal}}{{entity_name.pascalCase()}}Body({this.{{entity_name.camelCase()}}Entity});

  @override
  State<_{{update_pascal}}{{entity_name.pascalCase()}}Body> createState() => _{{update_pascal}}{{entity_name.pascalCase()}}BodyState();
}

class _{{update_pascal}}{{entity_name.pascalCase()}}BodyState extends State<_{{update_pascal}}{{entity_name.pascalCase()}}Body> {
  late final {{update_pascal}}{{entity_name.pascalCase()}}Cubit _{{entity_name.camelCase()}}Cubit;
  @override
  void initState() {
    super.initState();
    _{{entity_name.camelCase()}}Cubit = context.read<{{update_pascal}}{{entity_name.pascalCase()}}Cubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appLocalizer.update'),
      ),
      body: BlocSelector<{{update_pascal}}{{entity_name.pascalCase()}}Cubit, {{update_pascal}}{{entity_name.pascalCase()}}State, {{upsert_pascal}}{{entity_name.pascalCase()}}Params>(
        selector: (state) {
          return state.params;
        },
        builder: (context, paramsState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: paramsState.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("", style: TextStyles.regular14),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: paramsState.name,
                            label: "appLocalizer.name",
                            // hint: appLocalizer.enterName,
                          ),
                          const SizedBox(height: 30),
                          MediaFieldWidget(
                            controller: paramsState.imageController,
                            label: "appLocalizer.image",
                            hint: "appLocalizer.enterImage",
                            validationMessage: "appLocalizer.attachImage",
                            // hasRequiredSymbol: true,
                            // canPickPdf: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<{{update_pascal}}{{entity_name.pascalCase()}}Cubit, {{update_pascal}}{{entity_name.pascalCase()}}State>(
                  listener: (context, state) {
                    if (state.{{update_camel}}{{entity_name.pascalCase()}}State.isSuccess) {
                      {{#with_any_get_presentation}}
                      {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription.pushUpdate(NoParams());
                      {{/with_any_get_presentation}}
                      AppRouter.pop();
                      {{#with_show}}
                      {{show_pascal}}{{entity_name.pascalCase()}}DetailSubscription.pushUpdate(NoParams());
                      {{/with_show}}
                      AppToasts.success(
                        context,
                        message: "appLocalizer.UpdatedSuccessfully",
                      );
                    } else if (state.{{update_camel}}{{entity_name.pascalCase()}}State.isFailure) {
                      AppToasts.error(context, message: state.{{update_camel}}{{entity_name.pascalCase()}}State.errorMessage ?? '');
                    }
                  },
                  builder: (context, state) {
                    return SafeArea(
                      top: false,
                      child: AppButton(
                        isLoading: state.{{update_camel}}{{entity_name.pascalCase()}}State.isLoading,
                        text: "appLocalizer.update",
                        onPressed: () {
                          paramsState.formKey.currentState?.save();
                          if (paramsState.formKey.currentState?.validate() ?? false) {
                            // final params = paramsState.copyWith(
                            // );
                            // _{{entity_name.camelCase()}}Cubit.updateParams(params);
                            _{{entity_name.camelCase()}}Cubit.{{update_camel}}{{entity_name.pascalCase()}}();
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


