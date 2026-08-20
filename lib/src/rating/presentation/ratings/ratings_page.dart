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

import '../../domain/entities/rate_entity.dart';

import '../../domain/usecases/get_ratings_usecase.dart';

import 'ratings_cubit.dart';
import 'utils/get_ratings_subscription.dart';

part 'widgets/rate_card.dart';

part 'widgets/ratings_filter_bottomsheet.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<RatingsCubit>()..getRating(), child: const _RatingsBody());
  }
}

class _RatingsBody extends StatefulWidget {
  const _RatingsBody();

  @override
  State<_RatingsBody> createState() => _RatingsBodyState();
}

class _RatingsBodyState extends State<_RatingsBody> {
  final _ratingSubscriptionObj = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  late final RatingsCubit _cubit;

  void _ratingSubsriptionListener() {
    _ratingSubscriptionObj.add(
      GetRatingsSubscription.stream().listen((params) {
        _cubit.getRating();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RatingsCubit>();
    _ratingSubsriptionListener();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.getMoreRating();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ratingSubscriptionObj.dispose();
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
              // AppRouter.pushNamed('', arguments: const UpsertRatePage());
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
        child: BlocBuilder<RatingsCubit, RatingsState>(
          builder: (context, state) {
            if (state.getRatingState.isLoading) {
              child = const SpinKitLoadingWidget();
            } else if (state.getRatingState.isFailure) {
              child = AppFailWidget(onRetry: () => context.read<RatingsCubit>().getRating());
            } else if (state.getRatingState.isSuccess) {
              final List<RateEntity> data = state.getRatingState.data!;
              child = LiquidPullToRefresh(
                color: AppColors.backgroundColor,
                backgroundColor: AppColors.primary,
                onRefresh: () {
                  return context.read<RatingsCubit>().getRating();
                },
                child: data.isEmpty
                    ? const AppEmptyWidget()
                    : Stack(
                        children: [
                          ListView.separated(
                            controller: _scrollController,

                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _RateCard(entity: data[index]),
                            itemCount: data.length,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => const SizedBox(height: 8),
                          ),

                          if (state.getRatingState.isPaginationLoading)
                            const Positioned(
                              bottom: -10,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Padding(padding: EdgeInsets.symmetric(vertical: 20), child: SpinKitLoadingWidget()),
                              ),
                            ),
                        ],
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
                      onTap: () => _RatingsFilterBottomSheet.show(context: context, ratingCubit: context.read<RatingsCubit>()),
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
