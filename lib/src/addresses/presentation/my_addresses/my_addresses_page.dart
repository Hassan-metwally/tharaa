import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/router/app_routes.dart';
import '../../../../core/core.dart';
import '../../../../core/di/di.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/buttons/app_button.dart';
import '../../../../material/media/app_image.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/overlay/show_modal_bottom_sheet.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../../../material/toast/app_toast.dart';
import '../../../google_maps/domain/entities/address_entity.dart';
import '../../../google_maps/presentation/maps_main_page.dart';
import '../../../google_maps/utils/maps_constants.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/delete_location_use_case.dart';
import '../upsert_address/upsert_address_page.dart';
import '../utils/products_subscription.dart';
import '../widgets/empty_addresses_list_body.dart';
import 'my_addresses_cubit.dart';

part 'widgets/addresses_tile.dart';
part 'widgets/remove_address_bottom_sheet.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  final ScrollController _scrollController = ScrollController();

  final _productsSubscriptionObj = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    _productsSubscriptionObj.add(
      MyAddressesSubscription.stream().listen((params) {
        if (mounted) {
          context.read<MyAddressesCubit>().getAddresses();
        }
      }),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        context.read<MyAddressesCubit>().getMoreAddresses();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizer.myAddresses, style: TextStyles.bold16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.appbarBorderColor, // border color
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(appLocalizer.savedAddresses, style: TextStyles.medium14)),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    UpssertAddressBottomSheet.show(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary50,
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      children: [
                        AppSvgIcon(path: ""),
                        const SizedBox(width: 8),
                        Text(appLocalizer.addAddress, style: TextStyles.regular12.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<MyAddressesCubit, MyAddressesState>(
                builder: (context, state) {
                  if (state.getMyAddressesState.isLoading) {
                    return const SpinKitLoadingWidget();
                  } else if (state.getMyAddressesState.isFailure) {
                    return AppFailWidget(onRetry: () => BlocProvider.of<MyAddressesCubit>(context).getAddresses());
                  } else if (state.getMyAddressesState.isSuccess) {
                    return LiquidPullToRefresh(
                      backgroundColor: AppColors.primary,
                      color: AppColors.backgroundColor,
                      onRefresh: () async => BlocProvider.of<MyAddressesCubit>(context).getAddresses(),
                      child: state.getMyAddressesState.data!.isEmpty
                          ? const EmptyAddressesListBody()
                          : ListView.separated(
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state.getMyAddressesState.data!.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final LocationEntity address = state.getMyAddressesState.data![index];
                                return AddressTile(entity: address);
                              },
                            ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
