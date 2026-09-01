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

import '../../../../material/buttons/app_button.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';

import '../../domain/entities/category_entity.dart';

import '../../domain/usecases/get_sub_categories_usecase.dart';

import 'sub_categories_cubit.dart';
import 'utils/get_sub_categories_subscription.dart';

part 'widgets/sub_category_card.dart';

part 'widgets/sub_categories_filter_bottomsheet.dart';

class SubCategoriesPage extends StatelessWidget {
  final int categoryId;

  const SubCategoriesPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SubCategoriesCubit>()
        ..updateParams(GetSubCategoriesParams.initial(categoryId: categoryId))
        ..getSubCategories(),
      child: const _SubCategoriesBody(),
    );
  }
}

class _SubCategoriesBody extends StatefulWidget {
  const _SubCategoriesBody();

  @override
  State<_SubCategoriesBody> createState() => _SubCategoriesBodyState();
}

class _SubCategoriesBodyState extends State<_SubCategoriesBody> {
  final _subCategoriesSubscriptionObj = CompositeSubscription();
  late final SubCategoriesCubit _cubit;

  void _subCategoriesSubsriptionListener() {
    _subCategoriesSubscriptionObj.add(
      GetSubCategoriesSubscription.stream().listen((params) {
        _cubit.getSubCategories();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SubCategoriesCubit>();
    _subCategoriesSubsriptionListener();
  }

  @override
  void dispose() {
    _subCategoriesSubscriptionObj.dispose();
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
              // AppRouter.pushNamed('', arguments: const UpsertCategoryPage());
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
        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
          builder: (context, state) {
            if (state.getSubCategoriesState.isLoading) {
              child = const SpinKitLoadingWidget();
            } else if (state.getSubCategoriesState.isFailure) {
              child = AppFailWidget(onRetry: () => context.read<SubCategoriesCubit>().getSubCategories());
            } else if (state.getSubCategoriesState.isSuccess) {
              final List<CategoryEntity> data = state.getSubCategoriesState.data!;
              child = LiquidPullToRefresh(
                color: AppColors.backgroundColor,
                backgroundColor: AppColors.primary,
                onRefresh: () {
                  return context.read<SubCategoriesCubit>().getSubCategories();
                },
                child: data.isEmpty
                    ? const AppEmptyWidget()
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _SubCategoryCard(entity: data[index]),
                        itemCount: data.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                      ),
              );
            }
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("appLocalizer.", style: TextStyles.medium16)),

                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () =>
                          _SubCategoriesFilterBottomSheet.show(context: context, subCategoriesCubit: context.read<SubCategoriesCubit>()),
                      child: AppSvgIcon(path: "AppIcons.documentFilter"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: child),
              ],
            );
          },
        ),
      ),
    );
  }
}
