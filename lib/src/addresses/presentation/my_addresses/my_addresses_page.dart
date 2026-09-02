import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../../../material/app_fail_widget.dart';
import '../../../../material/media/svg_icon.dart';
import '../../../../material/spin_kit_loading_widget.dart';
import '../../domain/entities/location_entity.dart';
import '../upsert_address/upsert_address_page.dart';
import '../utils/products_subscription.dart';
import '../widgets/address_tile.dart';
import '../widgets/empty_addresses_list_body.dart';
import 'my_addresses_cubit.dart';

const double _kAddIconSize = 18;

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
    _scrollController.dispose();
    _productsSubscriptionObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(appLocalizer.myAddresses),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: Dimensions.p16),
            child: Center(
              child: _AddAddressButton(isRtl: isRtl, onTap: () => UpssertAddressBottomSheet.show(context)),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyAddressesCubit, MyAddressesState>(
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p12, Dimensions.p16, Dimensions.p16),
                      itemCount: state.getMyAddressesState.data!.length,
                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.p12),
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
    );
  }
}

class _AddAddressButton extends StatelessWidget {
  const _AddAddressButton({required this.isRtl, required this.onTap});

  final bool isRtl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Widget label = Text(appLocalizer.addAddress, style: TextStyles.medium12.copyWith(color: AppColors.black900, height: 1));
    final Widget icon = AppSvgIcon(path: AppIcons.add, width: _kAddIconSize, height: _kAddIconSize, color: AppColors.black900);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.p10),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: kAddressCardFill, borderRadius: BorderRadius.circular(80)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: isRtl ? [label, const SizedBox(width: Dimensions.p4), icon] : [icon, const SizedBox(width: Dimensions.p4), label],
        ),
      ),
    );
  }
}
