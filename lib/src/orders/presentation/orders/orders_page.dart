import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_empty_widget.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/inputs/app_text_form_field.dart';
import '../../../../../../material/inputs/date_time_field.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../../material/widgets/riyal_price_text.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_cubit.dart';
import 'utils/get_orders_subscription.dart';

part 'widgets/order_card.dart';
part 'widgets/orders_search_row.dart';
part 'widgets/orders_status_chips.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => injector<OrdersCubit>()..getOrders(), child: const _OrdersBody());
  }
}

class _OrdersBody extends StatefulWidget {
  const _OrdersBody();

  @override
  State<_OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<_OrdersBody> {
  final CompositeSubscription _ordersSubscription = CompositeSubscription();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late final OrdersCubit _cubit;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OrdersCubit>();
    _ordersSubscription.add(
      GetOrdersSubscription.stream().listen((_) {
        _cubit.getOrders();
      }),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (mounted) {
          _cubit.getMoreOrders();
        }
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    _ordersSubscription.dispose();
    super.dispose();
  }

  void _applyParams(GetOrdersParams params) {
    _cubit.updateParams(params);
    _cubit.getOrders();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      final String query = value.trim();
      _applyParams(_cubit.state.params.copyWith(page: 1, search: query, clearSearch: query.isEmpty));
    });
  }

  void _onStatusSelected(OrderStatusEnum? status) {
    _applyParams(_cubit.state.params.copyWith(page: 1, status: status, clearStatus: status == null));
  }

  Future<void> _onDateFilterTapped() async {
    final DateTime now = DateTime.now();
    final DateTime? current = _cubit.state.params.date;
    final DateTime? picked = await AppDateTimePickers.pickDatePicker(
      context,
      initialDate: current ?? now,
      maximumDate: now,
    );
    if (!mounted) return;
    if (picked == null) {
      _onDateFilterCleared();
      return;
    }
    _applyParams(_cubit.state.params.copyWith(page: 1, date: DateTime(picked.year, picked.month, picked.day)));
  }

  void _onDateFilterCleared() {
    if (_cubit.state.params.date == null) return;
    _applyParams(_cubit.state.params.copyWith(page: 1, clearDate: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text(appLocalizer.myOrders)),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16),
                child: _OrdersSearchRow(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  isDateSelected: state.params.date != null,
                  onDateTap: _onDateFilterTapped,
                ),
              ),
              const SizedBox(height: Dimensions.p24),
              _OrdersStatusChips(selected: state.params.status, onSelected: _onStatusSelected),
              const SizedBox(height: Dimensions.p24),
              Expanded(child: _buildListArea(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListArea(OrdersState state) {
    if (state.getOrdersState.isLoading) {
      return const Center(child: SpinKitLoadingWidget());
    }
    if (state.getOrdersState.isFailure) {
      return AppFailWidget(onRetry: _cubit.getOrders);
    }
    if (state.getOrdersState.isSuccess) {
      final List<OrderEntity> data = state.getOrdersState.data ?? [];
      return LiquidPullToRefresh(
        color: AppColors.backgroundColor,
        backgroundColor: AppColors.primary,
        onRefresh: _cubit.getOrders,
        child: data.isEmpty
            ? AppEmptyWidget(
                heightPercentage: 0.48,
                text: appLocalizer.noOrdersFound,
                subText: appLocalizer.noOrdersFoundSub,
                imagePath: AppImages.emptyProducts,
                imageFit: BoxFit.contain,
                imageSize: 200 / 0.7,
                spacing: Dimensions.p32 / 0.7,
                subTextSpacing: Dimensions.p16,
                textStyle: TextStyles.semiBold22.copyWith(color: AppColors.black),
                subTextStyle: TextStyles.regular14.copyWith(color: AppColors.mutedText),
              )
            : Stack(
                children: [
                  ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p96),
                    itemCount: data.length,
                    separatorBuilder: (_, _) => const SizedBox(height: Dimensions.p12),
                    itemBuilder: (context, index) => _OrderCard(entity: data[index]),
                  ),
                  if (state.getOrdersState.isPaginationLoading)
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
    return const SizedBox();
  }
}
