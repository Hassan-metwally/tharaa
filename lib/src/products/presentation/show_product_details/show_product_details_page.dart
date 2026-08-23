import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';

import 'show_product_details_cubit.dart';
import 'utils/show_product_details_subscription.dart';

class ShowProductDetailsPage extends StatelessWidget {
  final int id;
  const ShowProductDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ShowProductDetailsCubit>()..showProductDetails(id),
      child: _ShowProductDetailsBody(id: id),
    );
  }
}

class _ShowProductDetailsBody extends StatefulWidget {
  final int id;
  const _ShowProductDetailsBody({required this.id});

  @override
  State<_ShowProductDetailsBody> createState() => _ShowProductDetailsBodyState();
}

class _ShowProductDetailsBodyState extends State<_ShowProductDetailsBody> {
  final _productSubscriptionObj = CompositeSubscription();
  late final ShowProductDetailsCubit _productCubit;

  void _productSubsriptionListener() {
    _productSubscriptionObj.add(
      ShowProductDetailSubscription.stream().listen((params) {
        _productCubit.showProductDetails(widget.id);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _productCubit = context.read<ShowProductDetailsCubit>();
    _productSubsriptionListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("appLocalizer.ProductDetails")),
      body: BlocBuilder<ShowProductDetailsCubit, ShowProductDetailsState>(
        builder: (context, state) {
          if (state.showProductState.isLoading) {
            return const Center(child: SpinKitLoadingWidget());
          }
          if (state.showProductState.isFailure) {
            return AppFailWidget(onRetry: () => context.read<ShowProductDetailsCubit>().showProductDetails(widget.id));
          }
          if (state.showProductState.isSuccess) {
            final product = state.showProductState.data!;

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
