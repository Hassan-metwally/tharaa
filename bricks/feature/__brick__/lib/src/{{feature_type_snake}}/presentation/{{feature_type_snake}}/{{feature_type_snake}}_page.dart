import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../../material/app_empty_widget.dart';
import '../../../../material/media/app_image.dart';
{{#active_get_is_paginated}}
import '../../../../material/buttons/app_button.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
{{/active_get_is_paginated}}
import '../../domain/entities/{{entity_type_snake}}_entity.dart';
{{#active_get_is_paginated}}
import '../../domain/usecases/{{get_snake}}_{{feature_name.snakeCase()}}_usecase.dart';
{{/active_get_is_paginated}}
import '{{feature_type_snake}}_cubit.dart';
import 'utils/{{active_get_snake}}_{{feature_name.snakeCase()}}_subscription.dart';

part 'widgets/{{entity_name.snakeCase()}}_card.dart';
{{#active_get_is_paginated}}
part 'widgets/{{feature_type_snake}}_filter_bottomsheet.dart';
{{/active_get_is_paginated}}

class {{feature_type_pascal}}Page extends StatelessWidget {
  const {{feature_type_pascal}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<{{feature_type_pascal}}Cubit>()..{{active_get_camel}}{{feature_name.pascalCase()}}(), child: const _{{feature_type_pascal}}Body());
  }
}

class _{{feature_type_pascal}}Body extends StatefulWidget {
  const _{{feature_type_pascal}}Body();

  @override
  State<_{{feature_type_pascal}}Body> createState() => _{{feature_type_pascal}}BodyState();
}

class _{{feature_type_pascal}}BodyState extends State<_{{feature_type_pascal}}Body> {
  final _{{feature_type_pascal.camelCase()}}SubscriptionObj = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  late final {{feature_type_pascal}}Cubit _cubit;

  void _{{feature_type_pascal.camelCase()}}SubsriptionListener() {
    _{{feature_type_pascal.camelCase()}}SubscriptionObj.add(
      {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription.stream().listen((params) {
        _cubit.{{active_get_camel}}{{feature_name.pascalCase()}}();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<{{feature_type_pascal}}Cubit>();
    _{{feature_type_pascal.camelCase()}}SubsriptionListener();
    {{#active_get_is_paginated}}
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.{{get_camel}}More{{feature_name.pascalCase()}}();
        }
      }
    });
    {{/active_get_is_paginated}}
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _{{feature_type_pascal.camelCase()}}SubscriptionObj.dispose();
    super.dispose();
  }

  Widget child = const SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appLocalizer._"),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // AppRouter.pushNamed('', arguments: const {{upsert_pascal}}{{entity_name.pascalCase()}}Page());
            },
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 20),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                children: [
                  const AppSvgIcon(path: 'AppIcons.addCircle'),
                  const SizedBox(width: 2),
                  Text("appLocalizer.add_", style: TextStyles.regular12.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.black50, // border color
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<{{feature_type_pascal}}Cubit, {{feature_type_pascal}}State>(
          builder: (context, state) {
            if (state.{{active_get_camel}}{{feature_name.pascalCase()}}State.isLoading) {
              child = const SpinKitLoadingWidget();
            } else if (state.{{active_get_camel}}{{feature_name.pascalCase()}}State.isFailure) {
              child = AppFailWidget(onRetry: () => context.read<{{feature_type_pascal}}Cubit>().{{active_get_camel}}{{feature_name.pascalCase()}}());
            } else if (state.{{active_get_camel}}{{feature_name.pascalCase()}}State.isSuccess) {
              final List<{{entity_type_pascal}}Entity> data = state.{{active_get_camel}}{{feature_name.pascalCase()}}State.data!;
              child = LiquidPullToRefresh(
                color: AppColors.backgroundColor,
                backgroundColor: AppColors.primary,
                onRefresh: () {
                  return context.read<{{feature_type_pascal}}Cubit>().{{active_get_camel}}{{feature_name.pascalCase()}}();
                },
                child: data.isEmpty
                      ? const AppEmptyWidget()
                      : Stack(
                        children:[
                          ListView.separated(
                            {{#active_get_is_paginated}}
                            controller: _scrollController,
                            {{/active_get_is_paginated}}
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _{{entity_name.pascalCase()}}Card(entity: data[index]),
                            itemCount: data.length,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => const SizedBox(height: 8),
                          ),
                          {{#active_get_is_paginated}}
                          if (state.{{active_get_camel}}{{feature_name.pascalCase()}}State.isPaginationLoading)
                            const Positioned(
                              bottom: -10,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: SpinKitLoadingWidget()),
                              ),
                            ),
                          {{/active_get_is_paginated}}  
                        ],
                      ),
              );
            }
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("appLocalizer.", style: TextStyles.medium16)),
                    {{#active_get_is_paginated}}
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _{{feature_type_pascal}}FilterBottomSheet.show(
                        context: context,
                        {{feature_type_pascal.camelCase()}}Cubit: context.read<{{feature_type_pascal}}Cubit>(),
                      ),
                      child: AppSvgIcon(path: "AppIcons.documentFilter"),
                    ),
                    {{/active_get_is_paginated}}
                  ],
                ),
              const SizedBox(height: 12),
              Expanded(child: child)]);
          },
        ),
      ),
    );
  }
}


