import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../material/app_fail_widget.dart';
import '../../../../../../../material/media/svg_icon.dart';
import '../../../../../../../material/spin_kit_loading_widget.dart';
import '../statistics_cubit.dart';
import '../utils/get_provider_statistics_subscription.dart';

part 'statistics_card.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<StatisticsCubit>()..getStatistics(), child: const _StatisticsBody());
  }
}

class _StatisticsBody extends StatefulWidget {
  const _StatisticsBody();

  @override
  State<_StatisticsBody> createState() => _StatisticsBodyState();
}

class _StatisticsBodyState extends State<_StatisticsBody> {
  final _statisticsSubscriptionObj = CompositeSubscription();
  late final StatisticsCubit _cubit;

  void _statisticsSubsriptionListener() {
    _statisticsSubscriptionObj.add(
      GetStatisticsSubscription.stream().listen((params) {
        _cubit.getStatistics();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.read<StatisticsCubit>();
    _statisticsSubsriptionListener();
  }

  @override
  void dispose() {
    _statisticsSubscriptionObj.dispose();
    super.dispose();
  }

  Widget child = const SizedBox();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state.getStatisticsState.isLoading) {
          return SizedBox(
            height: 50,
            child: Center(child: SpinKitLoadingWidget(color: AppColors.white)),
          );
        } else if (state.getStatisticsState.isFailure) {
          return SizedBox(height: 50, child: AppFailWidget.mini(onRetry: () => context.read<StatisticsCubit>().getStatistics()));
        } else if (state.getStatisticsState.isSuccess) {
          final data = state.getStatisticsState.data!;
          return SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: _StatisticsCard(
                      title: "",
                      value: data.completedOrdersCount ?? 0,
                      icon: "",
                      color: AppColors.success500,
                      backgroundColor: AppColors.success50,
                    ),
                  ),
                  Expanded(
                    child: _StatisticsCard(
                      title: "",
                      value: data.remainingOrdersCount ?? 0,
                      icon: "",
                      color: AppColors.red600,
                      backgroundColor: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
