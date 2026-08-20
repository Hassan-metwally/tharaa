import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
{{#with_delete}}
import '../{{delete_snake}}_{{entity_name.snakeCase()}}/{{delete_snake}}_{{entity_name.snakeCase()}}_bottom_sheet.dart';
{{/with_delete}}
{{#with_upsert}}
import '../{{upsert_snake}}_{{entity_name.snakeCase()}}/{{upsert_snake}}_{{entity_name.snakeCase()}}_page.dart';
{{/with_upsert}}
{{^with_upsert}}
{{#with_update}}
import '../{{update_snake}}_{{entity_name.snakeCase()}}/{{update_snake}}_{{entity_name.snakeCase()}}_page.dart';
{{/with_update}}
{{/with_upsert}}
import '{{show_snake}}_{{entity_name.snakeCase()}}_details_cubit.dart';
import 'utils/{{show_snake}}_{{entity_name.snakeCase()}}_details_subscription.dart';

class {{show_pascal}}{{entity_name.pascalCase()}}DetailsPage extends StatelessWidget {
  final int id;
  const {{show_pascal}}{{entity_name.pascalCase()}}DetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<{{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit>()..{{show_camel}}{{entity_name.pascalCase()}}Details(id),
      child: _{{show_pascal}}{{entity_name.pascalCase()}}DetailsBody(id: id),
    );
  }
}

class _{{show_pascal}}{{entity_name.pascalCase()}}DetailsBody extends StatefulWidget {
  final int id;
  const _{{show_pascal}}{{entity_name.pascalCase()}}DetailsBody({required this.id});

  @override
  State<_{{show_pascal}}{{entity_name.pascalCase()}}DetailsBody> createState() => _{{show_pascal}}{{entity_name.pascalCase()}}DetailsBodyState();
}

class _{{show_pascal}}{{entity_name.pascalCase()}}DetailsBodyState extends State<_{{show_pascal}}{{entity_name.pascalCase()}}DetailsBody> {
  final _{{entity_name.camelCase()}}SubscriptionObj = CompositeSubscription();
  late final {{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit _{{entity_name.camelCase()}}Cubit;

  void _{{entity_name.camelCase()}}SubsriptionListener() {
    _{{entity_name.camelCase()}}SubscriptionObj.add(
      {{show_pascal}}{{entity_name.pascalCase()}}DetailSubscription.stream().listen((params) {
        _{{entity_name.camelCase()}}Cubit.{{show_camel}}{{entity_name.pascalCase()}}Details(widget.id);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _{{entity_name.camelCase()}}Cubit = context.read<{{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit>();
    _{{entity_name.camelCase()}}SubsriptionListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appLocalizer.{{entity_name.pascalCase()}}Details"),
      ),
      body: BlocBuilder<{{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit, {{show_pascal}}{{entity_name.pascalCase()}}DetailsState>(
        builder: (context, state) {
          if (state.{{show_camel}}{{entity_name.pascalCase()}}State.isLoading) {
            return const Center(child: SpinKitLoadingWidget());
          }
          if (state.{{show_camel}}{{entity_name.pascalCase()}}State.isFailure) {
            return AppFailWidget(onRetry: () => context.read<{{show_pascal}}{{entity_name.pascalCase()}}DetailsCubit>().{{show_camel}}{{entity_name.pascalCase()}}Details(widget.id));
          }
          if (state.{{show_camel}}{{entity_name.pascalCase()}}State.isSuccess) {
            final {{entity_name.camelCase()}} = state.{{show_camel}}{{entity_name.pascalCase()}}State.data!;

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
                    child: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [BoxShadow(color: AppColors.black500.withAlpha(10), offset: const Offset(.6, 0), blurRadius: 4)],
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      {{#with_upsert}}
                      Expanded(
                        child: AppButton(
                          text: "appLocalizer.edit",
                          onPressed: () {
                            AppRouter.pushNamed(
                              '',
                              arguments: {{upsert_pascal}}{{entity_name.pascalCase()}}Page({{entity_name.camelCase()}}Entity: {{entity_name.camelCase()}}),
                            );
                          },
                        ),
                      ),
                      {{/with_upsert}}
                      {{^with_upsert}}
                      {{#with_update}}
                      Expanded(
                        child: AppButton(
                          text: "appLocalizer.edit",
                          onPressed: () {
                            AppRouter.pushNamed(
                              '',
                              arguments: {{update_pascal}}{{entity_name.pascalCase()}}Page({{entity_name.camelCase()}}Entity: {{entity_name.camelCase()}}),
                            );
                          },
                        ),
                      ),
                      {{/with_update}}
                      {{/with_upsert}}
                      {{#with_delete}}
                      {{#with_upsert}}
                      const SizedBox(width: 10),
                      {{/with_upsert}}
                      {{^with_upsert}}
                      {{#with_update}}
                      const SizedBox(width: 10),
                      {{/with_update}}
                      {{/with_upsert}}
                      Expanded(
                        child: AppButton(
                          text: "appLocalizer.delete",
                          buttonColor: AppColors.primary50,
                          textStyle: TextStyles.medium16.copyWith(color: AppColors.primary),
                          onPressed: () {
                            {{delete_pascal}}{{entity_name.pascalCase()}}BottomSheet.show(context, id: {{entity_name.camelCase()}}.id, popToIndexPage: true);
                          },
                        ),
                      ),
                      {{/with_delete}}
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}


