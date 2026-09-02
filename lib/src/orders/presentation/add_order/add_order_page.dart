import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../material/buttons/app_button.dart';
import '../../../../../../material/media/svg_icon.dart';
import '../../../../../../material/spin_kit_loading_widget.dart';
import '../../../../../../material/toast/app_toast.dart';
import '../../../../../../material/widgets/riyal_price_text.dart';
import '../../../addresses/presentation/selector_addresses/addresses_list_selector_screen.dart';
import '../../../cart/presentation/utils/cart_subscription.dart';
import '../../domain/entities/checkout_preview_entity.dart';
import 'add_order_cubit.dart';

part 'widgets/checkout_option_chip.dart';
part 'widgets/checkout_coupon_section.dart';
part 'widgets/checkout_invoice_section.dart';

const double _kBottomBarPadding = 32;
const double _kSectionGap = 24;
const double _kTitleContentGap = 12;
const double _kChipHeight = 56;
const double _kCouponControlHeight = 52;
const double _kRadioSize = 32;

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<AddOrderCubit>()..previewCheckout(),
      child: const _AddOrderBody(),
    );
  }
}

class _AddOrderBody extends StatefulWidget {
  const _AddOrderBody();

  @override
  State<_AddOrderBody> createState() => _AddOrderBodyState();
}

class _AddOrderBodyState extends State<_AddOrderBody> {
  late final AddOrderCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AddOrderCubit>();
  }

  bool get _isHomeDelivery => _cubit.state.params.deliveryMethod == 'home_delivery';

  void _onPlaceOrder() {
    final params = _cubit.state.params;
    if (_isHomeDelivery && params.addressId == null) {
      AppToasts.error(context, message: appLocalizer.selectDeliveryAddress);
      return;
    }
    _cubit.addOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text(appLocalizer.completeOrder)),
      body: BlocConsumer<AddOrderCubit, AddOrderState>(
        listener: (context, state) {
          if (state.addOrderState.isSuccess) {
            CartSubscription.pushUpdate(NoParams());
            AppRouter.pop();
            AppToasts.success(context, message: appLocalizer.orderPlacedSuccessfully);
          } else if (state.addOrderState.isFailure) {
            AppToasts.error(context, message: state.addOrderState.errorMessage ?? '');
          } else if (state.applyCouponState.isFailure) {
            AppToasts.error(context, message: state.applyCouponState.errorMessage ?? '');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, Dimensions.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _CheckoutSection(
                        title: appLocalizer.deliveryMethod,
                        child: Row(
                          children: [
                            Expanded(
                              child: _CheckoutOptionChip(
                                label: appLocalizer.homeDelivery,
                                isSelected: state.params.deliveryMethod == 'home_delivery',
                                onTap: () => _cubit.setDeliveryMethod('home_delivery'),
                              ),
                            ),
                            const SizedBox(width: Dimensions.p12),
                            Expanded(
                              child: _CheckoutOptionChip(
                                label: appLocalizer.storePickup,
                                isSelected: state.params.deliveryMethod == 'pickup',
                                onTap: () => _cubit.setDeliveryMethod('pickup'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isHomeDelivery) ...[
                        const SizedBox(height: _kSectionGap),
                        AddressesListSelectorWidget(
                          selectedAddressId: state.params.addressId,
                          onAddressSelected: _cubit.setAddressId,
                        ),
                      ],
                      const SizedBox(height: _kSectionGap),
                      _CheckoutSection(
                        title: appLocalizer.paymentMethod,
                        child: Row(
                          children: [
                            Expanded(
                              child: _CheckoutOptionChip(
                                label: appLocalizer.electronicShort,
                                isSelected: state.params.paymentMethod == 'electronic',
                                onTap: () => _cubit.setPaymentMethod('electronic'),
                                iconPath: AppIcons.card,
                              ),
                            ),
                            const SizedBox(width: Dimensions.p12),
                            Expanded(
                              child: _CheckoutOptionChip(
                                label: appLocalizer.cash,
                                isSelected: state.params.paymentMethod == 'cash',
                                onTap: () => _cubit.setPaymentMethod('cash'),
                                iconPath: AppIcons.money,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: _kSectionGap),
                      _CheckoutCouponSection(
                        controller: state.params.couponCode,
                        isLoading: state.applyCouponState.isLoading,
                        onApply: _cubit.applyCoupon,
                      ),
                      const SizedBox(height: _kSectionGap),
                      if (state.previewState.isLoading && !state.previewState.isSuccess)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.p24),
                          child: Center(child: SpinKitLoadingWidget()),
                        )
                      else
                        _CheckoutInvoiceSection(preview: state.preview),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.p16, Dimensions.p24, Dimensions.p16, _kBottomBarPadding),
                  child: AppButton(
                    isLoading: state.addOrderState.isLoading,
                    text: appLocalizer.placeOrder,
                    textStyle: TextStyles.semiBold18.copyWith(color: AppColors.white, height: 1, fontWeight: FontWeight.w600),
                    onPressed: _onPlaceOrder,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 28,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: TextStyles.semiBold16.copyWith(color: AppColors.black900, height: 1, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: _kTitleContentGap),
        child,
      ],
    );
  }
}
