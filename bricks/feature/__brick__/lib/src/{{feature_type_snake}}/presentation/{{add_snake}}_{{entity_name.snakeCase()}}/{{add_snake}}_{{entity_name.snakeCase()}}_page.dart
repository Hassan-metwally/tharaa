import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../../../material/inputs/app_text_form_field.dart';
import '../../../../material/inputs/media_field.dart';
import '../../domain/usecases/{{add_snake}}_{{entity_name.snakeCase()}}_usecase.dart';
{{#with_any_get_presentation}}
import '../{{feature_type_snake}}/utils/{{active_get_snake}}_{{feature_name.snakeCase()}}_subscription.dart';
{{/with_any_get_presentation}}
import '{{add_snake}}_{{entity_name.snakeCase()}}_cubit.dart';

class {{add_pascal}}{{entity_name.pascalCase()}}Page extends StatelessWidget {
  const {{add_pascal}}{{entity_name.pascalCase()}}Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<{{add_pascal}}{{entity_name.pascalCase()}}Cubit>(),
      child: const _{{add_pascal}}{{entity_name.pascalCase()}}Body(),
    );
  }
}

class _{{add_pascal}}{{entity_name.pascalCase()}}Body extends StatefulWidget {
  const _{{add_pascal}}{{entity_name.pascalCase()}}Body();

  @override
  State<_{{add_pascal}}{{entity_name.pascalCase()}}Body> createState() => _{{add_pascal}}{{entity_name.pascalCase()}}BodyState();
}

class _{{add_pascal}}{{entity_name.pascalCase()}}BodyState extends State<_{{add_pascal}}{{entity_name.pascalCase()}}Body> {
  late final {{add_pascal}}{{entity_name.pascalCase()}}Cubit _{{entity_name.camelCase()}}Cubit;
  @override
  void initState() {
    super.initState();
    _{{entity_name.camelCase()}}Cubit = context.read<{{add_pascal}}{{entity_name.pascalCase()}}Cubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appLocalizer.add"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.black50, // border color
            height: 1.0,
          ),
        ),
      ),
      body: BlocSelector<{{add_pascal}}{{entity_name.pascalCase()}}Cubit, {{add_pascal}}{{entity_name.pascalCase()}}State, {{upsert_pascal}}{{entity_name.pascalCase()}}Params>(
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
                BlocConsumer<{{add_pascal}}{{entity_name.pascalCase()}}Cubit, {{add_pascal}}{{entity_name.pascalCase()}}State>(
                  listener: (context, state) {
                    if (state.{{add_camel}}{{entity_name.pascalCase()}}State.isSuccess) {
                      {{#with_any_get_presentation}}
                      {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription.pushUpdate(NoParams());
                      {{/with_any_get_presentation}}
                      AppRouter.pop();
                      AppToasts.success(
                        context,
                        message: "appLocalizer.AddedSuccessfully",
                      );
                    } else if (state.{{add_camel}}{{entity_name.pascalCase()}}State.isFailure) {
                      AppToasts.error(context, message: state.{{add_camel}}{{entity_name.pascalCase()}}State.errorMessage ?? '');
                    }
                  },
                  builder: (context, state) {
                    return SafeArea(
                      top: false,
                      child: AppButton(
                        isLoading: state.{{add_camel}}{{entity_name.pascalCase()}}State.isLoading,
                        text: "appLocalizer.add",
                        onPressed: () {
                          paramsState.formKey.currentState?.save();
                          if (paramsState.formKey.currentState?.validate() ?? false) {
                            _{{entity_name.camelCase()}}Cubit.{{add_camel}}{{entity_name.pascalCase()}}();
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

