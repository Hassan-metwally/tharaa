import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/config/router/app_routes.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/app_fail_widget.dart';
import '../../../../../../material/media/app_image.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../../material/widgets/riyal_price_text.dart';
import '../../../addresses/domain/entities/location_entity.dart';
import '../../../common/domain/enums/orders/order_status_enum.dart';
import '../../../google_maps/domain/entities/address_entity.dart';
import '../../../google_maps/presentation/maps_main_page.dart';
import '../../../google_maps/utils/maps_constants.dart';
import '../../../rating/presentation/add_rate/add_rate_page.dart';
import '../../domain/entities/order_details_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import 'show_order_details_cubit.dart';
import 'utils/show_order_details_subscription.dart';

part 'widgets/delivery_address_section.dart';
part 'widgets/order_details_bottom_bar.dart';
part 'widgets/order_details_header.dart';
part 'widgets/order_info_card.dart';
part 'widgets/ordered_products_section.dart';
part 'widgets/price_details_section.dart';

const double _kHeaderTopPadding = 20;
const double _kHeaderBottomPadding = 24;
const double _kBackButtonSize = 48;
const double _kBackIconSize = 24;
const double _kMapHeight = 124;
const double _kActionButtonHeight = 50;

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
  void dispose() {
    _orderSubscriptionObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const _OrderDetailsHeader(),
            Expanded(
              child: BlocBuilder<ShowOrderDetailsCubit, ShowOrderDetailsState>(
                builder: (context, state) {
                  if (state.showOrderState.isLoading) {
                    return const Center(child: SpinKitLoadingWidget());
                  }
                  if (state.showOrderState.isFailure) {
                    return AppFailWidget(onRetry: () => context.read<ShowOrderDetailsCubit>().showOrderDetails(widget.id));
                  }
                  if (state.showOrderState.isSuccess) {
                    final order = state.showOrderState.data!;
                    return _OrderDetailsContent(order: order);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderDetailsContent extends StatelessWidget {
  const _OrderDetailsContent({required this.order});

  final OrderDetailsEntity order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(Dimensions.p16, 0, Dimensions.p16, Dimensions.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Dimensions.p16,
              children: [
                _OrderInfoCard(order: order),
                if (order.address != null) _DeliveryAddressSection(address: order.address!),
                if (order.items.isNotEmpty) _OrderedProductsSection(items: order.items),
                _PriceDetailsSection(order: order),
              ],
            ),
          ),
        ),
        _OrderDetailsBottomBar(order: order),
      ],
    );
  }
}
