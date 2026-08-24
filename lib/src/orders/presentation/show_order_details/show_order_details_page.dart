import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';

import 'show_order_details_cubit.dart';
import 'utils/show_order_details_subscription.dart';

class ShowOrderDetailsPage extends StatelessWidget {
  final int id;
  const ShowOrderDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ShowOrderDetailsCubit>()..showOrderDetails(id),
      child: _ShowOrderDetailsBody(id: id),
    );
  }
}

class _ShowOrderDetailsBody extends StatefulWidget {
  final int id;
  const _ShowOrderDetailsBody({required this.id});

  @override
  State<_ShowOrderDetailsBody> createState() => _ShowOrderDetailsBodyState();
}

class _ShowOrderDetailsBodyState extends State<_ShowOrderDetailsBody> {
  final _orderSubscriptionObj = CompositeSubscription();
  late final ShowOrderDetailsCubit _orderCubit;

  void _orderSubsriptionListener() {
    _orderSubscriptionObj.add(
      ShowOrderDetailSubscription.stream().listen((params) {
        _orderCubit.showOrderDetails(widget.id);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _orderCubit = context.read<ShowOrderDetailsCubit>();
    _orderSubsriptionListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("appLocalizer.OrderDetails")),
      body: BlocBuilder<ShowOrderDetailsCubit, ShowOrderDetailsState>(
        builder: (context, state) {
          if (state.showOrderState.isLoading) {
            return const Center(child: SpinKitLoadingWidget());
          }
          if (state.showOrderState.isFailure) {
            return AppFailWidget(onRetry: () => context.read<ShowOrderDetailsCubit>().showOrderDetails(widget.id));
          }
          if (state.showOrderState.isSuccess) {
            final order = state.showOrderState.data!;

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
                    child: const SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [BoxShadow(color: AppColors.black500.withAlpha(10), offset: const Offset(.6, 0), blurRadius: 4)],
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  ),
                  child: Row(children: []),
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
